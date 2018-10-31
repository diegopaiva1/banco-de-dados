-- Instituição
CREATE TABLE instituicao (
	id SERIAL PRIMARY KEY,
	sigla VARCHAR(10) UNIQUE NOT NULL,
	nome VARCHAR(100) UNIQUE NOT NULL 
);

-- Participante
CREATE TABLE participante (
	CPF VARCHAR(15) PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	senha VARCHAR(500) NOT NULL,
	id_instituicao INTEGER REFERENCES instituicao (id)
);

-- Avaliador de eventos
CREATE TABLE avaliador_evento (
	CPF VARCHAR(15) REFERENCES participante (CPF) PRIMARY KEY,
        qt_eventos_aprovados INTEGER DEFAULT 0 NOT NULL,
	qt_eventos_recusados INTEGER DEFAULT 0 NOT NULL
);

-- Avaliador de artigos
CREATE TABLE avaliador_artigo (
	CPF VARCHAR(15) REFERENCES participante (CPF) PRIMARY KEY,
        qt_artigos_aprovados INTEGER DEFAULT 0 NOT NULL,
	qt_artigos_recusados INTEGER DEFAULT 0 NOT NULL
);

-- Palestrante
CREATE TABLE palestrante (
	CPF VARCHAR(15) REFERENCES participante (CPF) PRIMARY KEY
);

-- Autor
CREATE TABLE autor (
	CPF VARCHAR(15) REFERENCES participante (CPF) PRIMARY KEY
);

-- Responsável
CREATE TABLE responsavel (
	CPF VARCHAR(15) REFERENCES participante (CPF) PRIMARY KEY
);

-- Administrador
CREATE TABLE administrador (
	CPF VARCHAR(15) REFERENCES participante (CPF) PRIMARY KEY
);

-- Área do conhecimento
CREATE TABLE area_conhecimento (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) UNIQUE NOT NULL,
	id_area_pai INTEGER REFERENCES area_conhecimento (id)
);

-- Artigo
CREATE TYPE STATUS AS ENUM ('Aguardando Aprovação', 'Aprovado', 'Recusado');
CREATE TABLE artigo (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	resumo TEXT NOT NULL,
	arquivo VARCHAR(255) NOT NULL,
	status STATUS NOT NULL DEFAULT 'Aguardando Aprovação',
	CPF_avaliador VARCHAR(15) REFERENCES avaliador_artigo (CPF),
	motivo_avaliacao TEXT
);

-- Áreas do conhecimento dos artigos
CREATE TABLE artigo_areas_conhecimento (
	id_artigo INTEGER NOT NULL REFERENCES artigo (id),
	id_area_conhecimento INTEGER NOT NULL REFERENCES area_conhecimento (id),
	PRIMARY KEY (id_artigo, id_area_conhecimento)
);

-- Estrelas fornecidas pelo participante em artigos 
CREATE TABLE participante_estrelas_artigo (
	CPF_participante VARCHAR(15) NOT NULL REFERENCES participante (CPF),
	id_artigo INTEGER NOT NULL REFERENCES artigo (id),
	qt_estrelas INTEGER NOT NULL,
	PRIMARY KEY (CPF_participante, id_artigo)
);

-- Publicação 
CREATE TABLE publicacao (
	CPF_autor VARCHAR(15) NOT NULL REFERENCES autor (CPF),
	id_artigo INTEGER NOT NULL REFERENCES artigo (id),
	data_publicacao TIMESTAMP NOT NULL,
	PRIMARY KEY (CPF_autor, id_artigo)
);

-- Organização 
CREATE TABLE organizacao (
	CNPJ VARCHAR(20) PRIMARY KEY,
	nome VARCHAR(100) UNIQUE NOT NULL,
	imagem VARCHAR(255) NOT NULL,
	telefone VARCHAR(50) NOT NULL,
	descricao TEXT
);

-- Evento 
CREATE TYPE TIPO AS ENUM ('Congresso', 'Conferência', 'Curso', 'Encontro', 'Fórum', 'Jornada', 'Mesa-redonda', 'Seminário', 'Simpósio', 'Workshop');
CREATE TABLE evento (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	tipo TIPO NOT NULL,
	data_realizacao TIMESTAMP NOT NULL,
	horario_comeco TIME NOT NULL,
	horario_termino TIME NOT NULL,
	pais VARCHAR(191) NOT NULL,
	estado VARCHAR(191) NOT NULL,
	cidade VARCHAR(191) NOT NULL,
	logradouro VARCHAR(191) NOT NULL,
	bairro VARCHAR(191) NOT NULL,
	CEP VARCHAR(50) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	complemento VARCHAR(191),
	data_maxima_inscricao TIMESTAMP NOT NULL,
	descricao TEXT NOT NULL,
	valor DECIMAL(11, 2) NOT NULL,
	numero_maximo_participantes INTEGER NOT NULL,
	CPF_avaliador VARCHAR(15) REFERENCES avaliador_evento (CPF),
	motivo_avaliacao TEXT,
	id_instituicao INTEGER REFERENCES instituicao (id),
	id_artigo INTEGER REFERENCES artigo (id),
	CNPJ_organizacao VARCHAR(20) NOT NULL REFERENCES organizacao (CNPJ),
	CPF_responsavel VARCHAR(15) NOT NULL REFERENCES participante (CPF),
	data_criacao TIMESTAMP NOT NULL
);


-- Forma de pagamento
CREATE TABLE forma_pagamento (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) UNIQUE NOT NULL
);

-- Formas de pagamento dos eventos
CREATE TABLE evento_formas_pagamento (
	id_evento INTEGER NOT NULL REFERENCES evento (id),
	id_forma_pagamento INTEGER NOT NULL REFERENCES forma_pagamento (id),
	PRIMARY KEY (id_evento, id_forma_pagamento)
);

-- Áreas de conhecimento dos eventos
CREATE TABLE evento_areas_conhecimento (
	id_evento INTEGER NOT NULL REFERENCES evento (id),
	id_area_conhecimento INTEGER NOT NULL REFERENCES area_conhecimento (id),
	PRIMARY KEY (id_evento, id_area_conhecimento)
);

-- Inscrição
CREATE TYPE STATUS_PAGAMENTO AS ENUM ('Aguardando Pagamento', 'Aprovado', 'Recusado');
CREATE TABLE inscricao (
	CPF_participante VARCHAR(15) NOT NULL REFERENCES participante (CPF),
	id_evento INTEGER NOT NULL REFERENCES evento (id),
	id_forma_pagamento INTEGER NOT NULL REFERENCES forma_pagamento (id),
	codigo VARCHAR(255) UNIQUE NOT NULL,
	data_inscricao TIMESTAMP NOT NULL, 
	status STATUS_PAGAMENTO NOT NULL DEFAULT 'Aguardando Pagamento',
	PRIMARY KEY (CPF_participante, id_evento)
);

-- Ingresso
CREATE TABLE ingresso (
        codigo VARCHAR(255) UNIQUE NOT NULL,
	CPF_participante VARCHAR(15) NOT NULL REFERENCES participante (CPF),
	id_evento INTEGER NOT NULL REFERENCES evento (id),
	PRIMARY KEY (codigo, CPF_participante, id_evento)
);

-- Eventos ministrados pelos palestrantes
CREATE TABLE palestrante_ministra_evento (
	id_evento INTEGER NOT NULL REFERENCES evento (id),
	CPF_palestrante VARCHAR(15) NOT NULL REFERENCES palestrante (CPF),
	PRIMARY KEY (id_evento, CPF_palestrante)
);

-- Certificado
CREATE TABLE certificado (
	CPF_participante VARCHAR(15) NOT NULL REFERENCES participante (CPF),
	id_evento INTEGER NOT NULL REFERENCES evento (id),
	codigo VARCHAR(255) UNIQUE NOT NULL,
	carga_horaria_total TIME NOT NULL,
	PRIMARY KEY (CPF_participante, id_evento)
);

-- Instituições
INSERT INTO instituicao(id, sigla, nome) VALUES (
	1, 
	'UFJF', 
	'Universidade Federal de Juiz de Fora'
);

INSERT INTO instituicao(id, sigla, nome) VALUES (
	2, 
	'UFRJ', 
	'Universidade Federal do Rio de Janeiro'
);

INSERT INTO instituicao(id, sigla, nome) VALUES (
	3, 
	'USP', 
	'Universidade de São Paulo'
);

INSERT INTO instituicao(id, sigla, nome) VALUES (
	4, 
	'UFC', 
	'Universidade Federal do Ceará'
);

INSERT INTO instituicao(id, sigla, nome) VALUES (
	5, 
	'UFSM', 
	'Universidade Federal de Santa Maria'
);

-- Participantes
INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'191.011.112-11', 
	'Diego Paiva e Silva', 
	'30/06/1997',
	'diego.paiva@ice.ufjf.br',
	'$1$AVbfJOzY$oIHHCHlD76Aw1xmjfTpm1',  
	1
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'101.999.333-51', 
	'João Roberto Ferreira', 
	'15/04/1962',
	'joaorobertoferreira@hotmail.com',
	'$2y$10$3eUn9Rnf04DR.aj8R3WbHuBO9EdoceH9uKf6vMiD7tz766rMNOyTO',
	NULL  
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'653.101.962-33', 
	'Marcela Fernandes Duarte', 
	'12/11/1992',
	'marcelafduarte@gmail.com',
	'$1$MNOyTbfJH9uKBOn9Rnf0',  
	4
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'950.318.102-21', 
	'Miguel Marinho Silva', 
	'27/02/1985',
	'miguelmarinho@outlook.com',
	'$2y$vmjfTMNOBNOyTRl9.3nLkXx013aBL10v',  
	NULL
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'033.181.019-71', 
	'Maria Luísa Souza', 
	'31/12/1996',
	'marialuisasouza@gmail.com',
	'$2y$OyTRl9OBNOyjaj287h5hi45YGLQQHq9q',  
	NULL
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'180.955.366-00', 
	'Luís Fernando Brito de Magalhães', 
	'01/07/1973',
	'lfbrito@gmail.com',
	'$1y$hKsdnj12mN810Nlkm3f$.sj313F',  
	3
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'012.652.102-96', 
	'Ramon Correa Sampaio', 
	'25/10/1989',
	'ramoncs10@gmail.com',
	'$1hn$a28NSK21N0kjaurnKJJwe0ALCCiw1$kjaDQP382',  
	5
);
INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'306.984.654-00', 
	'Stella Soares Leitão', 
	'13/09/1998',
	'stella12@gmail.com',
	'$2aj$NE43n3n21nKKabedalOWBE24NS8aBjaRs13',  
	2
);
INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'901.625.987-01', 
	'Cida Ferreira Ribeiro', 
	'15/05/1958',
	'cidafr@hotmail.com',
	'$2y$2734NadalwN0283Hele82Nskh3Ns2732Fqjkw8',  
	2
);

INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'130.925.698-01', 
	'Jorge de Sá Menezes', 
	'12/01/1966',
	'jsamenezes@gmail.com',
	'$2HD821lksow031JSN274nalwH71Nshskd1',  
	2
);
INSERT INTO participante(CPF, nome, data_nascimento, email, senha, id_instituicao) VALUES (
	'565.204.023-12', 
	'Mário Santos Bernardes da Silva', 
	'18/10/1980',
	'msbernardes@outlook.com',
	'$2f74H23al228Nsha02lj2Hn1p19Nsjaj',  
	3
);

-- Avaliador de eventos
INSERT INTO avaliador_evento(CPF, qt_eventos_aprovados, qt_eventos_recusados) VALUES ('012.652.102-96', 0, 0); 
INSERT INTO avaliador_evento(CPF, qt_eventos_aprovados, qt_eventos_recusados) VALUES ('901.625.987-01', 0, 0);

-- Avaliador de artigos
INSERT INTO avaliador_artigo(CPF, qt_artigos_aprovados, qt_artigos_recusados) VALUES ('180.955.366-00', 0, 0);
INSERT INTO avaliador_artigo(CPF, qt_artigos_aprovados, qt_artigos_recusados) VALUES ('901.625.987-01', 0, 0);

-- Palestrante 
INSERT INTO palestrante(CPF) VALUES ('180.955.366-00');
INSERT INTO palestrante(CPF) VALUES ('130.925.698-01');
INSERT INTO palestrante(CPF) VALUES ('565.204.023-12');

-- Autor
INSERT INTO autor(CPF) VALUES ('565.204.023-12');
INSERT INTO autor(CPF) VALUES ('130.925.698-01');
INSERT INTO autor(CPF) VALUES ('180.955.366-00');

-- Responsável
INSERT INTO responsavel(CPF) VALUES ('130.925.698-01');

-- Administrador
INSERT INTO administrador(CPF) VALUES ('191.011.112-11');

-- Área do conhecimento
INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	1,
	'Ciências Exatas',
	NULL
);
INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	2,
	'Ciências Sociais',
	NULL
);
INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	3,
	'Psicologia',
	NULL
);
INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	4,
	'Engenharia',
	NULL
);

INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	5,
	'Medicina',
	NULL
);

INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	6,
	'Inteligência Artificial',
	1
);

INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	7,
	'Banco de Dados',
	1
);

INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	8,
	'Engenharia Elétrica',
	4
);

INSERT INTO area_conhecimento(id, nome, id_area_pai) VALUES (
	9,
	'Cardiologia',
	5
);

-- Artigo
INSERT INTO artigo(id, titulo, resumo, arquivo, status, CPF_avaliador, motivo_avaliacao) VALUES (
	1,
	'Métodos de Otimização em Banco de Dados utilizando técnicas de Inteligência Artificial',
	'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
	'metodos_otimizacao_banco_dados.pdf',
	'Aprovado',
	'180.955.366-00',
	NULL
);
INSERT INTO artigo(id, titulo, resumo, arquivo, status, CPF_avaliador, motivo_avaliacao) VALUES (
	2,
	'Abordagens de baixo risco para tratamento de edemas pulmonares',
	'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.',
	'abordagens_baixo_risco_edemas_pulmonares.pdf',
	'Aprovado',
	'180.955.366-00',
	NULL
);


INSERT INTO artigo(id, titulo, resumo, arquivo, status, CPF_avaliador, motivo_avaliacao) VALUES (
	3,
	'O papel da Inteligência Artificial na medicina',
	'Quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum.',
	'inteligencia_artificial_medicina.pdf',
	'Recusado',
	'901.625.987-01',
	'Resumo contém erros ortográficos.'
);
INSERT INTO artigo(id, titulo, resumo, arquivo, status, CPF_avaliador, motivo_avaliacao) VALUES (
	4,
	'Sistema de Iluminação com Energia Fotovoltaica: Montagem de Protótipo',
	'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
	'iluminacao_com_energia_fotovoltaica',
	'Aguardando Aprovação',
	'901.625.987-01',
	NULL
);

-- Artigo e suas áreas do conhecimento
INSERT INTO artigo_areas_conhecimento(id_artigo, id_area_conhecimento) VALUES (1, 6);
INSERT INTO artigo_areas_conhecimento(id_artigo, id_area_conhecimento) VALUES (1, 7);
INSERT INTO artigo_areas_conhecimento(id_artigo, id_area_conhecimento) VALUES (2, 9);
INSERT INTO artigo_areas_conhecimento(id_artigo, id_area_conhecimento) VALUES (3, 5);
INSERT INTO artigo_areas_conhecimento(id_artigo, id_area_conhecimento) VALUES (3, 6);
INSERT INTO artigo_areas_conhecimento(id_artigo, id_area_conhecimento) VALUES (4, 8);

-- Estrelas dos participantes em artigos
INSERT INTO participante_estrelas_artigo(CPF_participante, id_artigo, qt_estrelas) VALUES ('012.652.102-96', 1, 5);
INSERT INTO participante_estrelas_artigo(CPF_participante, id_artigo, qt_estrelas) VALUES ('012.652.102-96', 2, 3);
INSERT INTO participante_estrelas_artigo(CPF_participante, id_artigo, qt_estrelas) VALUES ('306.984.654-00', 1, 5);
INSERT INTO participante_estrelas_artigo(CPF_participante, id_artigo, qt_estrelas) VALUES ('565.204.023-12', 1, 4);
INSERT INTO participante_estrelas_artigo(CPF_participante, id_artigo, qt_estrelas) VALUES ('950.318.102-21', 2, 5);

-- Publicação
INSERT INTO publicacao(CPF_autor, id_artigo, data_publicacao) VALUES ('130.925.698-01', 1, '03/06/2018 10:40:21');
INSERT INTO publicacao(CPF_autor, id_artigo, data_publicacao) VALUES ('180.955.366-00', 1, '03/06/2018 10:40:21');  
INSERT INTO publicacao(CPF_autor, id_artigo, data_publicacao) VALUES ('565.204.023-12', 2, '05/01/2018 15:22:02');
INSERT INTO publicacao(CPF_autor, id_artigo, data_publicacao) VALUES ('130.925.698-01', 3, '05/06/2018 09:13:35');
INSERT INTO publicacao(CPF_autor, id_artigo, data_publicacao) VALUES ('180.955.366-00', 4, '19/04/2018 00:01:56');

-- Organização
INSERT INTO organizacao(CNPJ, nome, imagem, telefone, descricao) VALUES (
	'36.234.450/0001-13', 
	'Divulgar', 
	'divulgar_logo.png', 
	'(32) 3219-6905', 
	'Uma organização sem fins lucrativos para divulgação da ciência.'
);
INSERT INTO organizacao(CNPJ, nome, imagem, telefone, descricao) VALUES (
	'95.102.013/0001-05', 
	'Ciência para todos', 
	'ciencia_para_todos_logo.png', 
	'(32) 3291-5005', 
	'Promovendo eventos científicos para toda a sociedade a mais de 20 anos.'
);

-- Eventos
INSERT INTO evento(id, nome, tipo, data_realizacao, horario_comeco, horario_termino, pais, estado, cidade, logradouro, bairro, CEP, numero, complemento, data_maxima_inscricao, descricao, valor, numero_maximo_participantes, CPF_avaliador, motivo_avaliacao, id_instituicao, id_artigo, CNPJ_organizacao, CPF_responsavel, data_criacao) VALUES (
	1, 
	'1º Simpósio de Inteligência Artificial de Minas Gerais', 
	'Simpósio', 
	'17/11/2018', 
	'18:00',
	'22:00',
	'Brasil',
	'Minas Gerais',
	'Juiz de Fora',
	'Rua Bernardo Mascarenhas',
	'Fábrica',
	'36080-001',
	'1283',
	NULL,
	'15/11/2018 23:59:59',
	'O evento apresentará as principais técnicas desenvolvidas nos últimos dez anos e como o Brasil pode se tornar protagonista nesta área na próxima década.',
	'199.99',
	'150',
	'901.625.987-01',
	NULL,
	NULL,
	NULL,
	'95.102.013/0001-05',
	'130.925.698-01',
	'17/10/18 10:35:22'
);
INSERT INTO evento(id, nome, tipo, data_realizacao, horario_comeco, horario_termino, pais, estado, cidade, logradouro, bairro, CEP, numero, complemento, data_maxima_inscricao, descricao, valor, numero_maximo_participantes, CPF_avaliador, motivo_avaliacao, id_instituicao, id_artigo, CNPJ_organizacao, CPF_responsavel, data_criacao) VALUES (
	2, 
	'73º Congresso de Cardiologia', 
	'Congresso', 
	'03/12/2018', 
	'10:00',
	'18:00',
	'Brasil',
	'Distrito Federal',
	'Brasília',
	'CICB - Centro Internacional de Convenções do Brasil',
	'Asa Sul',
	'70200-002',
	'63',
	'SCES Trecho 2, Conjunto 63, Lote 50',
	'30/11/2018 23:59:59',
	'Congresso de Cardiologia debaterá o despreparo de profissionais em hospitais para atender uma parada cardíaca',
	'399.99',
	'650',
	'901.625.987-01',
	NULL,
	NULL,
	NULL,
	'95.102.013/0001-05',
	'565.204.023-12',
	'11/10/18 20:29:38'
);

-- Forma de pagamento
INSERT INTO forma_pagamento(id, nome) VALUES (1, 'Boleto bancário');
INSERT INTO forma_pagamento(id, nome) VALUES (2, 'Cartão de crédito');
INSERT INTO forma_pagamento(id, nome) VALUES (3, 'PayPal');
INSERT INTO forma_pagamento(id, nome) VALUES (4, 'Transferência');

-- Formas de pagamento dos eventos

INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (1, 1);
INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (1, 2);
INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (1, 3);
INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (1, 4);
INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (2, 1);
INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (2, 2);
INSERT INTO evento_formas_pagamento(id_evento, id_forma_pagamento) VALUES (2, 3);

-- Áreas de conhecimento dos eventos

INSERT INTO evento_areas_conhecimento(id_evento, id_area_conhecimento) VALUES (1, 6);
INSERT INTO evento_areas_conhecimento(id_evento, id_area_conhecimento) VALUES (2, 9);

-- Inscrição
INSERT INTO inscricao(CPF_participante, id_evento, id_forma_pagamento, codigo, data_inscricao, status) VALUES (
	'033.181.019-71',
	1,
	2,
	'0169843598144',
	'17/10/18 17:55:02',
	'Aprovado'
);

INSERT INTO inscricao(CPF_participante, id_evento, id_forma_pagamento, codigo, data_inscricao, status) VALUES (
	'191.011.112-11',
	1,
	1,
	'012654601',
	'17/10/18 17:49:05',
	'Aguardando Pagamento'
);

INSERT INTO inscricao(CPF_participante, id_evento, id_forma_pagamento, codigo, data_inscricao, status) VALUES (
	'653.101.962-33',
	2,
	3,
	'3946665640',
	'17/10/18 15:12:10',
	'Aguardando Pagamento'
);

INSERT INTO inscricao(CPF_participante, id_evento, id_forma_pagamento, codigo, data_inscricao, status) VALUES (
	'101.999.333-51',
	2,
	2,
	'4544501',
	'17/10/18 15:12:10',
	'Aprovado'
);

-- Ingresso
INSERT INTO ingresso(codigo, CPF_participante, id_evento) VALUES (
	'1127312829',
	'101.999.333-51',
	2
); 

INSERT INTO ingresso(codigo, CPF_participante, id_evento) VALUES (
	'16550529',
	'033.181.019-71',
	1
);

-- Eventos ministrados pelos palestrantes
INSERT INTO palestrante_ministra_evento(id_evento, CPF_palestrante) VALUES (
	1,
	'180.955.366-00'
);

INSERT INTO palestrante_ministra_evento(id_evento, CPF_palestrante) VALUES (
	2,
	'565.204.023-12'
);
