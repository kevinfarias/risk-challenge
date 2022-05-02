-- Default values
INSERT INTO transaction_type values (1, 'Depósito'), (2, 'Saque'), (3, 'Transferência');

-- Test values
INSERT INTO client (id, name, document, created_at) values (1, 'Kevin Farias', 123456789, CURRENT_TIMESTAMP);

INSERT INTO account (id, client_id, is_active, created_at) values (1, 1, true, CURRENT_TIMESTAMP);

INSERT INTO transaction (account_from_id, type_id, value, transaction_date, description) VALUES
(1, 1, 1000, '2022-01-01', 'Depósito ao abrir a conta'),
(1, 1, 1000, '2022-02-01', 'Depósito segundo depósito'),
(1, 2, 300, '2022-03-01', 'Saque'),
(1, 1, 200, '2022-04-01', 'Depósito'),
(1, 3, 550, '2022-05-01', 'Transferência');
