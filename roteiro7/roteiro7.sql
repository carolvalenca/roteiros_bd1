CREATE TABLE time (
   nome varchar(255)  NOT NULL,
   cpf_tecnico char(11)  NOT NULL,
   CONSTRAINT time_pk PRIMARY KEY (nome)
);

CREATE TABLE jogador (
   idade int  NULL,
   cpf char(11)  NOT NULL,
   posicao varchar(255)  NOT NULL,
   time_nome varchar(255)  NOT NULL,
   CONSTRAINT jogador_pk PRIMARY KEY (cpf)
);

CREATE TABLE jogo (
   id int  NOT NULL,
   time1 varchar(255)  NOT NULL,
   time2 varchar(255)  NOT NULL,
   pontuacao varchar(10)  NOT NULL,
   time_vencedor varchar(255)  NULL,
   data_jogo date  NOT NULL,
   CONSTRAINT jogo_pk PRIMARY KEY (id)
);

CREATE TABLE jogou_em (
   id int  NOT NULL,
   jogo_id int  NOT NULL,
   jogador_cpf char(11)  NOT NULL,
   time_nome varchar(255)  NOT NULL,
   CONSTRAINT jogou_em_pk PRIMARY KEY (id)
);

INSERT INTO time VALUES ('flamengo', '12358794582');
INSERT INTO time VALUES ('palmeiras', '12358894582');
INSERT INTO time VALUES ('treze', '12358794598');
INSERT INTO time VALUES ('botafogo', '87358794582');
INSERT INTO time VALUES ('campinense', '12358794588');

INSERT INTO jogador VALUES (20, '25879658415', 'goleiro', 'flamengo');
INSERT INTO jogador VALUES (30, '25879658414', 'atacante', 'flamengo');
INSERT INTO jogador VALUES (20, '25879658416', 'zagueiro', 'flamengo');
INSERT INTO jogador VALUES (null, '25879658417', 'lateral direito', 'flamengo');
INSERT INTO jogador VALUES (35, '25879658418', 'lateral esquerdo', 'flamengo');
INSERT INTO jogador VALUES (null, '25879658419', 'volante', 'flamengo');
INSERT INTO jogador VALUES (20, '25879658420', 'meia', 'flamengo');
INSERT INTO jogador VALUES (null, '25879658421', 'goleiro', 'flamengo');
INSERT INTO jogador VALUES (20, '25879658422', 'atacante', 'flamengo');

INSERT INTO jogador VALUES (20, '25879658423', 'goleiro', 'palmeiras');
INSERT INTO jogador VALUES (30, '25879658424', 'atacante', 'palmeiras');
INSERT INTO jogador VALUES (20, '25879658425', 'zagueiro', 'palmeiras');
INSERT INTO jogador VALUES (null, '25879658426', 'lateral direito', 'palmeiras');
INSERT INTO jogador VALUES (35, '25879658427', 'lateral esquerdo', 'palmeiras');
INSERT INTO jogador VALUES (null, '25879658428', 'volante', 'palmeiras');
INSERT INTO jogador VALUES (20, '25879658429', 'meia', 'palmeiras');
INSERT INTO jogador VALUES (null, '25879658430', 'goleiro', 'palmeiras');
INSERT INTO jogador VALUES (20, '25879658431', 'atacante', 'palmeiras');

INSERT INTO jogador VALUES (20, '25879658432', 'goleiro', 'treze');
INSERT INTO jogador VALUES (30, '25879658433', 'atacante', 'treze');
INSERT INTO jogador VALUES (20, '25879658434', 'zagueiro', 'treze');
INSERT INTO jogador VALUES (null, '25879658435', 'lateral direito', 'treze');
INSERT INTO jogador VALUES (35, '25879658436', 'lateral esquerdo', 'treze');
INSERT INTO jogador VALUES (null, '25879658437', 'volante', 'treze');
INSERT INTO jogador VALUES (20, '25879658438', 'meia', 'treze');
INSERT INTO jogador VALUES (null, '25879658439', 'goleiro', 'treze');
INSERT INTO jogador VALUES (20, '25879658440', 'atacante', 'treze');

INSERT INTO jogo VALUES (1, 'flamengo', 'palmeiras', '5x2', 'flamengo', now());
INSERT INTO jogo VALUES (2, 'flameng', 'treze', '0x3', 'treze', now());
-- INSERT INTO jogo VALUES (3, 'palmeiras', 'treze', '0x0', '', now());

INSERT INTO jogou_em VALUES (1, 1, '25879658415', 'flamengo');
INSERT INTO jogou_em VALUES (2, 1, '25879658414', 'flamengo');
INSERT INTO jogou_em VALUES (3, 1, '25879658416', 'flamengo');
INSERT INTO jogou_em VALUES (4, 1, '25879658417', 'flamengo');
INSERT INTO jogou_em VALUES (5, 1, '25879658418', 'flamengo');
INSERT INTO jogou_em VALUES (6, 1, '25879658419', 'flamengo');
INSERT INTO jogou_em VALUES (7, 1, '25879658420', 'flamengo');

INSERT INTO jogou_em VALUES (8, 1, '25879658423', 'palmeiras');
INSERT INTO jogou_em VALUES (9, 1, '25879658424', 'palmeiras');
INSERT INTO jogou_em VALUES (10, 1, '25879658425', 'palmeiras');
INSERT INTO jogou_em VALUES (11, 1, '25879658426', 'palmeiras');
INSERT INTO jogou_em VALUES (12, 1, '25879658427', 'palmeiras');
INSERT INTO jogou_em VALUES (13, 1, '25879658428', 'palmeiras');
INSERT INTO jogou_em VALUES (14, 1, '25879658429', 'palmeiras');

INSERT INTO jogou_em VALUES (28, 2, '25879658415', 'flamengo');
INSERT INTO jogou_em VALUES (15, 2, '25879658414', 'flamengo');
INSERT INTO jogou_em VALUES (16, 2, '25879658416', 'flamengo');
INSERT INTO jogou_em VALUES (17, 2, '25879658417', 'flamengo');
INSERT INTO jogou_em VALUES (18, 2, '25879658418', 'flamengo');
INSERT INTO jogou_em VALUES (19, 2, '25879658419', 'flamengo');
INSERT INTO jogou_em VALUES (20, 2, '25879658420', 'flamengo');

INSERT INTO jogou_em VALUES (21, 2, '25879658432', 'treze');
INSERT INTO jogou_em VALUES (22, 2, '25879658433', 'treze');
INSERT INTO jogou_em VALUES (23, 2, '25879658434', 'treze');
INSERT INTO jogou_em VALUES (24, 2, '25879658435', 'treze');
INSERT INTO jogou_em VALUES (25, 2, '25879658436', 'treze');
INSERT INTO jogou_em VALUES (26, 2, '25879658437', 'treze');
INSERT INTO jogou_em VALUES (27, 2, '25879658438', 'treze');




