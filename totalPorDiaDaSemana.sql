/*CREATED BY: Gabriel Melo
CREATED ON: 2024/12/07
DESCRIPTION:
1 - db = Gabriel
2 - tbl = dim_tempo, fact_ticket
3 - fields = dim_tempo(pk_date, DAY_ID), fact_ticket(fk_date, revenues, quantity)
4 - filters = NO; exclusions = NO;
5 - This query returns total product quantity and revenues per day of the week for the
entirety of the covered period (2022/2023)
*/
SELECT
    TO_CHAR(t.DAY_ID, 'D') "Dia da semana",
    TO_CHAR(t.DAY_ID, 'Dy') "Nome do dia",
    SUM(f.REVENUES) "Receita total",
    SUM(f.QUANTITY) "Quantidade total"
FROM
    dim_tempo t
JOIN
    fact_ticket f
ON
    t.pk_date =f.fk_date
GROUP BY
    TO_CHAR(DAY_ID, 'D'),
    TO_CHAR(t.DAY_ID, 'Dy')
ORDER BY
    1;