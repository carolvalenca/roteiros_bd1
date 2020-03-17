-- ******CRIAÇAO DE TABELAS******

--DADOS DE SEGURADO
--optei por colocar apenas cpf, cnh, nome e telefone
--segurado nao faz referencia ao seu automovel pois imaginei que um segurado pode ter mais de um automovel
CREATE TABLE segurado(
cpf INTEGER PRIMARY KEY,
cnh INTEGER,
nome VARCHAR (40),
telefone VARCHAR(15)
);

--DADOS DE AUTOMOVEL
--optei por colocar placa, cor, marca, modelo, ano e uma referencia ao segurado (dono do automovel)
CREATE TABLE automovel(
placa VARCHAR(7) PRIMARY KEY,
cor VARCHAR(10),
marca VARCHAR(10),
modelo VARCHAR(20),
ano INTEGER,
fk_segurado INTEGER REFERENCES segurado (cpf)
);

--DADOS DE PERITO
--nao sei exatamente os dados necessarios para um perito de seguro, entao coloquei apenas cpf, nome e telefone
CREATE TABLE perito(
cpf INTEGER PRIMARY KEY,
nome VARCHAR(40),
telefone VARCHAR(15)
);

--DADOS DE OFICINA
--os dados de oficinas conveniadas a seguradora incluem cnpj, nome, endereco e telefone
CREATE TABLE oficina(
cnpj INTEGER PRIMARY KEY,
nome VARCHAR(30),
endereco VARCHAR(40),
telefone VARCHAR(15)
);

--DADOS DE SEGURO
--como dados necessarios para um seguro coloquei o valor, data de inicio do seguro (dia em que foi assinado o contrato),
--validade (data em que vence o contrato), uma fk para o automovel na qual o seguro se refere e um codigo em inteiro para
--ser a primary key da tupla
CREATE TABLE seguro(
num_contrato INTEGER PRIMARY KEY,
valor NUMERIC,
data_inicio DATE,
validade DATE,
fk_carro VARCHAR(7) REFERENCES automovel (placa)
);

--DADOS DE SINISTRO
--tambem nao compreendi 100% o que era necessario para uma relaçao que armazena sinistros, entao optei por colocar a data 
--de ocorrencia (acidente), tipo de ocorrencia, uma fk para o seguro do automovel, uam fk para o segurado do automovel e 
--um codigo em inteiro com o intuito de ser a primary key como dados validos para um sinistro
CREATE TABLE sinistro(
data_ocorrencia TIMESTAMP,
tipo_ocorrencia VARCHAR(20),
cod_ocorrencia INTEGER PRIMARY KEY,
fk_seguro INTEGER REFERENCES seguro (num_contrato),
fk_segurado INTEGER REFERENCES segurado (cpf)
);

--DADOS DE PERICIA
--para pericia, optei apenas por armazenar as partes danificadas do automovel segurado, uma fk referenciando o perito responsavel
--pela pericia e um codigo em inteiro para ser a primary key da pericia
CREATE TABLE pericia(
partes_danificadas VARCHAR(100),
cod_pericia INTEGER PRIMARY KEY,
fk_perito INTEGER REFERENCES perito (cpf)
);

--DADOS DE REPARO
--em reparo, considerei que todos os reparos necessarios no automovel segurado fossem feitos de uma vez, entao, como dados de reparo
--estao apenas a data em que os reparos foram feitos/terminados, uma fk para o automovel reparado, uma fk para a oficina responsavel
--pelo reparo e um codigo em inteiro para ser a primary key de uma tupla
CREATE TABLE reparo(
data_reparo DATE,
cod_reparo INTEGER PRIMARY KEY,
fk_carro VARCHAR(7) REFERENCES automovel (placa),
fk_oficina INTEGER REFERENCES oficina (cnpj)
);




-- ******SETANDO ATRIBUTOS FK PARA NOT NULL******
--com o intuito de garantir parte da integridade das relaçoes, optei por setar todos os atributos que sao fk como NOT NULL
ALTER TABLE automovel ALTER COLUMN fk_segurado SET NOT NULL;
ALTER TABLE seguro ALTER COLUMN fk_carro SET NOT NULL;
ALTER TABLE sinistro ALTER COLUMN fk_seguro SET NOT NULL;
ALTER TABLE sinistro ALTER COLUMN fk_segurado SET NOT NULL;
ALTER TABLE pericia ALTER COLUMN fk_perito SET NOT NULL;
ALTER TABLE reparo ALTER COLUMN fk_carro SET NOT NULL;
ALTER TABLE reparo ALTER COLUMN fk_oficina SET NOT NULL;

--setei tais atributos a seguir como NOT NULL pois achei que todos eram importantes e não podiam ter valor null em algum momento
ALTER TABLE segurado ALTER COLUMN cnh SET NOT NULL;
ALTER TABLE segurado ALTER COLUMN nome SET NOT NULL;

ALTER TABLE perito ALTER COLUMN nome SET NOT NULL;

ALTER TABLE seguro ALTER COLUMN valor SET NOT NULL;
ALTER TABLE seguro ALTER COLUMN validade SET NOT NULL;

ALTER TABLE sinistro ALTER COLUMN data_ocorrencia SET NOT NULL;

ALTER TABLE pericia ALTER COLUMN partes_danificadas SET NOT NULL;

ALTER TABLE reparo ALTER COLUMN data_reparo SET NOT NULL;




-- ******EXCLUINDO RELAÇOES******
--excluindo relaçoes em cascata para nao ferir a integridade referencial de nenhuma relaçao 
DROP TABLE segurado CASCADE;
DROP TABLE automovel CASCADE;
DROP TABLE perito CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE seguro CASCADE;
DROP TABLE sinistro CASCADE;
DROP TABLE pericia CASCADE;
DROP TABLE reparo CASCADE;




