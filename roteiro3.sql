CREATE TYPE estado AS ENUM ('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE');

CREATE TYPE endereco AS ENUM('CASA', 'TRABALHO', 'OUTRO');

CREATE TYPE tipo_func AS ENUM('FARM', 'VEND', 'ENTREG', 'CAIXA', 'ADM');



CREATE TABLE farmacia( 
id INTEGER PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
bairro VARCHAR(20) NOT NULL,
cidade VARCHAR(20) NOT NULL,
estado estado NOT NULL,
tipo VARCHAR(6) NOT NULL,
gerente_cpf CHAR(11) NOT NULL,
tipo_gerente tipo_func NOT NULL
);

ALTER TABLE farmacia ADD CONSTRAINT validade_tipo CHECK(tipo='SEDE' OR tipo='FILIAL');

ALTER TABLE farmacia ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =,
nome WITH =) WHERE (tipo = 'SEDE');

ALTER TABLE farmacia ADD CONSTRAINT validade_gerente CHECK(tipo_gerente='FARM' OR tipo_gerente='ADM');

ALTER TABLE farmacia ADD CONSTRAINT validade_bairro EXCLUDE USING gist(bairro WITH =, cidade WITH=);




CREATE TABLE funcionario(
nome VARCHAR(40) NOT NULL,
cpf CHAR(11) PRIMARY KEY,
funcao tipo_func NOT NULL,
locacao INTEGER REFERENCES farmacia (id)
);



ALTER TABLE farmacia ADD FOREIGN KEY (gerente_cpf) REFERENCES funcionario (cpf);



CREATE TABLE medicamento(
id INTEGER PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
preco NUMERIC,
receita BOOLEAN NOT NULL
);



CREATE TABLE venda(
id_medicamento INTEGER REFERENCES medicamento (id) NOT NULL,
dia_venda DATE,
id_venda INTEGER PRIMARY KEY,
receita BOOLEAN NOT NULL,
cpf_cliente CHAR(11) REFERENCES cliente (cpf),
cpf_vendedor CHAR(11) REFERENCES funcionario (cpf) NOT NULL,
tipo_vendedor tipo_func NOT NULL
);

ALTER TABLE venda ADD CONSTRAINT validade_func CHECK(tipo_vendedor='VEND');
ALTER TABLE venda ADD CONSTRAINT validade_receita CHECK((receita=true AND cpf_cliente IS NOT NULL) OR receita=false);




CREATE TABLE cliente(
nome VARCHAR(40) NOT NULL,
cpf CHAR(11) PRIMARY KEY,
data_nasc DATE NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT de_maior CHECK(date_part('year', age(data_nasc)) >= 18);




CREATE TABLE endereco_cliente(
id INTEGER PRIMARY KEY,
cpf_cliente CHAR(11) REFERENCES cliente (cpf) NOT NULL,
estado estado NOT NULL,
cidade VARCHAR(20) NOT NULL,
bairro VARCHAR(20) NOT NULL,
rua VARCHAR(30) NOT NULL,
numero INTEGER NOT NULL,
tipo endereco NOT NULL
);



CREATE TABLE entrega(
id_venda INTEGER REFERENCES venda (id_venda) NOT NULL,
cliente_cpf CHAR(11) REFERENCES cliente (cpf) NOT NULL,
tipo_end endereco,
dia DATE,
id_entrega INTEGER PRIMARY KEY
);


--inserindo funcionarios
INSERT INTO funcionario VALUES ('Aparecida','12345678900', 'FARM', null);

INSERT INTO funcionario VALUES ('Jorge','12345678901', 'VEND', null);

INSERT INTO funcionario VALUES ('Matheus','12345678902', 'ENTREG', null);

INSERT INTO funcionario VALUES ('Fabiana','12345678903', 'ADM', null);

--inserindo farmacia Redepharma como sede e ja com gerente alocado
INSERT INTO farmacia VALUES (0, 'Redepharma', 'Catolé', 'Campina Grande', 'PB', 'SEDE', '12345678903', 'ADM');

--atualizando locaçao do gerente
UPDATE funcionario SET locacao=0 WHERE cpf='12345678903';

--inserindo farmacia Redepharma como filial e ja cocm gerente alocado
INSERT INTO farmacia VALUES (1, 'Redepharma', 'Cruzeiro', 'Campina Grande', 'PB', 'FILIAL', '12345678900', 'FARM');

--atualizando locaçao do gerente
UPDATE funcionario SET locacao=1 WHERE cpf='12345678900';

--inserindo mais um funcionario
INSERT INTO funcionario VALUES ('Luiza','12345678904', 'FARM', null);

--inserindo farmacia Pague Menos como sede e ja com gerente alocado
INSERT INTO farmacia VALUES (2, 'Pague Menos', 'Liberdade', 'Campina Grande', 'PB', 'SEDE', '12345678904', 'FARM');

--atualizando locaçao do gerente
UPDATE funcionario SET locacao=2 WHERE cpf='12345678904';

--tentando inserir uma nova farmacia em um bairro ja ocupado: ERRO
INSERT INTO farmacia VALUES (3, 'Drogasil', 'Liberdade', 'Campina Grande', 'PB', 'SEDE', '12345678904', 'FARM');

--tentando inserir outra farmacia de nome Redepharma do tipo sede: ERRO
INSERT INTO farmacia VALUES (3, 'Redepharma', 'Centro', 'Campina Grande', 'PB', 'SEDE', '12345678904', 'FARM');

--tentando inserir uma farmacia com um gerente que nao é farmaceutico nem administrador: ERRO
INSERT INTO farmacia VALUES (3, 'Redepharma', 'Centro', 'Campina Grande', 'PB', 'FILIAL', '12345678901', 'VEND');

--inserindo clientes
INSERT INTO cliente VALUES ('Sebastiao', '12345678905', '1970-01-01');

INSERT INTO cliente VALUES ('Maria de Lourdes', '12345678906', '1990-01-01');

--tentando inserir cliente de menor: ERRO
INSERT INTO cliente VALUES ('Marianna', '12345678907', '2003-01-01');

--inserindo endereços de clientes
INSERT INTO endereco_cliente VALUES (0, '12345678905', 'PB', 'Campina Grande', 'Liberdade', 'Rua Espirito Santo', 125, 'CASA');

INSERT INTO endereco_cliente VALUES (1, '12345678905', 'PB', 'Campina Grande', 'Centro', 'Rua Irineu Jofily', 320, 'TRABALHO');

INSERT INTO endereco_cliente VALUES (2, '12345678906', 'PB', 'Campina Grande', 'Centro', 'Rua Treze de Maio', 240, 'OUTRO');

--inserindo medicamentos
INSERT INTO medicamento VALUES (0, 'dipirona', 10.00, false);

INSERT INTO medicamento VALUES (1, 'amoxicilina', 20.00, true);

--inserindo vendas
INSERT INTO venda VALUES (0, null, 0, false, null, '12345678901', 'VEND');
INSERT INTO venda VALUES (1, null, 1, true, '12345678906', '12345678901', 'VEND');

--tentando inserir venda com receita para um cliente nao registrado: ERRO
INSERT INTO venda VALUES (1, null, 2, true, null, '12345678901', 'VEND');

--tentando inserir uma venda em que o funcionario responsavel pela mesma nao é vendedor: ERRO
INSERT INTO venda VALUES (0, null, 3, false, null, '12345678900', 'FARM');

--inserindo entregas
INSERT INTO entrega VALUES (1, '12345678906', 'OUTRO', '2020-01-01', 0);
















