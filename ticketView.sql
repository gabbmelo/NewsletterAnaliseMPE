/*CREATED BY: Gabriel Melo
CREATED ON: 2024/12/14
DESCRIPTION:
1 - db = Gabriel
2 - tbl = dim_tempo, fact_ticket
3 - fields = dim_tempo(fk_date, SALE_ID), fact_ticket(fk_date, revenues, quantity)
4 - filters = NO; exclusions = NO;
5 - This query creates a view called TICKET
*/

--VIEW DE TICKET
CREATE OR REPLACE VIEW Ticket AS
SELECT
    TKT.FK_DATE fk_data,
    TKT.FK_DATE_REF Data, 
    TKT.PK_SALE_ID Ticket,
    sum(TKT.QUANTITY) Quantidade,
    sum(TKT.REVENUES) Receita
FROM
    FACT_TICKET TKT
GROUP BY
    TKT.FK_DATE,
    TKT.PK_SALE_ID,
    TKT.FK_DATE_REF
ORDER BY
    1;

--Descrevendo a view
desc ticket;

/* READ ME 
CREATED BY: Gabriel Melo
CREATED ON: 2024/12/07
DESCRIPTION:
1 - db = Gabriel
2 - tbl = dim_tempo, ticket
3 - fields = dim_tempo(pk_date, month_of_the_year), ticket(fk_data, revenues, quantity)
4 - filters = NO; exclusions = NO;
5 - This query returns average ticket revenue per year and month of year for the
entirety of the covered period (2022/2023)
*/


SELECT
    tmp.YEAR_ID "Ano",
    tmp.MONTH_OF_YEAR "Mês",
    round(avg(TKT.RECEITA),2) "Ticket médio"
FROM
    dim_tempo tmp
JOIN
    ticket tkt
ON
    tmp.pk_date = TKT.fk_data
GROUP BY
    tmp.MONTH_OF_YEAR,
    tmp.YEAR_ID
ORDER BY
    1, 2;

/* READ ME 
CREATED BY: Gabriel Melo
CREATED ON: 2024/12/07
DESCRIPTION:
1 - db = Gabriel
2 - tbl = dim_tempo, ticket
3 - fields = dim_tempo(pk_date, month_of_the_year), ticket(fk_data, revenues, quantity)
4 - filters = NO; exclusions = NO;
5 - This query returns ticket counts per year and month of year for the
entirety of the covered period (2022/2023)
*/

SELECT
    tmp.YEAR_ID "Ano",
    tmp.MONTH_OF_YEAR "Mês",
    COUNT(TKT.TICKET ) "Contagem de tickets"
FROM
    dim_tempo tmp
JOIN
    ticket tkt
ON
    tmp.pk_date = TKT.fk_data
GROUP BY
    tmp.MONTH_OF_YEAR,
    tmp.YEAR_ID
ORDER BY
    1, 2;
    