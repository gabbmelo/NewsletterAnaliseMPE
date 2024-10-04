-- criação de tabelas a partir de outras tabelas
CREATE TABLE
AS SELECT:
CREATE TABLE my_table AS SELECT TABLE_NAME, STATUS
FROM USER_TABLES;

-- Especificando tablespaces no momento de criação das tabelas
CREATE TABLE my_table (
id NUMBER PRIMARY KEY,
nome VARCHAR2(50),
sobrenome VARCHAR2(50),
idade NUMBER
) TABLESPACE USERS;

-- criando tabelas permanentes do tipo IOT
CREATE TABLE newsletter_iot(
id number primary key,
descricao varchar2(30)
) ORGANIZATION INDEX;

-- Criação de tabela temporária global específica de sessão
CREATE GLOBAL TEMPORARY TABLE admin_work_area_session(
startdate DATE,
enddate DATE,
class VARCHAR2(20))
ON COMMIT PRESERVE ROWS;

-- Criação de tabela temporária global específica de transação
CREATE GLOBAL TEMPORARY TABLE admin_work_area_trans(
startdate DATE,
enddate DATE,
class VARCHAR2(20))
ON COMMIT DELETE ROWS;

-- Criação de tabela temporária privada específica de transação
CREATE PRIVATE TEMPORARY TABLE ORA$PTT_sales_ptt_transaction(
time_id DATE,
amount_sold NUMBER(10,2))
ON COMMIT DROP DEFINITION;

-- Criação de tabela temporária privada específica de sessão
CREATE GLOBAL TEMPORARY TABLE admin_work_area_trans(
startdate DATE,
enddate DATE,
class VARCHAR2(20))
ON COMMIT PRESERVE DEFINITION;

-- Adicionando coluna a uma tabela existente - exemplo
ALTER TABLE nome_da_tabela ADD (nome_da_coluna VARCHAR2(20));

-- Renomeando coluna
ALTER TABLE nome_da_tabela RENAME COLUMN nome_antigo_da_coluna TO novo_nome_da_coluna;

-- Modificando uma coluna (exemplo)
ALTER TABLE nome_da_tabela MODIFY(nome_da_coluna VARCHAR2(200) NOT NULL);

-- Remover uma coluna
ALTER TABLE nome_da_tabela DROP COLUMN descr;

-- Remover várias colunas
ALTER TABLE nome_da_tabela DROP (coluna1, coluna2);

-- Alterar estado de coluna para UNUSED
ALTER TABLE nome_da_tabela SET UNUSED (nome_da_coluna);

-- Visualizar lista de tabelas com colunas UNUSED
SELECT * FROM USER_UNUSED_COL_TABS;

-- Remover colunas UNUSED de uma tabela
ALTER TABLE nome_da_tabela DROP UNUSED COLUMNS;

-- Remover tabela (dados e estrutura)
DROP TABLE nome_da_tabela;

-- Remover tabela (dados e estrutura) com relacionamento
DROP TABLE nome_da_tabela CASCADE CONSTRAINTS;

-- Remover tabela (dados e estrutura) e liberar espaço imediatamente
DROP TABLE nome_da_tabela PURGE;

-- Remover tabela (somente dados) através de eliminação e recriação
DROP TABLE nome_da_tabela;
CREATE TABLE nome_da_tabela (...);

-- Remover todos os dados de uma tabela
DELETE FROM nome_da_tabela;

-- Truncar uma tabela
TRUNCATE TABLE nome_da_tabela;

