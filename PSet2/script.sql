-- Questão 1 --

select avg(salario)
from funcionario
where numero_departamento = 5;

select avg(salario)
from funcionario
where numero_departamento = 4;

select avg(salario)
from funcionario
where numero_departamento = 1;

-- Questão 2 --

select avg(salario)
from funcionario
where sexo = 'F';

select avg(salario)
from funcionario
where sexo = 'M';

-- Questão 3 --

-- Questão 4 --

select primeiro_nome, nome_meio, ultimo_nome, salario as salario_atual, salario as salario_20, salario as salario_15



from funcionario;

-- Questão 5 --



