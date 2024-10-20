--descrevendo as tabelas de dimensão produto interna e externa:
DESC DIM_PRODUTO;
DESC DIM_PRODUTO_EXT;

--inserindo os valores na tabela interna da dimensão produto:
INSERT INTO dim_produto(
    pk_product,
    product_id_input_level,
    product_description,
    category_description,
    class_id,
    class_description
    )
SELECT
    pk_product,
    product_id_input_level,
    product_description,
    category_description,
    class_id,
    class_description
FROM
    dim_produto_ext;

--verificando o resultado da inserção:
SELECT * FROM dim_produto_ext;

SELECT * FROM dim_produto;

--removendo as tabelas de dimensão tempo com a estrutura errada:
DROP TABLE DIM_TEMPO;
DROP TABLE DIM_TEMPO_EXT;

-- recriando as tabelas de tempo com a estrutura correta:
CREATE TABLE dim_tempo_ext(
    pk_date NUMBER,
    date_input_level VARCHAR2(200),
    year_id NUMBER,
    month_of_year NUMBER,
    week_of_year NUMBER,
    weekday NUMBER,   
    day_id VARCHAR2(200),
    day_of_year NUMBER,
    hour_id NUMBER
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EXTERNAL_DIR
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        )
    LOCATION ('dimensaoTempo.csv')
);

CREATE TABLE dim_tempo(
    pk_date NUMBER,
    date_input_level TIMESTAMP,
    year_id NUMBER,
    month_of_year NUMBER,
    week_of_year NUMBER,
    weekday NUMBER,   
    day_id DATE,
    day_of_year NUMBER,
    hour_id NUMBER
);


--descrevendo as tabelas de dimensão tempo interna e externa:
DESC DIM_TEMPO;
DESC DIM_TEMPO_EXT;

--inserindo os valores na tabela interna da dimensão tempo:

INSERT INTO dim_tempo(
    PK_DATE,
    DATE_INPUT_LEVEL,
    DAY_OF_YEAR,
    WEEK_OF_YEAR,
    MONTH_OF_YEAR,
    YEAR_ID,
    WEEKDAY,
    DAY_ID,
    HOUR_ID
    )
SELECT
    PK_DATE,
    TO_DATE(DATE_INPUT_LEVEL),
    DAY_OF_YEAR,
    WEEK_OF_YEAR,
    MONTH_OF_YEAR,
    YEAR_ID,
    WEEKDAY,
    TO_DATE(DAY_ID),
    HOUR_ID
FROM
    DIM_TEMPO_EXT;
    
--verificando o resultado da inserção:
SELECT
    COUNT(*) 
FROM
    dim_tempo_ext;
    
SELECT
    *
FROM
    dim_tempo;

--removendo as tabelas de fato com a estrutura errada:
DROP TABLE fact_ticket;
DROP TABLE fact_ticket_ext;

-- recriando as tabelas de fato com a estrutura correta:
CREATE TABLE fact_ticket_ext(
    pk_fact_index VARCHAR2(200),
    fk_date VARCHAR2(200),
    pk_sale_id VARCHAR2(200),
    fk_product VARCHAR2(200),
    Place_or_Sale VARCHAR2(200),
    Payment_Type VARCHAR2(200),
    Payment_Method VARCHAR2(200),
    Revenues NUMBER,
    Quantity NUMBER
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EXTERNAL_DIR
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        )
    LOCATION ('TabelaFatos.csv')
);

CREATE TABLE fact_ticket (
    pk_fact_index NUMBER,
    fk_date TIMESTAMP,
    pk_sale_id NUMBER,
    fk_product VARCHAR2(10),
    Place_or_Sale VARCHAR2(200),
    Payment_Type VARCHAR2(200),
    Payment_Method VARCHAR2(200),
    Revenues NUMBER,
    Quantity NUMBER
);


--descrevendo as tabelas de fato interna e externa:
DESC fact_ticket;
DESC fact_ticket_ext;

--inserindo os valores na tabela de fatos interna:
INSERT INTO fact_ticket(
    PK_FACT_INDEX,
    FK_DATE,
    PK_SALE_ID,
    FK_PRODUCT,
    PLACE_OR_SALE,
    PAYMENT_TYPE,
    PAYMENT_METHOD,
    REVENUES,
    QUANTITY
    )
SELECT
    PK_FACT_INDEX,
    TO_DATE(FK_DATE),
    PK_SALE_ID,
    FK_PRODUCT,
    PLACE_OR_SALE,
    PAYMENT_TYPE,
    PAYMENT_METHOD,
    REVENUES,
    QUANTITY
FROM
    fact_ticket_ext;

--verificando o resultado da inserção:
SELECT * FROM fact_ticket_ext;

SELECT * FROM fact_ticket;
