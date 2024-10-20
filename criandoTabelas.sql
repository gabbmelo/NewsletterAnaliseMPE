/*Criando as tabelas das dimensões*/

CREATE TABLE dim_tempo (
    pk_date NUMBER,
    date_input_level TIMESTAMP,
    year_id NUMBER,
    month_of_year NUMBER,
    week_of_year NUMBER,
    weekday NUMBER,   
    day_id NUMBER,
    day_of_year TIMESTAMP,
    hour_id NUMBER
);

CREATE TABLE dim_produto (
    pk_product NUMBER PRIMARY KEY,
    product_id_input_level VARCHAR2(200),
    product_description VARCHAR2(200),
    category_description VARCHAR2(200),
    class_id CHAR(1),
    class_description VARCHAR2(200)
);

CREATE TABLE fact_ticket (
    pk_fact_index NUMBER,
    fk_date DATE,
    pk_sale_id NUMBER,
    fk_product VARCHAR2(10),
    FOREIGN KEY (fk_date) REFERENCES dim_tempo(pk_date),
    FOREIGN KEY (fk_product) REFERENCES dim_produto(pk_product),
    Place_or_Sale VARCHAR2(200),
    Payment_Type VARCHAR2(200),
    Payment_Method VARCHAR2(200),
    Revenues NUMBER,
    Quantity NUMBER,
    PRIMARY KEY (pk_fact_index, pk_sale_id)
);