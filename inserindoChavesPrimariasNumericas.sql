--verificando estrutura da tabela de fact_ticket:
select * from fact_ticket;

--alterando as colunas de fk para fk_ref:
alter table
    fact_ticket
rename column
    fk_date
to
    fk_date_ref;

alter table
    fact_ticket
rename column
    fk_product
to
    fk_product_ref;
    
--verificando estrutura da tabela de produtos:
select
    *
from
    dim_produto;

--alterando nome da coluna pk para pk_ref:
alter table
    dim_produto
rename column
    pk_product
to
    pk_prouct_ref;

--criando sequência para geração de pk:

create sequence
    pk_dim_seq
start with
    1
increment by
    1
nomaxvalue
nocycle;

--acrescentando coluna pk_product:

alter table
    dim_produto
add
    (pk_product NUMBER);

--inserindo os valores de chave primária a partir da sequência:
update
    dim_produto
set
    pk_product = (pk_dim_seq.nextval);

--verificando a estrutura da dimensão tempo:
select
    *
from
    dim_tempo;

--renomeando coluna de pk para pk_ref na dimensão tempo:
alter table
    dim_tempo
rename column
    pk_date
to
    pk_date_ref;
    
--acrescentando coluna pk_ref para inserção de pk a partir de sequência:
alter table
    dim_tempo
add
    (pk_date NUMBER);

--reiniciando a sequência para inserção de valores de pk na dimensão tempo:
alter sequence
    pk_dim_seq
restart;

--inserindo valores de pk a partir da sequência:
update
    dim_tempo
set
    pk_date = (pk_dim_seq.nextval);

--criando colunas de fk na tabela de fatos para as novas colunas de pk das dimensões:
alter table
    fact_ticket
add
    (fk_product NUMBER);

alter table
    fact_ticket
add
    (fk_date NUMBER);

--verificando colunas inseridas na estrutura da tabela de fatos:
select
    *
from
    fact_ticket;

--inserindo valores na tabela de fatos usando merge:
merge into
    fact_ticket fct
using
    dim_produto prod
on
    (prod.PRODUCT_ID_INPUT_LEVEL = fct.FK_PRODUCT_REF)
when matched then
    update set fct.fk_product = prod.pk_product;

--verificando se os valores foram inseridos corretamente:
select
    fk_product_ref,
    fk_product
from
    fact_ticket
where
    fk_product_ref like '7MVT';
    
--repetindo o merge para a chave estrangeira de data:
merge into
    fact_ticket fct
using   
    dim_tempo tmp
on
    (fct.FK_DATE_REF = tmp.DATE_INPUT_LEVEL)
when matched then
    update set fct.FK_DATE = tmp.PK_DATE;

--verificando valores inseridos:
select
    *
from
    fact_ticket;

--verificando se as chaves correspondem:
select
    DATE_INPUT_LEVEL,
    PK_DATE
from
    dim_tempo
where
    pk_date = 710;

select
    FK_DATE_REF,
    FK_DATE
from
    fact_ticket
where
    fk_date = 710;
    
--reinserindo as constraints:
alter table
    dim_tempo
add constraint
    pk_date PRIMARY KEY (pk_date);

alter table
    dim_produto
add constraint
    pk_product PRIMARY KEY (PK_PRODUCT);

alter table
    fact_ticket
add constraint
    pk_fact_ticket PRIMARY KEY (PK_FACT_INDEX, PK_SALE_ID);
    
--inserindo chaves estrangeiras na tabela de fatos:
alter table
    fact_ticket
add constraint
    fk_date
FOREIGN KEY
    (fk_date)
REFERENCES
    dim_tempo(PK_DATE);
    
alter table
    fact_ticket
add constraint
    fk_product
FOREIGN KEY
    (FK_PRODUCT)
REFERENCES
    dim_produto(PK_PRODUCT);