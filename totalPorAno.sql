/* READ ME 
CREATED BY: Gabriel Melo
CREATED ON: 2024/12/07
DESCRIPTION:
1 - db = Gabriel
2 - tbl = dim_tempo, fact_ticket
3 - fields = dim_tempo(pk_date, year_id), fact_ticket(fk_date, revenues, quantity)
4 - filters = NO; exclusions = NO;
5 - This query returns total product quantity and revenues per year
*/
SELECT
    t.YEAR_ID Ano,
    AVG(f.REVENUES) Receita,
    AVG(f.QUANTITY) Quantidade
FROM
    dim_tempo t
JOIN
    fact_ticket f
ON
    t.pk_date =f.fk_date
GROUP BY
    t.YEAR_ID
ORDER BY
    1;
    