\echo
\echo Removendo o banco de dados "igreja" e o usuário "amandaarnoni":
drop database if exists igreja;

drop user if exists amandaarnoni;

\echo
\echo Criando o usuário "amandaarnoni":
create role amandaarnoni with
  nosuperuser
  createdb
  createrole
  login
  encrypted password '1234567'
;

\echo
\echo Criando o banco de dados "igreja":
create database igreja with
  owner      = amandaarnoni
  template   = template0
  encoding   = 'UTF-8'
  lc_collate = 'pt_BR.UTF-8'
  lc_ctype   = 'pt_BR.UTF-8'
;

comment on database igreja IS 'Banco de dados do trabalho de projeto lógico.';

\echo
\echo Conectando ao novo banco de dados:
\c "dbname=igreja user=amandaarnoni password=1234567"

\echo
\echo Criando e configurando o schema "trabalho_projeto_logico":
create schema trabalho_projeto_logico authorization amandaarnoni;
comment on schema trabalho_projeto_logico is 'Schema para o trabalho do projeto lógico.';

alter user amandaarnoni set search_path to elmasri, "$user", public;

set search_path elmasri, "$user", public;