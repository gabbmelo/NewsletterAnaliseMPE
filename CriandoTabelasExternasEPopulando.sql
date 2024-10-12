--criando diret�rio externo:

CREATE OR REPLACE DIRECTORY EXTERNAL_DIR AS 'C:\app\oracle\external';

--verificando se o diret�rio foi criado corretamente
SELECT DIRECTORY_NAME, DIRECTORY_PATH FROM DBA_DIRECTORIES WHERE DIRECTORY_NAME='EXTERNAL_DIR';

--dando permiss�o de acesso para o usu�rio:
GRANT READ, WRITE ON DIRECTORY EXTERNAL_DIR TO PUBLIC;

--criando uma tabela externa para cada arquivo csv:

CREATE TABLE DIM_PRODUTO_EXT (
    PK_PRODUCT NUMBER,
    PRODUCT_ID_INPUT_LEVEL VARCHAR2(200),
    PRODUCT_DESCRIPTION VARCHAR2(200),
    CATEGORY_DESCRIPTION VARCHAR2(200),
    CLASS_ID CHAR(1),
    CLASS_DESCRIPTION VARCHAR2(200)
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EXTERNAL_DIR
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        )
    LOCATION ('dimensaoProduto.csv')
);

CREATE TABLE dim_tempo_ext (
    pk_date NUMBER,
    date_input_level VARCHAR2(200),
    day_of_year NUMBER,
    week_of_year NUMBER,
    month_of_year NUMBER,
    year_id NUMBER,
    weekday VARCHAR2(200),
    day_id NUMBER,
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


CREATE TABLE fact_ticket_ext(
    pk_fact_index VARCHAR2(200),
    pk_sale_id VARCHAR2(200),
    fk_date VARCHAR2(200),
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

--verificando se a tabela externa foi criada:
select * from dim_produto_ext;
select * from dim_tempo_ext;
select count(*) from fact_ticket_ext;


