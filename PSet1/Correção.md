### *Correção do PSet 1 com o Abrantes* e *Como o Abrantes faria o PSet1*
***


1. Questão sobre Git e GitHub

1. Questão sobre Git e GitHub

1. Questão de Git e GitHub

1. Alguns erros do projeto Elmasri:
   1. Varchar(30) no endereço, alguns endereços não cabiam;
   1. Se eu não colocar alguma restrição no número de departamento, posso acabar colocando um funcionário em um departamento que não existe;
   1. Deixar número do departamento nulo para poder cadastrar o funcionário, isso na tabela funcionario ```select nome_departamento from departamento```;
   1. Tirar ```cpf_supervisor``` como ```NOT NULL```. O auto-relacionamento estava certo, ```cpf_supervisor```é uma ```FK``` para a própria tabela.

1. A tabela que identifica um relacionamento N:N é a tabela ```trabalha_em```.

1. Como impor este tipo de restrição, podemos mudar o tipo de relacionamento. E no banco de dados? Colocamos o ```cpf_gerente``` no departamento como uma chave única ```[AK]```.

1. Porque é um relacionamento não-indentificável.

1. O único tipo de relacionamento que guarda dados é o da tabela ```trabalha_em```, o relacionamento ```N:N```.

1. Está correto.

*** 

#### PostgreSQL

```
create table funcionario (
 cpf                    char(11)         constraint nn_func_cpf           not null,
 primeiro_nome          varchar(15)      constraint nn_func_prim_nome     not null, 
 nome_meio              char(1), 
 ultimo_nome            varchar(15)      constraint nn_func_ult_nome      not null,
 data_nascimento        date,
 endereco               varchar (35),
 sexo                   char(1),
 salario                decimal(10,2),
 cpf_supervisor         char(11),
 numero departamento    integer          
);

alter table funcionario add constraint pk_funcionario
primary_key (cpf);
alter table funcionario add constraint fk_cpf_sup_cpf
foreign key (cpf_supervisor) references funcionario (cpf);

comment on table funcoionario is 'Tabela que armazena as informações dos funcionários';
comment on column fuuncionario.cpf is 'comentário';

alter table funcionario add constraint ck_func_sexo
check (sexo in ('M', 'F'));
alter table funcionario add constraint ck_func_salario
check (salario >= 0);

create table dependente (
 cpf_funcionario char(11) constraint nn_depen_cpf_func not null,
 nome dependente varchar(15) constraint nn_depen_nome_dep not null,
 sexo char(1),
 data_nascimento date,
 parentesco varchar(15)
 );
 
alter table dependente add constraint pk_dependente
primary_key (cpf_funcionario, nome_dependente);
alter table dependente add constraint fk_cpf_func_cpf
fereign key (cpf_funcionario) references funcionario (cpf);


alter table dependente add constraint ck_dependente_sexo
check (sexo in ('M', 'F'));
 
create table departamento (
 numero_departamento int constraint nn_dept_num_dept not null,
 nome_departamento varchar(15) constraint nn_dept_nome_dept not null,
 cpf_gerente char(11) constraint nn_dept_cpf_gerente not null,
 data_inicio_gerente
 );
 
alter table departamento add constraint pk_departamento
primary_key (numero_departamento);
alter table departamento add constraint fk_cpf_gerent_cpf
foreign key (cpf_gerente) references funcionario (cpf);
create unique index uidx_dept_nome_dept on departamento (nome_departamento);

alter table departamento add constraint ck_dept_num_dept
check (numero_departamento >= 1);
 
create table localizacoes_departamento (
 numero_departamento int constraint nn_loc_dept_num_dept not null,
 local varchar(15) constraint nn_loc_dept_local not null,
 );
 
alter table lcalizacoes_departamento add constraint pk_loc_departamento
primary_key (numero_departamento, local);
alter table localizacoes_departamento add constraint fk_loc_dept_num_dept
foreign key (numero_departamento) references departamento (numero_departamento);
 
create table projeto (
 numero_projeto int constraint nn_proj_num_proj not null,
 nome_projeto varchar(15) nn_ proj_nome_proj not null,
 local_projeto varchar(1),
 numero_departamento int constraint nn_proj_num_dept not null
 );
 
alter table projeto add constraint pk_projeto
primary_key (numero_projeto);
alter table projeto add constraint fk_num_dept_num_dept
foreign key (numero_departament) references departamento (numero_departamento);
create unique index uidx_proj_nome_proj on projeto (nome_projeto);

alter table projeto add constraint ck_proj_num_proj
check (numero_projeto >= 1);

create table trabalha_em (
 cpf_funcionario char(11) constraint nn_trab_em_cpf_func not null,
 numero_projeto int constraint nn_trab_em_num_proj not null,
 horas decimal(3,1) constraint nn_trab_em_horas
 );
 
alter table trabalha_em add constraint pk_trabalha_em
primary_key (cpf_funcionario, numero_projeto);
alter table trabalha_em add constraint fk_cpf_func_cpf
foreign key (cpf_funcionario) references funcioario (cpf);
alter table trabalha_em add constraint fk_num_proj_num_proj
foreign key (numero_projeto) references projeto (numero_projeto);

alter table trabalha_em add constraint ck_trabalha_em_horas
check (horas >= 0);
```
