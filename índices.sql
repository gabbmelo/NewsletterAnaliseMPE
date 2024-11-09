--consultando-se índices nas tabelas:
SELECT
    INDEX_NAME,
    VISIBILITY
FROM
    USER_INDEXES
WHERE
    TABLE_NAME = 'DIM_PRODUTO' OR
    TABLE_NAME = 'DIM_TEMPO' OR
    TABLE_NAME = 'FACT_TICKET';

--criando-se o índice nas colunas de chaves estrangeiras, como manda a boa prática:
CREATE INDEX
    FK_DATE_INDEX
ON
    FACT_TICKET(FK_DATE);

CREATE INDEX
    FK_PRODUCT_INDEX
ON
    FACT_TICKET(FK_PRODUCT);

--verificando o resultado das operações:
SELECT
    INDEX_NAME,
    VISIBILITY
FROM
    USER_INDEXES
WHERE
    TABLE_NAME = 'DIM_PRODUTO' OR
    TABLE_NAME = 'DIM_TEMPO' OR
    TABLE_NAME = 'FACT_TICKET';