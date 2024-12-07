/*CREATED BY: Gabriel Melo
CREATED ON: 2024/12/07
DESCRIPTION:
1 - db = Gabriel
2 - tbl = dim_tempo, fact_ticket
3 - fields = dim_tempo(pk_date, hour_id), fact_ticket(fk_date, revenues, quantity)
4 - filters = NO; exclusions = NO;
5 - This query returns total product quantity and revenues per hour 
for the entirety of the covered period (2022/2023)
*/
SELECT
    t.HOUR_ID "Hora do dia",
    SUM(f.REVENUES) "Receita total",
    SUM(f.QUANTITY) "Quantidade total"
FROM
    dim_tempo t
JOIN
    fact_ticket f
ON
    t.pk_date =f.fk_date
GROUP BY
    t.HOUR_ID
ORDER BY
    1;