create role amandaarnoni with createdb superuser login password '1234567' createrole bypassrls; 
comment on role amandaarnoni is 'criação de um usuário';

create database uvv with 
owner = amandaarnoni 
template = template0 
encoding = 'UTF8' 
lc_collate = 'pt_BR.UTF-8' 
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;
comment on database uvv is 'Criação do banco de dados uvv.';

\c uvv amandaarnoni;

create schema elmasri authorization current_role;
comment on schema elmasri is 'Criação do schema elmasri para o banco de dados uvv com o ascesso do usuário criado.';

set search_path to elmasri, '$user', public;

alter user amandaarnoni
set search_path to elmasri, '$user', public;

\c uvv amandaarnoni;

create table funcionario (
cpf varchar(11) not null primary key,
primeiro_nome varchar(15) not null,
nome_meio char(1),
ultimo_nome varchar(15) not null,
data_nascimento date,
endereco varchar(30),
sexo char(1),
salario decimal(10,2),
numero_departamento integer not null,
constraint con1 check (sexo in ('M', 'F')),
constraint con2 check (salario >= 0)
);
comment on table elmasri.funcionario is 'Tabela que armazena as informações dos funcionários.';
comment on column elmasri.funcionario.cpf is 'CPF do funcionário. Será a PK da tabela.';
comment on column elmasri.funcionario.primeiro_nome is 'Primeiro nome do funcionário.';
comment on column elmasri.funcionario.nome_meio is 'Inicial do nome do meio.';
comment on column elmasri.funcionario.ultimo_nome is 'Sobrenome do funcionário.';
comment on column elmasri.funcionario.endereco is 'Endereco do funcionário.';
comment on column elmasri.funcionario.sexo is 'Sexo do funcionário.';
comment on column elmasri.funcionario.salario is 'Salário do funcionário.';
comment on column elmasri.funcionario.numero_departamento is 'Número do departamento do funcionário.';
comment on constraint con1 on funcionario is 'Sexo só pode ser inserido como M ou F.';
comment on constraint con2 on funcionario is 'Salario deve ser maior ou igual a zero.';


create table dependente (
cpf_funcionario char(11) not null,
nome_dependente varchar(15) not null,
sexo char(1),
data_nascimento date,
parentesco varchar(15),
primary key (cpf_funcionario, nome_dependente),
constraint fk_dependente foreign key (cpf_funcionario) references funcionario (cpf),
constraint con3 check (sexo in ('M', 'F'))
);
comment on table elmasri.dependente is 'Tabela que armazena as informações dos dependentes dos funcionários.';
comment on column elmasri.dependente.cpf_funcionario is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.dependente.nome_dependente is 'Nome do dependente. Faz parte da PK desta tabela.';
comment on column elmasri.dependente.sexo is 'Sexo do dependente.';
comment on column elmasri.dependente.data_nascimento is 'Data de nascimento do dependente.';
comment on column elmasri.dependente.parentesco is 'Descrição do parentesco do dependente com o funcionário.';
comment on constraint fk_dependente on dependente is 'CPF do funcionário se refere ào CPF do funcionário na tabela funcionario e se torna FK.';
comment on constraint con3 on dependente is 'Sexo só pode ser inserido como M ou F.';

create table departamento (
numero_departamento integer not null unique,
cpf_gerente char(11) not null unique,
nome_departamento varchar(15) not null  unique,
data_inicio_gerente date,
primary key (numero_departamento),
constraint fk_departamento foreign key (cpf_gerente) references funcionario (cpf)
);
comment on table elmasri.departamento is 'Tabela que armazena as informaçoẽs dos departamentos.';
comment on column elmasri.departamento.numero_departamento is 'Número do departamento. PK desta tabela.';
comment on column elmasri.departamento.cpf_funcionario is 'CPF do funcionário e é PK desta tabela. Se refere à cpf que é PK da tabela funcionario e vira PFK.';
comment on column elmasri.departamento.nome_departamento is 'Nome do departamento. Deve ser único.';
comment on column elmasri.departamento.data_inicio_gerente is 'Data do início do gerente no departamento.';
comment on constraint fk_departamento on departamento is 'CPF do funcionário se refere ào CPF do funcionário na tabela funcionario e se torna FK.';

create table localizacoes_departamento (
numero_departamento integer not null,
local varchar(15) not null,
cpf_funcionario char(11),
primary key (numero_departamento, local),
constraint fk_localizacoes_departamento1 foreign key (numero_departamento) references departamento (numero_departamento),
constraint fk_localizacoes_departamento2 foreign key (cpf_funcionario) references departamento (cpf_gerente)
);
comment on table elmasri.localizacoes_departamento is 'Tabela que armazena as possíveis localizações dos departamentos.';
comment on column elmasri.localizacoes_departamento.numero_departamento is 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
comment on column elmasri.localizacoes_departamento.local is 'Localização do departamento. Faz parte da PK desta tabela.';
comment on column elmasri.localizacoes_departamento.cpf_funcionario is 'CPF do funcionário. Uma das PK nesta tabela. Refere-se à cpf que é PK da tabela funcionario.';
comment on constraint fk_localizacoes_departamento1 on localizacoes_departamento is 'Número do departamento é PK desta tabele e se refere ào número do departamento da tabela departamento e se torna PFK.';
comment on constraint fk_localizacoes_departamento2 on localizacoes_departamento is 'CPF do funcionário se refere ào CPF do funcionário da tabela departamento e se torna FK.';

create table projeto (
numero_projeto integer not null primary key,
nome_projeto varchar(15) not null unique,
local_projeto varchar(15),
numero_departamento integer not null,
cpf_funcionario char(11),
constraint fk_projeto1 foreign key (numero_departamento) references departamento (numero_departamento),
constraint fk_projeto2 foreign key (cpf_funcionario) references departamento (cpf_gerente)
);
comment on table elmasri.projeto is 'Tabela que armazena as informações sobre os projetos dos departamentos.';
comment on column elmasri.projeto.numero_projeto is 'Número do projeto. PK desta tabela.';
comment on column elmasri.projeto.nome_projeto is 'Nome do projeto. Deve ser único.';
comment on column elmasri.projeto.local_projeto is 'Localização do projeto.';
comment on column elmasri.projeto.numero_departamento is 'Número do departamento. FK para a tabela departamento.';
comment on column elmasri.projeto.cpf_funcionario is 'CPF do funcionário que faz referência ào CPF na tabela funcionário. Por isso, se torna uma FK.';
comment on constraint fk_projeto1 on projeto is 'Número do departamento se refere ào número do departamento da tabela departamento e se torna FK.';
comment on constraint fk_projeto2 on projeto is 'CPF do funcionário se refere ào CPF do funcionário da tabela departamento e se torna FK.';

create table trabalha_em (
cpf_funcionario char(11) not null,
numero_projeto integer not null,
horas decimal,
primary key (cpf_funcionario, numero_projeto),
constraint fk_trabalha_em1 foreign key (numero_projeto) references projeto (numero_projeto),
constraint fk_trabalha_em2 foreign key (cpf_funcionario) references funcionario (cpf),
constraint con4 check (horas >= 0)
);
comment on table elmasri.trabalha_em is 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
comment on column elmasri.trabalha_em.cpf_funcionario is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.trabalha_em.numero_projeto is 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
comment on column elmasri.trabalha_em.horas is 'Horas trabalhadas pelo funcionário neste projeto.';
comment on constraint fk_trabalha_em1 on trabalha_em is 'Número do projeto é PK desta tabela e se refere ào número do projeto da tabela projeto e se torna PFK.';
comment on constraint fk_trabalha_em2 on trabalha_em is 'CPF do funcionário é PK desta tabela e se refere ào CPF do funcionário da tabela funcionario e se torna PFK.';

insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('João', 'B', 'Silva', 12345678966, '1965-01-09', 'R.dasFlores, 751, SP, SP', 'M', 30000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Fernando', 'T', 'Wong', 33344555587, '1955-12-08', 'R.daLapa, 34, SP, SP', 'M', 40000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Alice', 'J', 'Zelaya', 99988777767, '1968-01-19', 'R.SouzaLima, 35, CBW, PR', 'F', 25000, 4);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Jennifer', 'S', 'Souza', 98765432168, '1941-06-20', 'Av.Art.DeLima, 54, S.André, SP', 'F', 43000, 4);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Ronaldo', 'K', 'Lima', 66688444476, '1962-09-15', 'R.Rebouças, 65, RMP, SP', 'M', 38000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Joice', 'A', 'Leite', 45345345376, '1972-07-31', 'Av.LucasObes, 74, SP, SP', 'F', 25000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('André', 'V', 'Pereira', 98798798733, '1969-03-29', 'R.Timbira, 35, SP, SP', 'M', 25000, 4);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Jorge', 'E', 'Brito', 88866555576, '1937-11-10', 'R.doHorto, 35, SP, SP', 'M', 55000, 1);

insert into departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values ('Pesquisa', 5, 33344555587, '1988-05-22');
insert into departamento (nome_departamento, numero_departamento, cpf_funcionario, data_inicio_gerente)
values ('Administração', 4, 98765432168, '1995-01-01');
insert into departamento (nome_departamento, numero_departamento, cpf_funcionario, data_inicio_gerente)
values ('Matriz', 1, 88866555576, '1981-06-19');

insert into localizacoes_departamento (numero_departamento, local)
values (1, 'São Paulo');
insert into localizacoes_departamento (numero_departamento, local)
values (4, 'Mauá');
insert into localizacoes_departamento (numero_departamento, local)
values (5, 'Santo André');
insert into localizacoes_departamento (numero_departamento, local)
values (5, 'Itu');
insert into localizacoes_departamento (numero_departamento, local)
values (5, 'São Paulo');

insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoX', 1, 'Santo André', 5);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoY', 2, 'Itu', 5);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoZ', 3, 'São Paulo', 5);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('Informatização', 10, 'Mauá', 4);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('Reorganização', 20, 'São Paulo', 1);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('Novosbenefícios', 30, 'Mauá', 4);

insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (33344555587, 'Alicia', 'F', '1986-04-05', 'Filha'); 
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (33344555587, 'Tiago', 'M', '1983-10-25', 'Filho'); 
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (33344555587, 'Janaína', 'F', '1958-05-03', 'Esposa');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (98765432168, 'Antonio', 'M', '1942-02-28', 'Marido');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (12345678966, 'Michael', 'M', '1988-01-04', 'Filho');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (12345678966, 'Alicia', 'F', '1988-12-30', 'Filha');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (12345678966, 'Elizabeth', 'F', '1967-05-05', 'Esposa');

insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (12345678966, 1, 32.5);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (12345678966, 2, 7.5);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (66688444476, 3, 40.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (45345345376, 1, 20.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (45345345376, 2, 20.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (33344555587, 2, 10.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (33344555587, 3, 10.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (33344555587, 10, 10.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (33344555587, 20, 10.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (99988777767, 30, 30.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (99988777767, 10, 10.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (98798798733, 10, 35.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (98798798733, 30, 5.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (98765432168, 30, 20.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (98765432168, 20, 15.0);
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values (88866555576, 20, null);