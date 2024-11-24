--experimentando selfjoins:
SELECT
    TRIM(P.PRODUCT_DESCRIPTION) "Produto",
    C.CATEGORY_DESCRIPTION "Categoria"
FROM
    dim_produto P
JOIN
    dim_produto C
ON
    P.PK_PRODUCT = C.PK_PRODUCT;
    
--inserindo as classes:
SELECT
    L.CLASS_DESCRIPTION "Classe",
    C.CATEGORY_DESCRIPTION "Categoria",
    TRIM(P.PRODUCT_DESCRIPTION) "Produto"   
FROM
    dim_produto L
JOIN
    dim_produto C
ON
    L.PK_PRODUCT = C.PK_PRODUCT
JOIN
    dim_produto P
ON
    P.PK_PRODUCT = C.PK_PRODUCT
ORDER BY
    L.CLASS_DESCRIPTION,
    C.CATEGORY_DESCRIPTION;