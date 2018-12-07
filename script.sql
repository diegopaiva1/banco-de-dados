-- Consulta 1: Listar todas as inscrições realizadas em um evento “X”: código da inscrição, nome do participante,
-- CPF e data de inscrição

SELECT (codigo, nome, cpf, data_inscricao) 
FROM ( (SELECT * FROM inscricao WHERE id_evento = 1) ) AS inscritos
JOIN participante
ON inscritos.cpf_participante = participante.cpf;

-- Consulta 2: Listar todos os eventos que ainda irão acontecer: nome, tipo, data de realização, país, estado e cidade

SELECT (nome, tipo, data_realizacao, pais, estado, cidade)
FROM evento
WHERE data_realizacao > NOW();

-- Consulta 3: Listar todos os eventos que já ocorreram (encerrados): nome, tipo, data de realização, país, estado e cidade

SELECT (nome, tipo, data_realizacao, pais, estado, cidade)
FROM evento
WHERE data_realizacao < NOW();

-- Consulta 4: Listar todos os eventos que ocorreram e irão ocorrer em instituições de ensino: nome da instituição, sigla,
-- nome do evento, tipo e data de realização

SELECT (instituicao.nome, instituicao.sigla, evento.nome, evento.tipo, evento.data_realizacao)
FROM (SELECT * FROM evento WHERE id_instituicao IS NOT NULL) AS evento
JOIN instituicao
ON evento.id_instituicao = instituicao.id;

-- Consulta 6: Listar todos os artigos publicados nos últimos 30 dias

SELECT * 
FROM (SELECT * FROM publicacao WHERE data_publicacao >= current_date - 30) AS publicacao
JOIN artigo
ON publicacao.id_artigo = artigo.id;

-- Consulta 7: Quais eventos aceitam todas as formas de pagamento?

SELECT evento.nome
FROM evento_formas_pagamento
JOIN evento
ON evento_formas_pagamento.id_evento = evento.id
JOIN forma_pagamento
ON id_forma_pagamento = forma_pagamento.id

GROUP BY evento.nome
HAVING COUNT (forma_pagamento.nome) = (
      SELECT COUNT (*) FROM forma_pagamento
);

-- Consulta 8: Listar todos os eventos de Ciências Exatas

SELECT *
FROM (
	SELECT * 
	FROM evento_areas_conhecimento
	JOIN area_conhecimento 
	ON evento_areas_conhecimento.id_area_conhecimento = area_conhecimento.id 
	WHERE nome = 'Ciências Exatas'
) AS EventosCienciasExatas
JOIN evento
ON evento.id = EventosCienciasExatas.id_evento;

-- Consulta 9: Listar todos os seminários de Engenharia Elétrica

SELECT *
FROM (
	SELECT * 
	FROM (
		SELECT * 
		FROM area_conhecimento 
		WHERE nome = 'Cardiologia'
	) AS Area
	JOIN evento_areas_conhecimento
	ON evento_areas_conhecimento.id_area_conhecimento = Area.id
) AS Eventos
JOIN evento
ON Eventos.id_evento = evento.id
WHERE tipo = 'Seminário';

-- Consulta 11: Quais os nomes dos palestrantes que já ministraram eventos organizados pela organização "Ciência para todos"?

SELECT nome
FROM (
	SELECT *
	FROM (
		SELECT id
		FROM (
			SELECT * FROM organizacao WHERE nome = 'Ciência para todos'
		) AS Organizacao
		JOIN evento
		ON Organizacao.cnpj = evento.cnpj_organizacao
	) AS EventosOrganizados
	JOIN palestrante_ministra_evento
	ON EventosOrganizados.id = palestrante_ministra_evento.id_evento
) AS Palestrantes
JOIN participante
ON Palestrantes.cpf_palestrante = participante.cpf;

-- Consulta 12: Listar todos os eventos organizados pela organização de CNPJ “95.102.013/0001-05”

SELECT * FROM evento WHERE cnpj_organizacao = '95.102.013/0001-05';

-- Consulta 13: Quais eventos foram criados nos ultimos 5 dias?

SELECT * FROM evento WHERE data_criacao >= current_date - 5;

-- Consulta 14: Listar todos os eventos que foram recusados e o motivo pelo qual cada um deles foi recusado

SELECT (nome, motivo_avaliacao) FROM evento WHERE motivo_avaliacao IS NOT NULL;

-- Consulta 15: Listar todos os artigos que foram recusados e o motivo pelo qual cada um deles foi recusado

SELECT (titulo, motivo_avaliacao) FROM artigo WHERE motivo_avaliacao IS NOT NULL;

-- Consulta 16: Listar as áreas do conhecimento que não estão presentes em nenhum evento

(SELECT nome FROM area_conhecimento) EXCEPT
(SELECT area_conhecimento.nome
FROM evento_areas_conhecimento
JOIN area_conhecimento 
ON area_conhecimento.id = evento_areas_conhecimento.id_area_conhecimento
JOIN evento
ON evento.id = id_evento);

-- Consulta 17: Listar todos os artigos que envolvem as áreas de Banco de Dados e Inteligência Artificial (simultaneamente)

SELECT *
FROM (
	SELECT id_artigo FROM artigo_areas_conhecimento
	WHERE id_area_conhecimento = (SELECT id FROM area_conhecimento WHERE nome = 'Banco de Dados')
) AS Artigos
JOIN artigo
ON id_artigo = artigo.id

INTERSECT

SELECT * 
FROM (
	SELECT id_artigo FROM artigo_areas_conhecimento
	WHERE id_area_conhecimento = (SELECT id FROM area_conhecimento WHERE nome = 'Inteligência Artificial')
) AS Artigos
JOIN artigo
ON id_artigo = artigo.id;

-- Consulta 18: Qual o estado e cidade dos eventos que serão realizados na área de Ciências Sociais?

SELECT (estado, cidade)
FROM (
	SELECT * 
	FROM evento_areas_conhecimento
	JOIN area_conhecimento
	ON evento_areas_conhecimento.id_area_conhecimento = area_conhecimento.id
	WHERE nome = 'Cardiologia'
) AS Eventos
JOIN evento
ON Eventos.id_evento = evento.id
WHERE data_realizacao > NOW();

-- Consulta 10: Listar todos os artigos publicados que são de Ciências Exatas ou Engenharia

SELECT (titulo, resumo, nome)
FROM (
	SELECT * FROM artigo_areas_conhecimento 
	JOIN area_conhecimento 
	ON artigo_areas_conhecimento.id_area_conhecimento = area_conhecimento.id
	WHERE nome = 'Inteligência Artificial'

	UNION

	SELECT * FROM artigo_areas_conhecimento 
	JOIN area_conhecimento 
	ON artigo_areas_conhecimento.id_area_conhecimento = area_conhecimento.id
	WHERE nome = 'Banco de Dados'
) AS Artigos
JOIN artigo
ON Artigos.id_artigo = artigo.id