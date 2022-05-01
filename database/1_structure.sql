CREATE TABLE transaction_type (
    id integer not null primary key,
    name character varying(255) not null
);

CREATE TABLE client (
    id bigserial not null primary key,
    name character varying(255) not null,
    document bigint not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    CONSTRAINT uk_client UNIQUE (document)
);

CREATE TABLE account (
    id bigserial not null primary key,
    client_id integer not null,
    is_active boolean not null default true,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    CONSTRAINT fk_account_client foreign key (client_id) references client (id)
);

CREATE TABLE transaction (
    id bigserial not null primary key,
    account_from_id integer not null,
    type_id integer not null,
    value numeric(15, 2) not null,
    account_to_id integer,
    transaction_date timestamp not null,
    description varchar(255),
    CONSTRAINT fk_transaction_to_type foreign key (type_id) references transaction_type (id),
    CONSTRAINT fk_transaction_to_account_from foreign key (account_from_id) references account (id),
    CONSTRAINT fk_transaction_to_account_to foreign key (account_to_id) references account (id)
);

CREATE INDEX ix_transaction_account on transaction USING HASH (account_from_id);
CREATE INDEX ix_transaction_date on transaction USING BRIN (transaction_date);

CREATE TABLE daily_balance (
    account_id integer not null,
    date date not null,
    balance numeric(15, 2) not null default 0,
    total_positive numeric(15, 2) not null default 0,
    total_negative numeric(15,2)  not null default 0,
    CONSTRAINT fk_daily_balance_to_account foreign key (account_id) references account (id),
    CONSTRAINT uk_daily_balance UNIQUE (account_id, date)
);

-- Triggers/procedures
CREATE OR REPLACE FUNCTION calculate_daily_balance()
RETURNS trigger as $DailyBalanceCalculation$
BEGIN

INSERT INTO daily_balance (account_id, date, balance) values (coalesce(NEW.account_from_id, OLD.account_from_id), cast(coalesce(NEW.transaction_date, OLD.transaction_date) as date), 0) ON CONFLICT DO NOTHING;

UPDATE daily_balance
SET 
    balance = coalesce((select sum(case pa.type_id when 1 then pa.value when 2 then -pa.value when 3 then -pa.value end) from transaction pa where pa.account_from_id = coalesce(NEW.account_from_id, OLD.account_from_id) and pa.transaction_date <= date_trunc('day', coalesce(NEW.transaction_date, OLD.transaction_date)) + interval '23:59:59'), 0),
    total_positive = coalesce((select sum(case pa.type_id when 1 then pa.value when 2 then 0 when 3 then 0 end) from transaction pa where pa.account_from_id = coalesce(NEW.account_from_id, OLD.account_from_id) and pa.transaction_date between date_trunc('day', coalesce(NEW.transaction_date, OLD.transaction_date)) and date_trunc('day', coalesce(NEW.transaction_date, OLD.transaction_date)) + interval '23:59:59'), 0),
    total_negative = coalesce((select sum(case pa.type_id when 1 then 0 when 2 then pa.value when 3 then pa.value end) from transaction pa where pa.account_from_id = coalesce(NEW.account_from_id, OLD.account_from_id) and pa.transaction_date between date_trunc('day', coalesce(NEW.transaction_date, OLD.transaction_date)) and date_trunc('day', coalesce(NEW.transaction_date, OLD.transaction_date)) + interval '23:59:59'), 0)
WHERE account_id = coalesce(NEW.account_from_id, OLD.account_from_id) and date = cast(coalesce(NEW.transaction_date, OLD.transaction_date) as date);

RETURN NEW;
END;
$DailyBalanceCalculation$ LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER after_insert_transaction
AFTER INSERT ON transaction
FOR EACH ROW
EXECUTE PROCEDURE calculate_daily_balance();

CREATE TRIGGER after_update_transaction
AFTER UPDATE ON transaction
FOR EACH ROW
EXECUTE PROCEDURE calculate_daily_balance();

CREATE TRIGGER after_delete_transaction
AFTER DELETE ON transaction
FOR EACH ROW
EXECUTE PROCEDURE calculate_daily_balance();