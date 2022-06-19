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

--- criação de tabelas

\echo
\echo Criando a tabela "imagens" e objetos relacionados:
CREATE TABLE imagens (
                codigo_imagem INTEGER NOT NULL,
                nome VARCHAR(150) NOT NULL,
                descricao LONGVARCHAR NOT NULL,
                data_registro DATE NOT NULL,
                CONSTRAINT pk_imagens PRIMARY KEY (codigo_imagem)
);
COMMENT ON TABLE imagens IS 'Tabela que armazena dados sobre as imagens.';
COMMENT ON COLUMN imagens.codigo_imagem IS 'Cóodigo da imagem das destinações da igreja.';
COMMENT ON COLUMN imagens.nome IS 'Nomes das imagens.';
COMMENT ON COLUMN imagens.descricao IS 'Descrição das imagens das destinações da igreja.';
COMMENT ON COLUMN imagens.data_registro IS 'Data que as imagens foram registradas.';

--

\echo
\echo Criando a tabela "uf" e objetos relacionados:
CREATE TABLE uf (
                sigla CHAR(2) NOT NULL,
                nome VARCHAR(100) NOT NULL,
                CONSTRAINT pk_uf PRIMARY KEY (sigla)
);
COMMENT ON TABLE uf IS 'Tabela que armazena as unidades da federação.';
COMMENT ON COLUMN uf.sigla IS 'PK da tabela, é a sigla do estado.';
COMMENT ON COLUMN uf.nome IS 'Nome padronizado da unidade da federação.';

--

\echo
\echo Criando a tabela "cidades" e objetos relacionados:
CREATE TABLE cidades (
                codigo INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                CONSTRAINT pk_cidades PRIMARY KEY (codigo)
);
COMMENT ON TABLE cidades IS 'Tabela que armaena as cidades do estado.';
COMMENT ON COLUMN cidades.codigo IS 'PK da tabela, e o código único e exclusivo de cada cidade.';
COMMENT ON COLUMN cidades.nome IS 'Nome padronizado das cidades.';

--

\echo
\echo Criando a tabela "bairros" e objetos relacionados:
CREATE TABLE bairros (
                codigo INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                CONSTRAINT pk_bairros PRIMARY KEY (codigo)
);
COMMENT ON TABLE bairros IS 'Tabela que armazena os bairros das cidades.';
COMMENT ON COLUMN bairros.codigo IS 'PK inventada para esta tabela, e é o código único e exclusivo de identificação de cada bairro.';
COMMENT ON COLUMN bairros.nome IS 'Nomes dos bairros.';

--

\echo
\echo Criando a tabela "comunidades" e objetos relacionados:
CREATE TABLE comunidades (
                codigo_comunidade INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                endereco_logradouro VARCHAR(150) NOT NULL,
                endereco_numero VARCHAR(10) NOT NULL,
                endereco_complemento VARCHAR(10),
                endereco_codigo_bairro INTEGER NOT NULL,
                endereco_codigo_cidade INTEGER NOT NULL,
                endereco_uf CHAR(2) NOT NULL,
                endereco_cep CHAR(8) NOT NULL,
                CONSTRAINT pk_comunidades PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE comunidades IS 'Tabela que armazena dados sobre as comunidades da igreja.';
COMMENT ON COLUMN comunidades.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja.';
COMMENT ON COLUMN comunidades.nome IS 'Nome das comunidades da igreja.';
COMMENT ON COLUMN comunidades.endereco_logradouro IS 'Nome do logradouro do endereço.';
COMMENT ON COLUMN comunidades.endereco_numero IS 'Número dos endereços das comunidades.';
COMMENT ON COLUMN comunidades.endereco_complemento IS 'Complemento do endereço.';
COMMENT ON COLUMN comunidades.endereco_codigo_bairro IS 'FK para a tabela de bairros.';
COMMENT ON COLUMN comunidades.endereco_codigo_cidade IS 'FK para a tabela de cidades.';
COMMENT ON COLUMN comunidades.endereco_uf IS 'FK para a tabela de uf.';
COMMENT ON COLUMN comunidades.endereco_cep IS 'CEP dos endereços das comunidades.';

--

\echo
\echo Criando a tabela "imagem_comunidades" e objetos relacionados:
CREATE TABLE imagem_comunidades (
                codigo_comunidade INTEGER NOT NULL,
                codigo_imagem INTEGER NOT NULL,
                CONSTRAINT codigo_comunidade,_codigo_imagem PRIMARY KEY (codigo_comunidade, codigo_imagem)
);
COMMENT ON TABLE imagem_comunidades IS 'Tabela que guarda dados para as tabelas imagens e comunidades.';
COMMENT ON COLUMN imagem_comunidades.codigo_comunidade IS 'PFK para a tabela comunidades.';
COMMENT ON COLUMN imagem_comunidades.codigo_imagem IS 'PFK para a tabela imagens.';

--

\echo
\echo Criando a tabela "atendidos" e objetos relacionados:
CREATE TABLE atendidos (
                codigo_atendidos INTEGER NOT NULL,
                codigo_comunidade INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                cpf CHAR(11),
                cnpj CHAR(14),
                CONSTRAINT pk_atendidos PRIMARY KEY (codigo_atendidos)
);
COMMENT ON TABLE atendidos IS 'Tabela que armazena os atendidos das comunidades da igreja.';
COMMENT ON COLUMN atendidos.codigo_atendidos IS 'Código único e exclusivo que identifica os atendidos.';
COMMENT ON COLUMN atendidos.nome IS 'Nome dos atendidos das comunidades da igreja.';
COMMENT ON COLUMN atendidos.cpf IS 'CPF doa atendidos das comunidades da igreja.';
COMMENT ON COLUMN atendidos.cnpj IS 'CNPJ dos atendidos das comunidades da igreja.';

--

\echo
\echo Criando a tabela "imagem_atendidos" e objetos relacionados:
CREATE TABLE imagem_atendidos (
                codigo_atendidos INTEGER NOT NULL,
                codigo_imagem INTEGER NOT NULL,
                CONSTRAINT codigo_atendidos,_codigo_imagem PRIMARY KEY (codigo_atendidos, codigo_imagem)
);
COMMENT ON TABLE imagem_atendidos IS 'Tabela que guarda dados para as tabelas imagens e atendidos.';
COMMENT ON COLUMN imagem_atendidos.codigo_atendidos IS 'PFK para a tabela atendidos.';
COMMENT ON COLUMN imagem_atendidos.codigo_imagem IS 'PFK para a tabela imagens.';

--

\echo
\echo Criando a tabela "cadastram" e objetos relacionados:
CREATE TABLE cadastram (
                codigo_comunidade INTEGER NOT NULL,
                codigo_atendidos INTEGER NOT NULL,
                CONSTRAINT codigo_comunidade,_codigo_atendidos PRIMARY KEY (codigo_comunidade, codigo_atendidos)
);
COMMENT ON TABLE cadastram IS 'Tabela que guarda dados das tabelas comunidades e atendidos';
COMMENT ON COLUMN cadastram.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja.';
COMMENT ON COLUMN cadastram.codigo_atendidos IS 'Código único e exclusivo que identifica os atendidos.';

--

\echo
\echo Criando a tabela "comunidades_emails" e objetos relacionados:
CREATE TABLE comunidades_emails (
                codigo_comunidade INTEGER NOT NULL,
                email VARCHAR(100),
                CONSTRAINT pk_comunidades_emails PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE comunidades_emails IS 'Tabela que armazena os emails dss comunidades da igreja.';
COMMENT ON COLUMN comunidades_emails.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja, também é PFK para a tabela comunidades.';
COMMENT ON COLUMN comunidades_emails.email IS 'Email da comunidade da igreja, também é PK da tabela.';

--

\echo
\echo Criando a tabela "comunidades_telefones" e objetos relacionados:
CREATE TABLE comunidades_telefones (
                codigo_comunidade INTEGER NOT NULL,
                numero VARCHAR(11) NOT NULL,
                CONSTRAINT pk_comunidades_telefones PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE comunidades_telefones IS 'Tabela que armazena os telefones das comunidades da igreja.';
COMMENT ON COLUMN comunidades_telefones.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja, também é PFK para a tabela comunidades.';
COMMENT ON COLUMN comunidades_telefones.numero IS 'Número e DDD do telefone do cliente, também é PK da tabela.';

--

\echo
\echo Criando a tabela "membros" e objetos relacionados:
CREATE TABLE membros (
                codigo_membro INTEGER NOT NULL,
                nome VARCHAR(150) NOT NULL,
                endereco_logradouro VARCHAR(150) NOT NULL,
                endereco_numero VARCHAR(10) NOT NULL,
                endereco_complemento VARCHAR(10),
                endereco_codigo_bairro INTEGER NOT NULL,
                endereco_codigo_cidade INTEGER NOT NULL,
                endereco_uf CHAR(2) NOT NULL,
                endereco_cep CHAR(8) NOT NULL,
                profissao VARCHAR(100) NOT NULL,
                data_de_nascimento DATE NOT NULL,
                sexo CHAR(1) NOT NULL,
                estado_civil VARCHAR(100) NOT NULL,
                CONSTRAINT pk_membros PRIMARY KEY (codigo_membro)
);
COMMENT ON TABLE membros IS 'Tabela que armazena informações a respeito dos membros da igreja.';
COMMENT ON COLUMN membros.codigo_membro IS 'Código único e exclusivo que identifica os membros da igreja.';
COMMENT ON COLUMN membros.nome IS 'Nome dos membros da igrja.';
COMMENT ON COLUMN membros.endereco_logradouro IS 'Nome do logradouro do endereço.';
COMMENT ON COLUMN membros.endereco_numero IS 'Número do endereço do membro da igreja.';
COMMENT ON COLUMN membros.endereco_complemento IS 'Complemento do endereço.';
COMMENT ON COLUMN membros.endereco_codigo_bairro IS 'FK para a tabela de bairros.';
COMMENT ON COLUMN membros.endereco_codigo_cidade IS 'FK para a tabela de cidades.';
COMMENT ON COLUMN membros.endereco_uf IS 'FK para a tabela uf.';
COMMENT ON COLUMN membros.endereco_cep IS 'CEP do endereço do membro da igreja.';
COMMENT ON COLUMN membros.profissao IS 'Profissão dos membros da igreja.';
COMMENT ON COLUMN membros.data_de_nascimento IS 'Data de nascimento dos membros da igreja.';
COMMENT ON COLUMN membros.sexo IS 'Sexo dos membros da igreja.';
COMMENT ON COLUMN membros.estado_civil IS 'O estado civil dos membros da igreja.';

--

\echo
\echo Criando a tabela "colaboram" e objetos relacionados:
CREATE TABLE colaboram (
                codigo_membro INTEGER NOT NULL,
                membros_codigo_membro INTEGER NOT NULL,
                CONSTRAINT codigo_membro,_membros_codigo_membro PRIMARY KEY (codigo_membro, membros_codigo_membro)
);
COMMENT ON TABLE colaboram IS 'Tabela de autorelacionamento e que guarda dados para a tabela membros.';
COMMENT ON COLUMN colaboram.codigo_membro IS 'PFK para a tabela membros, autorelacionamento.';
COMMENT ON COLUMN colaboram.membros_codigo_membro IS 'PFK para a tabela membros, autorelacionamento.';

--

\echo
\echo Criando a tabela "doacoes" e objetos relacionados:
CREATE TABLE doacoes (
                codigo_doacao INTEGER NOT NULL,
                nome VARCHAR(150) NOT NULL,
                data_doacao DATE NOT NULL,
                identificacao_doador VARCHAR(150),
                tipo VARCHAR(100) NOT NULL,
                codigo_membro INTEGER NOT NULL,
                CONSTRAINT pk_doacoes PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE doacoes IS 'Tabela que armazena dados sobre as doações feitas para a igreja.';
COMMENT ON COLUMN doacoes.codigo_doacao IS 'Código único e exclusivo que identifica as doações da igreja.';
COMMENT ON COLUMN doacoes.nome IS 'Nome das doações.';
COMMENT ON COLUMN doacoes.data_doacao IS 'Data que aa doações foi feitas para a igreja.';
COMMENT ON COLUMN doacoes.identificacao_doador IS 'Identificação de quem fez a doação da igreja.';
COMMENT ON COLUMN doacoes.tipo IS 'Tipo da doação, monetária, bens ou trabalhos.';
COMMENT ON COLUMN doacoes.codigo_membro IS 'FK para a tabela membros.';

--

\echo
\echo Criando a tabela "destinacoes" e objetos relacionados:
CREATE TABLE destinacoes (
                codigo_doacao INTEGER NOT NULL,
                codigo_atendidos INTEGER NOT NULL,
                nome_destinacao VARCHAR NOT NULL,
                data DATE NOT NULL,
                obcervacoes LONGVARCHAR,
                recebedor VARCHAR(150) NOT NULL,
                CONSTRAINT codigo_doacao,_codigo_atendidos PRIMARY KEY (codigo_doacao, codigo_atendidos)
);
COMMENT ON TABLE destinacoes IS 'Guarda dados para as tabelas doacoes e atendidos, também traz informações a respeito das destinações.';
COMMENT ON COLUMN destinacoes.codigo_doacao IS 'Código único e exclusivo que identifica as doações da igreja.';
COMMENT ON COLUMN destinacoes.codigo_atendidos IS 'Código único e exclusivo que identifica os atendidos.';
COMMENT ON COLUMN destinacoes.nome_destinacao IS 'Nomes das destinações da igreja.';
COMMENT ON COLUMN destinacoes.data IS 'Datas da idas às destinações da igreja.';
COMMENT ON COLUMN destinacoes.obcervacoes IS 'Observações a respeito das destinações da igreja.';
COMMENT ON COLUMN destinacoes.recebedor IS 'Nomes dos recebedores nas destinações da igreja.';

--

\echo
\echo Criando a tabela "registram" e objetos relacionados:
CREATE TABLE registram (
                codigo_imagem INTEGER NOT NULL,
                codigo_doacao INTEGER NOT NULL,
                codigo_atendidos INTEGER NOT NULL,
                CONSTRAINT codigo_imagem,_codigo_doacao,_codigo_atendidos PRIMARY KEY (codigo_imagem, codigo_doacao, codigo_atendidos)
);
COMMENT ON TABLE registram IS 'Tabela que guarda dados das tabelas imagens e destinacoes.';
COMMENT ON COLUMN registram.codigo_imagem IS 'Cóodigo da imagem das destinações da igreja.';
COMMENT ON COLUMN registram.codigo_doacao IS 'Código único e exclusivo que identifica as doações da igreja.';
COMMENT ON COLUMN registram.codigo_atendidos IS 'Código único e exclusivo que identifica os atendidos.';

--

\echo
\echo Criando a tabela "trabalhos" e objetos relacionados:
CREATE TABLE trabalhos (
                codigo_doacao INTEGER NOT NULL,
                tipo_trabalho VARCHAR(100) NOT NULL,
                nome_doador VARCHAR(150) NOT NULL,
                CONSTRAINT pk_trabalhos PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE trabalhos IS 'Tabela que armazena dados a respeio das doações feitas em trabalhos voluntários para a igreja.';
COMMENT ON COLUMN trabalhos.codigo_doacao IS 'PFK para a tabela doacoes.';
COMMENT ON COLUMN trabalhos.tipo_trabalho IS 'Tipo do trabalho voluntário que foi doado para a igreja.';
COMMENT ON COLUMN trabalhos.nome_doador IS 'Nome de quem fez a doação em trabalho.';

--

\echo
\echo Criando a tabela "disponibilidade" e objetos relacionados:
CREATE TABLE disponibilidade (
                codigo_doacao_trabalhos INTEGER NOT NULL,
                data DATE NOT NULL,
                hora VARCHAR(5) NOT NULL,
                CONSTRAINT pk_disponibilidade PRIMARY KEY (codigo_doacao_trabalhos)
);
COMMENT ON COLUMN disponibilidade.codigo_doacao_trabalhos IS 'PFK para a tabela trabalhos.';
COMMENT ON COLUMN disponibilidade.data IS 'Datas disponíveis para a realização dos trabalhos.';
COMMENT ON COLUMN disponibilidade.hora IS 'Horários disponíveis para a realização dos trabalhos.';

--

\echo
\echo Criando a tabela "bens" e objetos relacionados:
CREATE TABLE bens (
                codigo_doacao INTEGER NOT NULL,
                descricao LONGNVARCHAR(1000) NOT NULL,
                tipo VARCHAR(100) NOT NULL,
                CONSTRAINT pk_bens PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE bens IS 'Tabela que armazena dados a respeio das doações feitas em bens para a igreja.';
COMMENT ON COLUMN bens.codigo_doacao IS 'PFK para a tabela doacoes.';
COMMENT ON COLUMN bens.descricao IS 'Descrição dos bens que foram doados para a igreja.';
COMMENT ON COLUMN bens.tipo IS 'Tipo dos bens que foram doados para a igreja';

--

\echo
\echo Criando a tabela "monetaria" e objetos relacionados:
CREATE TABLE monetaria (
                codigo_doacao INTEGER NOT NULL,
                valor DECIMAL(9,2) NOT NULL,
                tipo_moeda VARCHAR(100) NOT NULL,
                CONSTRAINT pk_monetaria PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE monetaria IS 'Tabela que armazena dados sobre as doações monetárias.';
COMMENT ON COLUMN monetaria.codigo_doacao IS 'PFK para a tabela doacoes.';
COMMENT ON COLUMN monetaria.valor IS 'Valor da doação feita para a igreja.';
COMMENT ON COLUMN monetaria.tipo_moeda IS 'Tipo da moeda que foi usada para fazer a doação para a igreja.';

--

\echo
\echo Criando a tabela "programas" e objetos relacionados:
CREATE TABLE programas (
                codigo_programa INTEGER NOT NULL,
                codigo_comunidade INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                descricao LONGVARCHAR(1000) NOT NULL,
                objetivos LONGVARCHAR(1000) NOT NULL,
                data_de_inicio DATE NOT NULL,
                data_final_prevista DATE,
                codigo_membro INTEGER NOT NULL,
                CONSTRAINT pk_programas PRIMARY KEY (codigo_programa)
);
COMMENT ON TABLE programas IS 'Tabela que armazena dados sobre os programas da igreja.';
COMMENT ON COLUMN programas.codigo_programa IS 'Código único e exclusivo que identifica os programas da igreja.';
COMMENT ON COLUMN programas.codigo_comunidade IS 'FK para a tabela comunidades, indica as comunidades que desenvolveram os pragramas.';
COMMENT ON COLUMN programas.nome IS 'Nomes dos programas.';
COMMENT ON COLUMN programas.descricao IS 'Descrição sobre o programa da igreja.';
COMMENT ON COLUMN programas.objetivos IS 'Objetivos que os programas da igreja almejam alcançar.';
COMMENT ON COLUMN programas.data_de_inicio IS 'Data de ínicio dos programas da igreja, quando eles começaram a acontecer.';
COMMENT ON COLUMN programas.data_final_prevista IS 'Data prevista para o final dos programas da igreja.';
COMMENT ON COLUMN programas.codigo_membro IS 'FK para a tabela mebros que identifica quais membros trabalham nos projetos.';

--

\echo
\echo Criando a tabela "desenvolvem" e objetos relacionados:
CREATE TABLE desenvolvem (
                codigo_programa INTEGER NOT NULL,
                codigo_comunidade INTEGER NOT NULL,
                CONSTRAINT codigo_programa,_codigo_comunidade PRIMARY KEY (codigo_programa, codigo_comunidade)
);
COMMENT ON TABLE desenvolvem IS 'Tabela que guarda dados para as tabelas programas e comunidades.';
COMMENT ON COLUMN desenvolvem.codigo_programa IS 'Código único e exclusivo que identifica os programas da igreja.';
COMMENT ON COLUMN desenvolvem.codigo_comunidade IS 'Código único e exclusivo que identifica as comunidades da igreja.';

--

\echo
\echo Criando a tabela "imagem_programas" e objetos relacionados:
CREATE TABLE imagem_programas (
                codigo_programa INTEGER NOT NULL,
                codigo_imagem INTEGER NOT NULL,
                CONSTRAINT codigo_programa,_codigo_imagem PRIMARY KEY (codigo_programa, codigo_imagem)
);
COMMENT ON TABLE imagem_programas IS 'Tabela que guarda dados para as tabelas programas e imagens.';
COMMENT ON COLUMN imagem_programas.codigo_programa IS 'PFK para a tabela programas.';
COMMENT ON COLUMN imagem_programas.codigo_imagem IS 'PFK para a tabela imagens.';


ALTER TABLE imagem_programas ADD CONSTRAINT imagens_imagem_programas_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE imagem_comunidades ADD CONSTRAINT imagens_imagem_comunidades_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE imagem_atendidos ADD CONSTRAINT imagens_imagem_atendidos_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE registram ADD CONSTRAINT imagens_registram_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE membros ADD CONSTRAINT uf_membros_fk
FOREIGN KEY (endereco_uf)
REFERENCES uf (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE comunidades ADD CONSTRAINT uf_comunidades_fk
FOREIGN KEY (endereco_uf)
REFERENCES uf (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE membros ADD CONSTRAINT cidades_membros_fk
FOREIGN KEY (endereco_codigo_cidade)
REFERENCES cidades (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE comunidades ADD CONSTRAINT cidades_comunidades_fk
FOREIGN KEY (endereco_codigo_cidade)
REFERENCES cidades (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE membros ADD CONSTRAINT bairros_membros_fk
FOREIGN KEY (endereco_codigo_bairro)
REFERENCES bairros (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE comunidades ADD CONSTRAINT bairros_comunidades_fk
FOREIGN KEY (endereco_codigo_bairro)
REFERENCES bairros (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE comunidades_telefones ADD CONSTRAINT comunidades_comunidades_telefones_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE comunidades_emails ADD CONSTRAINT comunidades_comunidades_emails_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cadastram ADD CONSTRAINT comunidades_cadastram_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE atendidos ADD CONSTRAINT comunidades_atendidos_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE imagem_comunidades ADD CONSTRAINT comunidades_imagem_comunidades_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE desenvolvem ADD CONSTRAINT comunidades_desenvolvem_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE programas ADD CONSTRAINT comunidades_programas_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cadastram ADD CONSTRAINT atendidos_cadastram_fk
FOREIGN KEY (codigo_atendidos)
REFERENCES atendidos (codigo_atendidos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE imagem_atendidos ADD CONSTRAINT atendidos_imagem_atendidos_fk
FOREIGN KEY (codigo_atendidos)
REFERENCES atendidos (codigo_atendidos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE destinacoes ADD CONSTRAINT atendidos_destinacoes_fk
FOREIGN KEY (codigo_atendidos)
REFERENCES atendidos (codigo_atendidos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE programas ADD CONSTRAINT membros_programas_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE doacoes ADD CONSTRAINT membros_doacoes_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE colaboram ADD CONSTRAINT membros_colaboram_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE colaboram ADD CONSTRAINT membros_colaboram_fk1
FOREIGN KEY (membros_codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE monetaria ADD CONSTRAINT doacoes_monetaria_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE bens ADD CONSTRAINT doacoes_bens_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalhos ADD CONSTRAINT doacoes_trabalhos_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE destinacoes ADD CONSTRAINT doacoes_destinacoes_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE registram ADD CONSTRAINT destinacoes_registram_fk
FOREIGN KEY (codigo_doacao, codigo_atendidos)
REFERENCES destinacoes (codigo_doacao, codigo_atendidos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE disponibilidade ADD CONSTRAINT trabalhos_disponibilidade_fk
FOREIGN KEY (codigo_doacao_trabalhos)
REFERENCES trabalhos (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE imagem_programas ADD CONSTRAINT programas_imagem_programas_fk
FOREIGN KEY (codigo_programa)
REFERENCES programas (codigo_programa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE desenvolvem ADD CONSTRAINT programas_desenvolvem_fk
FOREIGN KEY (codigo_programa)
REFERENCES programas (codigo_programa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;