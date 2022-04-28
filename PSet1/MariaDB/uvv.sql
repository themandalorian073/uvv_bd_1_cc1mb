create user amandaarnoni@localhost;

create database uvv;

create schema elmasri;

grant create, drop, select, alter, insert on uvv.* to amandaarnoni@localhost;

flush privileges;

exit;

mysql -u amandaarnoni

use uvv;

create table funcionario (
cpf varchar(11) not null comment 'CPF do funcionário. Será a PK da tabela.',
primeiro_nome varchar(15) not null comment 'Primeiro nome do funcionário.',
nome_meio char(1) comment 'Inicial do nome do meio.',
ultimo_nome varchar(15) not null comment 'Sobrenome do funcionário.',
data_nascimento date,
endereco varchar(30) comment 'Endereco do funcionário.',
sexo char(1) comment 'Sexo do funcionário.',
salario decimal(10,2) comment 'Salário do funcionário.',
numero_departamento integer not null comment 'Número do departamento do funcionário.',
primary key(cpf)
) comment = 'Tabela que armazena as informações dos funcionários.';
alter table funcionario
add constraint check (sexo in ('M', 'F'));
alter table funcionario
add constraint check (salario >= 0);

create table dependente (
cpf_funcionario char(11) not null comment 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.',
nome_dependente varchar(15) not null comment 'Nome do dependente. Faz parte da PK desta tabela.',
sexo char(1) comment 'Sexo do dependente.',
data_nascimento date comment 'Data de nascimento do dependente.',
parentesco varchar(15) comment 'Descrição do parentesco do dependente com o funcionário.',
primary key (cpf_funcionario, nome_dependente),
foreign key (cpf_funcionario) references funcionario(cpf)
) comment = 'Tabela que armazena as informações dos dependentes dos funcionários.';
alter table dependente
add constraint check (sexo in ('M', 'F'));

create table departamento (
numero_departamento integer not null unique comment 'Número do departamento. PK desta tabela.',
cpf_funcionario char(11) not null unique comment 'CPF do funcionário e é PK desta tabela. Se refere à cpf que é PK da tabela funcionario e vira PFK.',
nome_departamento varchar(15) not null  unique comment 'Nome do departamento. Deve ser único.',
data_inicio_gerente date comment 'Data do início do gerente no departamento.',
primary key (numero_departamento),
foreign key (cpf_funcionario) references funcionario(cpf)
) comment = 'Tabela que armazena as informaçoẽs dos departamentos.';

create table localizacoes_departamento (
numero_departamento integer not null comment 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.',
local varchar(15) not null comment 'Localização do departamento. Faz parte da PK desta tabela.',
cpf_funcionario char(11) comment 'CPF do funcionário. Uma das PK nesta tabela. Refere-se à cpf que é PK da tabela funcionario.',
primary key (numero_departamento, local),
foreign key (numero_departamento) references departamento(numero_departamento),
foreign key (cpf_funcionario) references departamento(cpf_funcionario)
) comment = 'Tabela que armazena as possíveis localizações dos departamentos.';

create table projeto (
numero_projeto integer not null comment 'Número do projeto. PK desta tabela.',
nome_projeto varchar(15) not null unique comment 'Nome do projeto. Deve ser único.',
local_projeto varchar(15) comment 'Localização do projeto.',
numero_departamento integer not null comment 'Número do departamento. FK para a tabela departamento.',
cpf_funcionario char(11) comment 'CPF do funcionário que faz referência ào CPF na tabela funcionário. Por isso, se torna uma FK.',
primary key (numero_projeto),
foreign key (numero_departamento) references departamento(numero_departamento),
foreign key (cpf_funcionario) references departamento(cpf_funcionario)
) comment = 'Tabela que armazena as informações sobre os projetos dos departamentos.';

create table trabalha_em (
cpf_funcionario char(11) not null comment 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.',
numero_projeto integer not null comment 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.',
horas decimal comment 'Horas trabalhadas pelo funcionário neste projeto.',
primary key (cpf_funcionario, numero_projeto),
foreign key (numero_projeto) references projeto(numero_projeto),
foreign key (cpf_funcionario) references funcionario(cpf)
) comment = 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
alter table trabalha_em
add constraint check (horas >= 0);



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

insert into departamento (nome_departamento, numero_departamento, cpf_funcionario, data_inicio_gerente)
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