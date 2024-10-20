--verificando o nome das constraints:
SELECT
    CONSTRAINT_NAME,
    INDEX_NAME
FROM
    USER_CONSTRAINTS
WHERE
    TABLE_NAME= 'FACT_TICKET';

--depois do SQL Developer retornar a consulta, eliminamos as constraints pelo nome do sistema;

--tabela de fatos:
ALTER TABLE
    FACT_TICKET
DROP
    CONSTRAINT SYS_C007732;

ALTER TABLE
    FACT_TICKET
DROP
    CONSTRAINT SYS_C007733;

ALTER TABLE
    FACT_TICKET
DROP
    CONSTRAINT SYS_C007734;

--dimensão produto:
SELECT
    CONSTRAINT_NAME,
    INDEX_NAME
FROM
    USER_CONSTRAINTS
WHERE
    TABLE_NAME= 'DIM_PRODUTO';

ALTER TABLE
    DIM_PRODUTO
DROP
    CONSTRAINT SYS_C007731;

--dimensão tempo
SELECT
    CONSTRAINT_NAME,
    INDEX_NAME
FROM
    USER_CONSTRAINTS
WHERE
    TABLE_NAME= 'DIM_TEMPO';

ALTER TABLE
    DIM_TEMPO
DROP
    CONSTRAINT SYS_C007730;

