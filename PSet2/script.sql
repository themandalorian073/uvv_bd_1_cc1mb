-- Questão 1 -- OK 
-- não pediu para exibir nome do departamento --

select numero_departamento, avg(salario)
from funcionario
group by numero_departamento;

-- Questão 2 -- OK
-- não pediu para exibir no formato da moeda real --

select sexo, avg(salario) as media_salarial
from funcionario
group by sexo;

-- Questão 3 -- OK 
-- não pediu para exibir o número do departamento --

select nome_departamento, concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, data_nascimento, year(from_days(datediff(current_date, funcionario.data_nascimento))) as anos_idade,  format(salario, 'c', 'pt-br') as salario
from funcionario
right join departamento
on funcionario.numero_departamento = departamento.numero_departamento
group by nome_departamento, data_nascimento;

-- Questão 4 -- OK 

select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, year(from_days(datediff(current_date,funcionario.data_nascimento))) as anos_idade, salario as salario_atual, salario * 1.20 as salario_20, salario * 1.15 as salario_15
from funcionario where salario * 1.20 < 35000 or salario * 1.15 >= 35000;

-- Questão 5 -- OK
-- não pediu para exibir o nome do departamento --

select concat (func.primeiro_nome, func.nome_meio, func.ultimo_nome) as nome_supervisor, concat (f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_funcionario, nome_departamento, f.salario as salario_funcionarios
from funcionario as f
JOIN departamento as dept ON f.numero_departamento = dept.numero_departamento
join funcionario as func on dept.cpf_gerente = func.cpf
group by nome_departamento, nome_funcionario, nome_supervisor, salario_funcionarios
order by nome_departamento asc, salario_funcionarios desc;

-- Questão 6 -- OK
-- não pediu para exibir o nome do departamento --

select case dependente.sexo when 'F' then 'Feminino' when 'M' then 'Masculino' end as sexo_dependente, nome_dependente, year(from_days(datediff(current_date, dependente.data_nascimento))) as anos_idade_dependente, concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento
from funcionario
right join dependente
on funcionario.cpf = dependente.cpf_funcionario
order by nome_funcionario asc;

-- Questão 7 -- OK --
-- não pediu para exibir nome do departamento --

select concat (primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, numero_departamento as departamento, salario
from funcionario
where exists (select * from dependente where funcionario.cpf != dependente.cpf_funcionario);

-- Questão 8 -- OK
-- não pediu para exibir o nome do departamento ou nome dos projetos --

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
-- não pediu para exibir no formato da moeda real --

select nome_departamento, avg(salario) as salario
from funcionario 
right join departamento 
on funcionario.numero_departamento = departamento.numero_departamento
group by nome_departamento;

-- Questão 11 -- OK

select concat(funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome) as nome_funcionario, projeto.nome_projeto, case when trabalha_em.horas > 0 then trabalha_em.horas * 50 end as valor_total_salario
from trabalha_em
join projeto on (trabalha_em.numero_projeto = projeto.numero_projeto)
join funcionario on (trabalha_em.cpf_funcionario = funcionario.cpf)
group by concat(funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome), projeto.nome_projeto, trabalha_em.horas;

-- Questão 12 -- OK   
-- exibi horas para que pudesse identificar funcionários sem nenhuma hora trabalhada --

select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, nome_departamento, nome_projeto, horas
from funcionario 
right join departamento on funcionario.numero_departamento = departamento.numero_departamento
right join projeto on funcionario.numero_departamento = projeto.numero_departamento
right join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario
order by nome_projeto asc;

-- Questão 13 -- OK 
-- ordem decrescente das idades como um todo, potanto as dos funcionários e dos dependentes --
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

-- Questão 15 -- OK
-- não pediu para exibir o nome do departamento --

select concat(primeiro_nome, nome_meio, ultimo_nome) as nome_funcionario, nome_departamento, nome_projeto
from funcionario 
right join departamento on funcionario.numero_departamento = departamento.numero_departamento
right join projeto on funcionario.numero_departamento = projeto.numero_departamento
right join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario
order by nome_projeto asc;

