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

---

\echo
\echo Criando a tabela "doacoes" e objetos relacionados:

CREATE TABLE public.doacoes (
                codigo_doacao INTEGER NOT NULL,
                nome VARCHAR(150) NOT NULL,
                data_doacao DATE NOT NULL,
                identificacao_doador VARCHAR(150),
                CONSTRAINT pk_doacoes PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE public.doacoes IS 'Tabela que armazena dados a respeito das doações da igreja.';
COMMENT ON COLUMN public.doacoes.codigo_doacao IS 'Código único e exclusivo que identifica as doações da igreja.';
COMMENT ON COLUMN public.doacoes.nome IS 'Nome das doações da igreja.';
COMMENT ON COLUMN public.doacoes.data_doacao IS 'Data que aa doações foi feitas para a igreja.';
COMMENT ON COLUMN public.doacoes.identificacao_doador IS 'Identificação de quem fez a doação da igreja.';

\echo
\echo Criando a tabela "trabalhos" e objetos relacionados:

CREATE TABLE public.trabalhos (
                codigo_doacao INTEGER NOT NULL,
                tipo_trabalho VARCHAR(100) NOT NULL,
                nome_doador VARCHAR(150) NOT NULL,
                CONSTRAINT pk_trabalhos PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE public.trabalhos IS 'Tabela que armazena dados a respeio das doações feitas em trabalhos voluntários para a igreja.';
COMMENT ON COLUMN public.trabalhos.codigo_doacao IS 'PFK para a tabela doacoes, e código único e exclusivo que identifica as doações feitas para a igreja.';
COMMENT ON COLUMN public.trabalhos.tipo_trabalho IS 'Tipo do trabalho voluntário que foi doado para a igreja.';
COMMENT ON COLUMN public.trabalhos.nome_doador IS 'Nome de quem fez a doação por trabalho voluntário.';

\echo
\echo Criando a tabela "bens" e objetos relacionados:

CREATE TABLE public.bens (
                codigo_doacao INTEGER NOT NULL,
                descricao TEXT NOT NULL,
                tipo VARCHAR(100) NOT NULL,
                CONSTRAINT pk_bens PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE public.bens IS 'Tabela que armazena dados a respeio das doações feitas em bens para a igreja.';
COMMENT ON COLUMN public.bens.codigo_doacao IS 'PFK para a tabela doacoes, e código único e exclusivo que identifica as doações feitas para a igreja.';
COMMENT ON COLUMN public.bens.descricao IS 'Descrição dos bens que foram doados para a igreja.';
COMMENT ON COLUMN public.bens.tipo IS 'Tipo dos bens que foram doados para a igreja';

\echo
\echo Criando a tabela "monetarios" e objetos relacionados:

CREATE TABLE public.monetarios (
                codigo_doacao INTEGER NOT NULL,
                valor NUMERIC(9,2) NOT NULL,
                tipo_moeda VARCHAR(100),
                CONSTRAINT pk_monetarios PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE public.monetarios IS 'Tabela que armazena dados a respeio das doações feitas em dinheiro para a igreja.';
COMMENT ON COLUMN public.monetarios.codigo_doacao IS 'PFK para a tabela doacoes, e código único e exclusivo que identifica as doações feitas para a igreja.';
COMMENT ON COLUMN public.monetarios.valor IS 'Valor da doação feita para a igreja.';
COMMENT ON COLUMN public.monetarios.tipo_moeda IS 'Tipo da moeda que foi usada para fazer a doação para a igreja.';

\echo
\echo Criando a tabela "destinacoes" e objetos relacionados:

CREATE TABLE public.destinacoes (
                nome_destinacao VARCHAR(150) NOT NULL,
                data DATE NOT NULL,
                recebedor VARCHAR(150) NOT NULL,
                observacoes TEXT,
                CONSTRAINT pk_destinacoes PRIMARY KEY (nome_destinacao)
);
COMMENT ON TABLE public.destinacoes IS 'Tabela que armazena dados a respeito das destinacoes da igreja.';
COMMENT ON COLUMN public.destinacoes.nome_destinacao IS 'Nome das destinações da igreja.';
COMMENT ON COLUMN public.destinacoes.data IS 'Data das destinações da igreja.';
COMMENT ON COLUMN public.destinacoes.recebedor IS 'Nome do recebedor das destinações da igreja.';
COMMENT ON COLUMN public.destinacoes.observacoes IS 'Observações a respeito das destinações da igreja.';

\echo
\echo Criando a tabela "imagens" e objetos relacionados:

CREATE TABLE public.imagens (
                nome_destinacao VARCHAR(150) NOT NULL,
                codigo_imagem INTEGER NOT NULL,
                nome VARCHAR(150) NOT NULL,
                descricao TEXT NOT NULL,
                data_registro DATE NOT NULL,
                CONSTRAINT pk_imagens PRIMARY KEY (nome_destinacao, codigo_imagem)
);
COMMENT ON TABLE public.imagens IS 'Tabela que armazena dados a respeito das imagens das destinações da igreja.';
COMMENT ON COLUMN public.imagens.nome_destinacao IS 'Nome das destinações da igreja, PFK para a tabela destinacoes.';
COMMENT ON COLUMN public.imagens.codigo_imagem IS 'Cóodigo da imagem das destinações da igreja.';
COMMENT ON COLUMN public.imagens.nome IS 'Nome das imagens das destinações da igreja.';
COMMENT ON COLUMN public.imagens.descricao IS 'Descrição das imagens das destinações da igreja.';
COMMENT ON COLUMN public.imagens.data_registro IS 'Data que as imagens foram registradas.';

\echo
\echo Criando a tabela "programas" e objetos relacionados:

CREATE TABLE public.programas (
                codigo_programa INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                descricao TEXT(1000) NOT NULL,
                objetivos TEXT(1000) NOT NULL,
                data_de_inicio DATE NOT NULL,
                data_final_prevista DATE,
                CONSTRAINT pk_programas PRIMARY KEY (codigo_programa)
);
COMMENT ON TABLE public.programas IS 'Tabela que armazena dados sobre os programas da igreja.';
COMMENT ON COLUMN public.programas.codigo_programa IS 'Código único e exclusivo que identifica o programa da igreja.';
COMMENT ON COLUMN public.programas.nome IS 'Nome do programa da igreja.';
COMMENT ON COLUMN public.programas.descricao IS 'Descrição sobre o programa da igreja.';
COMMENT ON COLUMN public.programas.objetivos IS 'Objetivos que os programas da igreja almejam alcançar.';
COMMENT ON COLUMN public.programas.data_de_inicio IS 'Data de ínicio dos programas da igreja, quando eles começaram a acontecer.';
COMMENT ON COLUMN public.programas.data_final_prevista IS 'Data prevista para o final dos programas da igreja.';

\echo
\echo Criando a tabela "uf" e objetos relacionados:

CREATE TABLE public.uf (
                sigla CHAR(2) NOT NULL,
                nome VARCHAR(100) NOT NULL,
                CONSTRAINT pk_uf PRIMARY KEY (sigla)
);
COMMENT ON TABLE public.uf IS 'Tabela que armazena as unidades da federação.';
COMMENT ON COLUMN public.uf.sigla IS 'PK da tabela, é a sigla do estado.';
COMMENT ON COLUMN public.uf.nome IS 'Nome padronizado da unidade da federação.';

\echo
\echo Criando a tabela "cidades" e objetos relacionados:

CREATE TABLE public.cidades (
                codigo INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                CONSTRAINT pk_cidades PRIMARY KEY (codigo)
);
COMMENT ON TABLE public.cidades IS 'Tabela que armaena as cidades do estado.';
COMMENT ON COLUMN public.cidades.codigo IS 'PK da tabela, e o código único e exclusivo de cada cidade.';
COMMENT ON COLUMN public.cidades.nome IS 'Nome padronizado da cidade.';

\echo
\echo Criando a tabela "bairros" e objetos relacionados:

CREATE TABLE public.bairros (
                codigo INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                CONSTRAINT pk_bairros PRIMARY KEY (codigo)
);
COMMENT ON TABLE public.bairros IS 'Tabela que armazena os bairros das cidades.';
COMMENT ON COLUMN public.bairros.codigo IS 'PK inventada para esta tabela, e é o código único e exclusivo de identificação de cada bairro.';
COMMENT ON COLUMN public.bairros.nome IS 'Nome do bairro.';

\echo
\echo Criando a tabela "comunidades" e objetos relacionados:

CREATE TABLE public.comunidades (
                codigo_comunidade INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                endereco_logradouro VARCHAR(150) NOT NULL,
                endereco_numero VARCHAR(10),
                endereco_complemento VARCHAR(10),
                endereco_codigo_bairro INTEGER NOT NULL,
                edereco_codigo_cidade INTEGER NOT NULL,
                endereco_uf CHAR(2) NOT NULL,
                endereco_cep CHAR(8) NOT NULL,
                CONSTRAINT pk_comunidades PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE public.comunidades IS 'Tabela que armazena dados sobre as comunidades da igreja.';
COMMENT ON COLUMN public.comunidades.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja.';
COMMENT ON COLUMN public.comunidades.nome IS 'Nome das comunidades da igreja.';
COMMENT ON COLUMN public.comunidades.endereco_logradouro IS 'Nome do logradouro do endereço.';
COMMENT ON COLUMN public.comunidades.endereco_numero IS 'Número dos endereços das comunidades.';
COMMENT ON COLUMN public.comunidades.endereco_complemento IS 'Complemento do endereço.';
COMMENT ON COLUMN public.comunidades.endereco_codigo_bairro IS 'FK para a tabela de bairros.';
COMMENT ON COLUMN public.comunidades.edereco_codigo_cidade IS 'FK para a tabela de cidades.';
COMMENT ON COLUMN public.comunidades.endereco_uf IS 'FK para a tabela de UF.';
COMMENT ON COLUMN public.comunidades.endereco_cep IS 'CEP do endereço do cliente.';

\echo
\echo Criando a tabela "atendidos" e objetos relacionados:

CREATE TABLE public.atendidos (
                codigo_comunidade INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                cpf CHAR(11),
                cnpj CHAR(14),
                CONSTRAINT pk_atendidos PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE public.atendidos IS 'Tabela que armazena os atendidos das comunidades da igreja.';
COMMENT ON COLUMN public.atendidos.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja, também é PFK para a tabela comunidades.';
COMMENT ON COLUMN public.atendidos.nome IS 'Nome dos atendidos das comunidades da igreja.';
COMMENT ON COLUMN public.atendidos.cpf IS 'CPF doa satendidos das comunidades da igreja.';
COMMENT ON COLUMN public.atendidos.cnpj IS 'CNPJ dos atendidos das comunidades da igreja.';

\echo
\echo Criando a tabela "comunidades_emails" e objetos relacionados:

CREATE TABLE public.comunidades_emails (
                codigo_comunidade INTEGER NOT NULL,
                email VARCHAR(100),
                CONSTRAINT pk_comunidades_emails PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE public.comunidades_emails IS 'Tabela que armazena os emails dss comunidades da igreja.';
COMMENT ON COLUMN public.comunidades_emails.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja, também é PFK para a tabela comunidades.';
COMMENT ON COLUMN public.comunidades_emails.email IS 'Email da comunidade da igreja, também é PK da tabela.';

\echo
\echo Criando a tabela "comunidades_telefones" e objetos relacionados:

CREATE TABLE public.comunidades_telefones (
                codigo_comunidade INTEGER NOT NULL,
                numero VARCHAR(11) NOT NULL,
                tipo VARCHAR(50),
                CONSTRAINT pk_comunidades_telefones PRIMARY KEY (codigo_comunidade, numero)
);
COMMENT ON TABLE public.comunidades_telefones IS 'Tabela que armazena os telefones das comunidades da igreja.';
COMMENT ON COLUMN public.comunidades_telefones.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja, também é PFK para a tabela comunidades.';
COMMENT ON COLUMN public.comunidades_telefones.numero IS 'Número e DDD do telefone do cliente, também é PK da tabela.';
COMMENT ON COLUMN public.comunidades_telefones.tipo IS 'Informa qual é o tipo de telefone.';

\echo
\echo Criando a tabela "membros" e objetos relacionados:

CREATE TABLE public.membros (
                codigo_membro INTEGER NOT NULL,
                nome VARCHAR(150) NOT NULL,
                endereco_logradouro VARCHAR(150) NOT NULL,
                endereco_numero VARCHAR(10) NOT NULL,
                endereco_complemento VARCHAR(10),
                edereco_codigo_bairro INTEGER NOT NULL,
                endereco_codigo_cidade INTEGER NOT NULL,
                endereco_uf CHAR(2) NOT NULL,
                endereco_cep CHAR(8) NOT NULL,
                profissao VARCHAR(100) NOT NULL,
                data_de_nascimento DATE NOT NULL,
                sexo CHAR(1) NOT NULL,
                estado_civil VARCHAR(100) NOT NULL,
                CONSTRAINT pk_membros PRIMARY KEY (codigo_membro)
);
COMMENT ON TABLE public.membros IS 'Esta tabela armazena os dados dos membros da igrja.';
COMMENT ON COLUMN public.membros.codigo_membro IS 'PK da tabela, e o código único e exclusivo de cada membro da igraja.';
COMMENT ON COLUMN public.membros.nome IS 'Nome dos membros da igreja.';
COMMENT ON COLUMN public.membros.endereco_logradouro IS 'Nome do logradouro do endereço.';
COMMENT ON COLUMN public.membros.endereco_numero IS 'Número do endereço do membro da igreja.';
COMMENT ON COLUMN public.membros.endereco_complemento IS 'Complemento do endereço.';
COMMENT ON COLUMN public.membros.edereco_codigo_bairro IS 'FK para a tabela de bairros.';
COMMENT ON COLUMN public.membros.endereco_codigo_cidade IS 'FK para a tabela de cidades.';
COMMENT ON COLUMN public.membros.endereco_uf IS 'PK da tabela, é a sigla do estado.';
COMMENT ON COLUMN public.membros.endereco_cep IS 'CEP do endereço do membro da igreja.';
COMMENT ON COLUMN public.membros.profissao IS 'Profissão dos membros da igreja.';
COMMENT ON COLUMN public.membros.data_de_nascimento IS 'Data de nascimento dos membros da igreja.';
COMMENT ON COLUMN public.membros.sexo IS 'Sexo dos membros da igreja.';
COMMENT ON COLUMN public.membros.estado_civil IS 'O estado civil dos membros da igreja.';

\echo
\echo Criando a tabela "membros_telefones" e objetos relacionados:

CREATE TABLE public.membros_telefones (
                codigo_membro INTEGER NOT NULL,
                numero VARCHAR(11) NOT NULL,
                tipo VARCHAR(50),
                CONSTRAINT pk_membros_telefones PRIMARY KEY (codigo_membro, numero)
);
COMMENT ON TABLE public.membros_telefones IS 'Tabela que armazena os telefones dos membros da igreja.';
COMMENT ON COLUMN public.membros_telefones.codigo_membro IS 'PFK desta tabela, já que se relaciona com a tabela membros. Código único e exclusivo de cada membro da igraja.';
COMMENT ON COLUMN public.membros_telefones.numero IS 'Número e DDD do telefone do membro da igreja, também é PK da tabela.';
COMMENT ON COLUMN public.membros_telefones.tipo IS 'Informa qual é o tipo de telefone.';

ALTER TABLE public.monetarios ADD CONSTRAINT doacoes_monetarios_fk
FOREIGN KEY (codigo_doacao)
REFERENCES public.doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.bens ADD CONSTRAINT doacoes_bens_fk
FOREIGN KEY (codigo_doacao)
REFERENCES public.doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.trabalhos ADD CONSTRAINT doacoes_trabalhos_fk
FOREIGN KEY (codigo_doacao)
REFERENCES public.doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.imagens ADD CONSTRAINT destinacoes_imagens_fk
FOREIGN KEY (nome_destinacao)
REFERENCES public.destinacoes (nome_destinacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.membros ADD CONSTRAINT uf_membros_fk
FOREIGN KEY (endereco_uf)
REFERENCES public.uf (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comunidades ADD CONSTRAINT uf_comunidades_fk
FOREIGN KEY (endereco_uf)
REFERENCES public.uf (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.membros ADD CONSTRAINT cidades_membros_fk
FOREIGN KEY (endereco_codigo_cidade)
REFERENCES public.cidades (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comunidades ADD CONSTRAINT cidades_comunidades_fk
FOREIGN KEY (edereco_codigo_cidade)
REFERENCES public.cidades (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.membros ADD CONSTRAINT bairros_membros_fk
FOREIGN KEY (edereco_codigo_bairro)
REFERENCES public.bairros (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comunidades ADD CONSTRAINT bairros_comunidades_fk
FOREIGN KEY (endereco_codigo_bairro)
REFERENCES public.bairros (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comunidades_telefones ADD CONSTRAINT comunidades_comunidades_telefones_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES public.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comunidades_emails ADD CONSTRAINT comunidades_comunidades_emails_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES public.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.atendidos ADD CONSTRAINT comunidades_atendidos_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES public.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comunidades_telefones ADD CONSTRAINT atendidos_comunidades_telefones_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES public.atendidos (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.membros_telefones ADD CONSTRAINT membros_membros_telefones_fk
FOREIGN KEY (codigo_membro)
REFERENCES public.membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;