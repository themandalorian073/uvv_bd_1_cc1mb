-- Questão 1 -- OK 
-- não falou para colocar nome do departamento --

select numero_departamento, avg(salario)
from funcionario
group by numero_departamento;

-- Questão 2 -- OK
-- não pediu para colocaexibirr no formato da moeda real --

select sexo, avg(salario) as media_salarial
from funcionario
group by sexo;

-- Questão 3 -- OK 
-- não pediu para colocar o número do departamento --

select nome_departamento, concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, data_nascimento, year(from_days(datediff(current_date, funcionario.data_nascimento))) as anos_idade,  format(salario, 'c', 'pt-br') as salario
from funcionario
right join departamento
on funcionario.numero_departamento = departamento.numero_departamento
group by nome_departamento, data_nascimento;

-- Questão 4 -- OK 

select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, year(from_days(datediff(current_date,funcionario.data_nascimento))) as anos_idade, salario as salario_atual, salario * 1.20 as salario_20, salario * 1.15 as salario_15
from funcionario where salario * 1.20 < 35000 or salario * 1.15 >= 35000;

-- Questão 5 -- 
-- ainda falta terminar !!! --

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

-- Questão 6 -- OK
-- não falou para exibir o nome do departamento --

select case dependente.sexo when 'F' then 'Feminino' when 'M' then 'Masculino' end as sexo_dependente, nome_dependente, year(from_days(datediff(current_date, dependente.data_nascimento))) as anos_idade_dependente, concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento
from funcionario
right join dependente
on funcionario.cpf = dependente.cpf_funcionario
order by nome_funcionario asc;

-- Questão 7 -- OK --
-- não falou para colocar nome do departamento --

select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento as departamento, salario
from funcionario
where exists (select * from dependente where funcionario.cpf != dependente.cpf_funcionario);

-- Questão 8 -- OK
-- não falou para exibir o nome do departamento ou nome dos projetos --

select  concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, horas, nome_departamento, nome_projeto
from funcionario
right join departamento on funcionario.numero_departamento = departamento.numero_departamento
right join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario
right join projeto on projeto.numero_projeto = trabalha_em.numero_projeto
order by nome_funcionario asc;

-- Questão 9 -- OK

select nome_departamento, nome_projeto, sum(horas) as total_horas_trabalhadas
from projeto
right join departamento on projeto.numero_departamento = departamento.numero_departamento 
right join trabalha_em on projeto.numero_projeto = trabalha_em.numero_projeto
group by nome_departamento, nome_projeto
order by nome_projeto asc;

-- Questão 10 -- OK
-- não pediu para colocaexibirr no formato da moeda real --

select nome_departamento, avg(salario) as salario
from funcionario 
right join departamento 
on funcionario.numero_departamento = departamento.numero_departamento
group by nome_departamento;

-- Questão 11 --
-- ainda falta terminar!!! --

select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, nome_projeto, salario, horas
from funcionario
right join trabalha_em
on funcionario.cpf = trabalha_em.cpf_funcionario
right join projeto 
on funcionario.numero_departamento = projeto.numero_departamento;

-- Questão 12 -- OK   
-- exibi horas para que pudesse identificar funcionários sem nenhuma hora trabalhada --

select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, nome_departamento, nome_projeto, horas
from funcionario 
right join departamento on funcionario.numero_departamento = departamento.numero_departamento
right join projeto on funcionario.numero_departamento = projeto.numero_departamento
right join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario
order by nome_projeto asc;

-- Questão 13 -- OK 
-- ordem decrescente das idades (funcionários e dependentes) --
select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, sexo, year(from_days(datediff(current_date,funcionario.data_nascimento))) as anos_idade
from funcionario
union
select nome_dependente, sexo, year(from_days(datediff(current_date,dependente.data_nascimento))) as anos_idade
from dependente
order by anos_idade desc;

-- Questão 14 -- OK
-- não pediu para exibir o nome do departamento --
select numero_departamento, count(cpf_funcionario) as qtd_funcionarios
from trabalha_em
right join funcionario
on funcionario.cpf = trabalha_em.cpf_funcionario 
group by numero_departamento;

-- Questão 15 --
-- ainda falta terminar !!! --
-- não pediu para exibir o nome do departamento --
select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento, nome_projeto
from funcionario
where exists (select * from projeto where funcionario.numero_departamento = projeto.numero_departamento)
-- right join projeto on funcionario.numero_departamento = projeto.numero_departamento; --

