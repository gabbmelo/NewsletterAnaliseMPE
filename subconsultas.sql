/*CREATED BY: Gabriel Melo
CREATED ON: 2024/12/27
DESCRIPTION:
1 - db = Gabriel
2 - tbl = ticket, produto, fact_ticket
3 - fields = dim_produto(pk_product, product_description), ticket (ticket, receita),
fact_ticket(sale_id, fk_product, revenues)
4 - filters = year of 2023; exclusions = only top 10 by revenue showed;
5 - This query lists the top 10 products by revenue in sale tickets 
valued above the average ticket's for the year 2023
*/
SELECT
    p.product_description product,
    sum(f.revenues) revenues
FROM
    dim_produto p
JOIN
    fact_ticket f
ON
    p.pk_product = f.fk_product
WHERE
    extract (year from f.fk_date_ref) = 2023
    AND
    f.pk_sale_id in (SELECT TICKET FROM TICKET WHERE RECEITA > (SELECT ROUND(AVG(RECEITA), 2) FROM TICKET))
GROUP BY
    p.product_description
ORDER BY
    2 DESC
FETCH FIRST 10 ROWS ONLY;


--encontrando o valor do ticket médio para o biênio 2022-23:
SELECT ROUND(AVG(RECEITA), 2) AS "TICKET MÉDIO" FROM TICKET;

--sub consulta escalar com o valor do ticket médio para o biênio:
SELECT TICKET FROM TICKET WHERE RECEITA > (SELECT ROUND(AVG(RECEITA), 2) FROM TICKET);

--melhorando a exibição do texto de descrição dos produtos na tabela produtos:
select product_description from dim_produto;

UPDATE
    dim_produto
SET
    product_description = trim(product_description);

commit;




