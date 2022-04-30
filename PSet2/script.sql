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

select concat (primeiro_nome, '', nome_meio, '', ultimo_nome, '', data_nascimento, '', year(from_days(datediff(current_date,funcionario.data_nascimento))), '', 'anos de idade', '', 'salário de', '', salario, '', 'reais')
as departamento_pesquisa
from funcionario
where numero_departamento = 5;

select concat (primeiro_nome, '', nome_meio, '', ultimo_nome, '', data_nascimento, '', year(from_days(datediff(current_date,funcionario.data_nascimento))), '', 'anos de idade', '', 'salário de', '', salario, '', 'reais')
as departamento_administracao
from funcionario
where numero_departamento = 4;

select concat (primeiro_nome, '', nome_meio, '', ultimo_nome, '', data_nascimento, '', year(from_days(datediff(current_date,funcionario.data_nascimento))), '', 'anos de idade', '', 'salário de', '', salario, '', 'reais')
as departamento_matriz
from funcionario
where numero_departamento = 1;

-- Questão 4 --



-- Questão 5 --



