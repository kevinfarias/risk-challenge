-- Retornar total de entrada e saída de dinheiro de cada mês do ano atual (versão otimizada)
select to_char(pa.date, 'MM') as mes, sum(pa.total_positive) as total_entrada, sum(pa.total_negative) as total_saida
from daily_balance pa
where to_char(pa.date, 'YYYY') = to_char(CURRENT_TIMESTAMP, 'YYYY')
group by to_char(pa.date, 'MM');

-- Retornar total de entrada e saída de dinheiro de cada mês do ano atual (versão náo otimizada)
select to_char(pa.transaction_date, 'MM') as mes, sum(case when pa.type_id in (1) then pa.value else 0 end) as total_entrada, sum(case when pa.type_id in (2,3) then pa.value else 0 end) as total_saida
from transaction pa
where to_char(pa.transaction_date, 'YYYY') = to_char(CURRENT_TIMESTAMP, 'YYYY')
group by to_char(pa.transaction_date, 'MM');
