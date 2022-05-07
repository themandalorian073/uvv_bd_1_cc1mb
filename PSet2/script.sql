-- Questão 1 --

select avg(salario) as media_dep_5
from funcionario
where numero_departamento = 5;

select avg(salario) as media_dep_4
from funcionario
where numero_departamento = 4;

select avg(salario) as media_dep_1
from funcionario
where numero_departamento = 1;

-- Questão 2 --

select avg(salario) as media_mulheres
from funcionario
where sexo = 'F';

select avg(salario) as media_homens
from funcionario
where sexo = 'M';

-- Questão 3 --

select concat_ws('-', primeiro_nome, nome_meio, ultimo_nome, data_nascimento, year(from_days(datediff(current_date,funcionario.data_nascimento))), 'anos de idadee salário de', salario, 'reais') 
as departamento_pesquisa 
from funcionario
where numero_departamento = 5;

select concat_ws('-', primeiro_nome, nome_meio, ultimo_nome, data_nascimento, year(from_days(datediff(current_date,funcionario.data_nascimento))), 'anos de idadee salário de', salario, 'reais') 
as departamento_administracao
from funcionario
where numero_departamento = 4;

select concat_ws('-', primeiro_nome, nome_meio, ultimo_nome, data_nascimento, year(from_days(datediff(current_date,funcionario.data_nascimento))), 'anos de idadee salário de', salario, 'reais') 
as departamento_matriz
from funcionario
where numero_departamento = 1;

-- Questão 4 --

select primeiro_nome, nome_meio, ultimo_nome, year(from_days(datediff(current_date,funcionario.data_nascimento))) as anos_idade, salario as salario_atual, salario * 1.20 as salario_20, salario * 1.15 as salario_15
from funcionario where salario * 1.20 < 35000 or salario * 1.15 >= 35000;

-- Questão 5 --

-- mostra todos os gerentes de cada departamento --
select  concat (primeiro_nome, nome_meio, ultimo_nome) as nome_gerente, numero_departamento, salario
from funcionario
where exists (select * from departamento where funcionario.cpf = departamento.cpf_gerente);

-- mostra todos os funcionarios --
select primeiro_nome, nome_meio, ultimo_nome, numero_departamento, salario
from funcionario;

-- mostra os nomes dos departamentos e seus respectivos números --
select nome_departamento, numero_departamento
from departamento;

-- para mostrar todos os funcionários exceto os que são gerentes do departamento 5 --
select  concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento, salario
from funcionario
where exists (select * from departamento where funcionario.cpf != departamento.cpf_gerente and funcionario.numero_departamento = 5);

-- mostra o gerente do departamento 5 --
select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_gerente, numero_departamento, salario
from funcionario
where exists (select * from departamento where funcionario.cpf = departamento.cpf_gerente and funcionario.numero_departamento = 5);

-- importante os nomes dos departamentos --
select nome_departamento
from departamento
where exists (select * from funcionario where funcionario.numero_departamento = departamento.numero_departamento);

-- Questão 6 --
-- não falou para colocar o nome do departamento --

select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento, nome_dependente, year(from_days(datediff(current_date, dependente.data_nascimento))) as anos_idade_dependente, dependente.sexo
from funcionario
right join dependente
on funcionario.cpf = dependente.cpf_funcionario
order by nome_funcionario asc;

-- select replace ('F', 'F', 'Feminino');   select replace ('M', 'M', 'Masculino'); --

-- Questão 7 --
-- não falou para colocar nome do departamento --
select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento as departamento, salario
from funcionario
where exists (select * from dependente where funcionario.cpf != dependente.cpf_funcionario);


-- Questão 8 --

-- Questão 9 --

-- Questão 10 --
select avg(salario) as media_dep_5
from funcionario
where numero_departamento = 5;

select avg(salario) as media_dep_4
from funcionario
where numero_departamento = 4;

select avg(salario) as media_dep_1
from funcionario
where numero_departamento = 1;

-- Questão 11 --

-- Questão 12 --

-- Questão 13 --
select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, sexo, year(from_days(datediff(current_date,funcionario.data_nascimento))) as anos_idade
from funcionario
union
select nome_dependente, sexo, year(from_days(datediff(current_date,dependente.data_nascimento))) as anos_idade
from dependente
order by anos_idade desc;

-- Questão 14 --
select count(numero_departamento) as funcionarios_dep5
from funcionario
where numero_departamento = 5;

select count(numero_departamento) as funcionarios_dep4
from funcionario
where numero_departamento = 4;

select count(numero_departamento) as funcionarios_dep1
from funcionario
where numero_departamento = 1;

-- Questão 15 --
