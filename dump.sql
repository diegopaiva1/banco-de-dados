--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0 (Ubuntu 11.0-1.pgdg16.04+2)
-- Dumped by pg_dump version 11.0 (Ubuntu 11.0-1.pgdg16.04+2)

-- Started on 2018-10-31 12:23:42 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16423)
-- Name: saec; Type: SCHEMA; Schema: -; Owner: diego
--

CREATE SCHEMA saec;


ALTER SCHEMA saec OWNER TO diego;

--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA saec; Type: COMMENT; Schema: -; Owner: diego
--

COMMENT ON SCHEMA saec IS 'Sistema de apoio à eventos científicos';


--
-- TOC entry 646 (class 1247 OID 16550)
-- Name: status; Type: TYPE; Schema: saec; Owner: diego
--

CREATE TYPE saec.status AS ENUM (
    'Aguardando Aprovação',
    'Aprovado',
    'Recusado'
);


ALTER TYPE saec.status OWNER TO diego;

--
-- TOC entry 685 (class 1247 OID 16825)
-- Name: status_pagamento; Type: TYPE; Schema: saec; Owner: diego
--

CREATE TYPE saec.status_pagamento AS ENUM (
    'Aguardando Pagamento',
    'Aprovado',
    'Recusado'
);


ALTER TYPE saec.status_pagamento OWNER TO diego;

--
-- TOC entry 667 (class 1247 OID 16727)
-- Name: tipo; Type: TYPE; Schema: saec; Owner: diego
--

CREATE TYPE saec.tipo AS ENUM (
    'Congresso',
    'Conferência',
    'Curso',
    'Encontro',
    'Fórum',
    'Jornada',
    'Mesa-redonda',
    'Seminário',
    'Simpósio',
    'Workshop'
);


ALTER TYPE saec.tipo OWNER TO diego;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 204 (class 1259 OID 16493)
-- Name: administrador; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.administrador (
    cpf character varying(15) NOT NULL
);


ALTER TABLE saec.administrador OWNER TO diego;

--
-- TOC entry 206 (class 1259 OID 16505)
-- Name: area_conhecimento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.area_conhecimento (
    id integer NOT NULL,
    nome character varying(50) NOT NULL,
    id_area_pai integer
);


ALTER TABLE saec.area_conhecimento OWNER TO diego;

--
-- TOC entry 205 (class 1259 OID 16503)
-- Name: area_conhecimento_id_seq; Type: SEQUENCE; Schema: saec; Owner: diego
--

CREATE SEQUENCE saec.area_conhecimento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE saec.area_conhecimento_id_seq OWNER TO diego;

--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 205
-- Name: area_conhecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: saec; Owner: diego
--

ALTER SEQUENCE saec.area_conhecimento_id_seq OWNED BY saec.area_conhecimento.id;


--
-- TOC entry 209 (class 1259 OID 16559)
-- Name: artigo; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.artigo (
    id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    resumo text NOT NULL,
    arquivo character varying(255) NOT NULL,
    status saec.status DEFAULT 'Aguardando Aprovação'::saec.status NOT NULL,
    cpf_avaliador character varying(15),
    motivo_avaliacao text
);


ALTER TABLE saec.artigo OWNER TO diego;

--
-- TOC entry 210 (class 1259 OID 16574)
-- Name: artigo_areas_conhecimento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.artigo_areas_conhecimento (
    id_artigo integer NOT NULL,
    id_area_conhecimento integer NOT NULL
);


ALTER TABLE saec.artigo_areas_conhecimento OWNER TO diego;

--
-- TOC entry 208 (class 1259 OID 16557)
-- Name: artigo_id_seq; Type: SEQUENCE; Schema: saec; Owner: diego
--

CREATE SEQUENCE saec.artigo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE saec.artigo_id_seq OWNER TO diego;

--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 208
-- Name: artigo_id_seq; Type: SEQUENCE OWNED BY; Schema: saec; Owner: diego
--

ALTER SEQUENCE saec.artigo_id_seq OWNED BY saec.artigo.id;


--
-- TOC entry 202 (class 1259 OID 16473)
-- Name: autor; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.autor (
    cpf character varying(15) NOT NULL
);


ALTER TABLE saec.autor OWNER TO diego;

--
-- TOC entry 207 (class 1259 OID 16537)
-- Name: avaliador_artigo; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.avaliador_artigo (
    cpf character varying(15) NOT NULL,
    qt_artigos_aprovados integer DEFAULT 0 NOT NULL,
    qt_artigos_recusados integer DEFAULT 0 NOT NULL
);


ALTER TABLE saec.avaliador_artigo OWNER TO diego;

--
-- TOC entry 200 (class 1259 OID 16451)
-- Name: avaliador_evento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.avaliador_evento (
    cpf character varying(15) NOT NULL,
    qt_eventos_aprovados integer DEFAULT 0 NOT NULL,
    qt_eventos_recusados integer DEFAULT 0 NOT NULL
);


ALTER TABLE saec.avaliador_evento OWNER TO diego;

--
-- TOC entry 223 (class 1259 OID 16886)
-- Name: certificado; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.certificado (
    cpf_participante character varying(15) NOT NULL,
    id_evento integer NOT NULL,
    codigo character varying(255) NOT NULL,
    carga_horaria_total time without time zone NOT NULL
);


ALTER TABLE saec.certificado OWNER TO diego;

--
-- TOC entry 215 (class 1259 OID 16749)
-- Name: evento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.evento (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    tipo saec.tipo NOT NULL,
    data_realizacao timestamp without time zone NOT NULL,
    horario_comeco time without time zone NOT NULL,
    horario_termino time without time zone NOT NULL,
    pais character varying(191) NOT NULL,
    estado character varying(191) NOT NULL,
    cidade character varying(191) NOT NULL,
    logradouro character varying(191) NOT NULL,
    bairro character varying(191) NOT NULL,
    cep character varying(50) NOT NULL,
    numero character varying(10) NOT NULL,
    complemento character varying(191),
    data_maxima_inscricao timestamp without time zone NOT NULL,
    descricao text NOT NULL,
    valor numeric(11,2) NOT NULL,
    numero_maximo_participantes integer NOT NULL,
    cpf_avaliador character varying(15),
    motivo_avaliacao text,
    id_instituicao integer,
    id_artigo integer,
    cnpj_organizacao character varying(20) NOT NULL,
    cpf_responsavel character varying(15) NOT NULL,
    data_criacao timestamp without time zone NOT NULL
);


ALTER TABLE saec.evento OWNER TO diego;

--
-- TOC entry 219 (class 1259 OID 16808)
-- Name: evento_areas_conhecimento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.evento_areas_conhecimento (
    id_evento integer NOT NULL,
    id_area_conhecimento integer NOT NULL
);


ALTER TABLE saec.evento_areas_conhecimento OWNER TO diego;

--
-- TOC entry 218 (class 1259 OID 16793)
-- Name: evento_formas_pagamento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.evento_formas_pagamento (
    id_evento integer NOT NULL,
    id_forma_pagamento integer NOT NULL
);


ALTER TABLE saec.evento_formas_pagamento OWNER TO diego;

--
-- TOC entry 214 (class 1259 OID 16747)
-- Name: evento_id_seq; Type: SEQUENCE; Schema: saec; Owner: diego
--

CREATE SEQUENCE saec.evento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE saec.evento_id_seq OWNER TO diego;

--
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 214
-- Name: evento_id_seq; Type: SEQUENCE OWNED BY; Schema: saec; Owner: diego
--

ALTER SEQUENCE saec.evento_id_seq OWNED BY saec.evento.id;


--
-- TOC entry 217 (class 1259 OID 16785)
-- Name: forma_pagamento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.forma_pagamento (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE saec.forma_pagamento OWNER TO diego;

--
-- TOC entry 216 (class 1259 OID 16783)
-- Name: forma_pagamento_id_seq; Type: SEQUENCE; Schema: saec; Owner: diego
--

CREATE SEQUENCE saec.forma_pagamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE saec.forma_pagamento_id_seq OWNER TO diego;

--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 216
-- Name: forma_pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: saec; Owner: diego
--

ALTER SEQUENCE saec.forma_pagamento_id_seq OWNED BY saec.forma_pagamento.id;


--
-- TOC entry 221 (class 1259 OID 16854)
-- Name: ingresso; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.ingresso (
    codigo character varying(255) NOT NULL,
    cpf_participante character varying(15) NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE saec.ingresso OWNER TO diego;

--
-- TOC entry 220 (class 1259 OID 16831)
-- Name: inscricao; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.inscricao (
    cpf_participante character varying(15) NOT NULL,
    id_evento integer NOT NULL,
    id_forma_pagamento integer NOT NULL,
    codigo character varying(255) NOT NULL,
    data_inscricao timestamp without time zone NOT NULL,
    status saec.status_pagamento DEFAULT 'Aguardando Pagamento'::saec.status_pagamento NOT NULL
);


ALTER TABLE saec.inscricao OWNER TO diego;

--
-- TOC entry 198 (class 1259 OID 16426)
-- Name: instituicao; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.instituicao (
    id integer NOT NULL,
    sigla character varying(10) NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE saec.instituicao OWNER TO diego;

--
-- TOC entry 197 (class 1259 OID 16424)
-- Name: instituicao_id_seq; Type: SEQUENCE; Schema: saec; Owner: diego
--

CREATE SEQUENCE saec.instituicao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE saec.instituicao_id_seq OWNER TO diego;

--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 197
-- Name: instituicao_id_seq; Type: SEQUENCE OWNED BY; Schema: saec; Owner: diego
--

ALTER SEQUENCE saec.instituicao_id_seq OWNED BY saec.instituicao.id;


--
-- TOC entry 213 (class 1259 OID 16619)
-- Name: organizacao; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.organizacao (
    cnpj character varying(20) NOT NULL,
    nome character varying(100) NOT NULL,
    imagem character varying(255) NOT NULL,
    telefone character varying(50) NOT NULL,
    descricao text
);


ALTER TABLE saec.organizacao OWNER TO diego;

--
-- TOC entry 201 (class 1259 OID 16463)
-- Name: palestrante; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.palestrante (
    cpf character varying(15) NOT NULL
);


ALTER TABLE saec.palestrante OWNER TO diego;

--
-- TOC entry 222 (class 1259 OID 16871)
-- Name: palestrante_ministra_evento; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.palestrante_ministra_evento (
    id_evento integer NOT NULL,
    cpf_palestrante character varying(15) NOT NULL
);


ALTER TABLE saec.palestrante_ministra_evento OWNER TO diego;

--
-- TOC entry 199 (class 1259 OID 16436)
-- Name: participante; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.participante (
    cpf character varying(15) NOT NULL,
    nome character varying(100) NOT NULL,
    data_nascimento date NOT NULL,
    email character varying(50) NOT NULL,
    senha character varying(500) NOT NULL,
    id_instituicao integer
);


ALTER TABLE saec.participante OWNER TO diego;

--
-- TOC entry 211 (class 1259 OID 16589)
-- Name: participante_estrelas_artigo; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.participante_estrelas_artigo (
    cpf_participante character varying(15) NOT NULL,
    id_artigo integer NOT NULL,
    qt_estrelas integer NOT NULL
);


ALTER TABLE saec.participante_estrelas_artigo OWNER TO diego;

--
-- TOC entry 212 (class 1259 OID 16604)
-- Name: publicacao; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.publicacao (
    cpf_autor character varying(15) NOT NULL,
    id_artigo integer NOT NULL,
    data_publicacao timestamp without time zone NOT NULL
);


ALTER TABLE saec.publicacao OWNER TO diego;

--
-- TOC entry 203 (class 1259 OID 16483)
-- Name: responsavel; Type: TABLE; Schema: saec; Owner: diego
--

CREATE TABLE saec.responsavel (
    cpf character varying(15) NOT NULL
);


ALTER TABLE saec.responsavel OWNER TO diego;

--
-- TOC entry 2871 (class 2604 OID 16508)
-- Name: area_conhecimento id; Type: DEFAULT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.area_conhecimento ALTER COLUMN id SET DEFAULT nextval('saec.area_conhecimento_id_seq'::regclass);


--
-- TOC entry 2874 (class 2604 OID 16562)
-- Name: artigo id; Type: DEFAULT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.artigo ALTER COLUMN id SET DEFAULT nextval('saec.artigo_id_seq'::regclass);


--
-- TOC entry 2876 (class 2604 OID 16752)
-- Name: evento id; Type: DEFAULT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento ALTER COLUMN id SET DEFAULT nextval('saec.evento_id_seq'::regclass);


--
-- TOC entry 2877 (class 2604 OID 16788)
-- Name: forma_pagamento id; Type: DEFAULT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.forma_pagamento ALTER COLUMN id SET DEFAULT nextval('saec.forma_pagamento_id_seq'::regclass);


--
-- TOC entry 2868 (class 2604 OID 16429)
-- Name: instituicao id; Type: DEFAULT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.instituicao ALTER COLUMN id SET DEFAULT nextval('saec.instituicao_id_seq'::regclass);


--
-- TOC entry 2898 (class 2606 OID 16497)
-- Name: administrador administrador_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.administrador
    ADD CONSTRAINT administrador_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2900 (class 2606 OID 16512)
-- Name: area_conhecimento area_conhecimento_nome_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.area_conhecimento
    ADD CONSTRAINT area_conhecimento_nome_key UNIQUE (nome);


--
-- TOC entry 2902 (class 2606 OID 16510)
-- Name: area_conhecimento area_conhecimento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.area_conhecimento
    ADD CONSTRAINT area_conhecimento_pkey PRIMARY KEY (id);


--
-- TOC entry 2908 (class 2606 OID 16578)
-- Name: artigo_areas_conhecimento artigo_areas_conhecimento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.artigo_areas_conhecimento
    ADD CONSTRAINT artigo_areas_conhecimento_pkey PRIMARY KEY (id_artigo, id_area_conhecimento);


--
-- TOC entry 2906 (class 2606 OID 16568)
-- Name: artigo artigo_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.artigo
    ADD CONSTRAINT artigo_pkey PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 16477)
-- Name: autor autor_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2904 (class 2606 OID 16543)
-- Name: avaliador_artigo avaliador_artigo_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.avaliador_artigo
    ADD CONSTRAINT avaliador_artigo_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2890 (class 2606 OID 16457)
-- Name: avaliador_evento avaliador_evento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.avaliador_evento
    ADD CONSTRAINT avaliador_evento_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2938 (class 2606 OID 16892)
-- Name: certificado certificado_codigo_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.certificado
    ADD CONSTRAINT certificado_codigo_key UNIQUE (codigo);


--
-- TOC entry 2940 (class 2606 OID 16890)
-- Name: certificado certificado_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.certificado
    ADD CONSTRAINT certificado_pkey PRIMARY KEY (cpf_participante, id_evento);


--
-- TOC entry 2926 (class 2606 OID 16812)
-- Name: evento_areas_conhecimento evento_areas_conhecimento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento_areas_conhecimento
    ADD CONSTRAINT evento_areas_conhecimento_pkey PRIMARY KEY (id_evento, id_area_conhecimento);


--
-- TOC entry 2924 (class 2606 OID 16797)
-- Name: evento_formas_pagamento evento_formas_pagamento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento_formas_pagamento
    ADD CONSTRAINT evento_formas_pagamento_pkey PRIMARY KEY (id_evento, id_forma_pagamento);


--
-- TOC entry 2918 (class 2606 OID 16757)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id);


--
-- TOC entry 2920 (class 2606 OID 16792)
-- Name: forma_pagamento forma_pagamento_nome_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.forma_pagamento
    ADD CONSTRAINT forma_pagamento_nome_key UNIQUE (nome);


--
-- TOC entry 2922 (class 2606 OID 16790)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2932 (class 2606 OID 16860)
-- Name: ingresso ingresso_codigo_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.ingresso
    ADD CONSTRAINT ingresso_codigo_key UNIQUE (codigo);


--
-- TOC entry 2934 (class 2606 OID 16858)
-- Name: ingresso ingresso_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.ingresso
    ADD CONSTRAINT ingresso_pkey PRIMARY KEY (codigo, cpf_participante, id_evento);


--
-- TOC entry 2928 (class 2606 OID 16838)
-- Name: inscricao inscricao_codigo_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.inscricao
    ADD CONSTRAINT inscricao_codigo_key UNIQUE (codigo);


--
-- TOC entry 2930 (class 2606 OID 16836)
-- Name: inscricao inscricao_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.inscricao
    ADD CONSTRAINT inscricao_pkey PRIMARY KEY (cpf_participante, id_evento);


--
-- TOC entry 2880 (class 2606 OID 16435)
-- Name: instituicao instituicao_nome_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.instituicao
    ADD CONSTRAINT instituicao_nome_key UNIQUE (nome);


--
-- TOC entry 2882 (class 2606 OID 16431)
-- Name: instituicao instituicao_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 16433)
-- Name: instituicao instituicao_sigla_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.instituicao
    ADD CONSTRAINT instituicao_sigla_key UNIQUE (sigla);


--
-- TOC entry 2914 (class 2606 OID 16628)
-- Name: organizacao organizacao_nome_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.organizacao
    ADD CONSTRAINT organizacao_nome_key UNIQUE (nome);


--
-- TOC entry 2916 (class 2606 OID 16626)
-- Name: organizacao organizacao_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.organizacao
    ADD CONSTRAINT organizacao_pkey PRIMARY KEY (cnpj);


--
-- TOC entry 2936 (class 2606 OID 16875)
-- Name: palestrante_ministra_evento palestrante_ministra_evento_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.palestrante_ministra_evento
    ADD CONSTRAINT palestrante_ministra_evento_pkey PRIMARY KEY (id_evento, cpf_palestrante);


--
-- TOC entry 2892 (class 2606 OID 16467)
-- Name: palestrante palestrante_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.palestrante
    ADD CONSTRAINT palestrante_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2886 (class 2606 OID 16445)
-- Name: participante participante_email_key; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.participante
    ADD CONSTRAINT participante_email_key UNIQUE (email);


--
-- TOC entry 2910 (class 2606 OID 16593)
-- Name: participante_estrelas_artigo participante_estrelas_artigo_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.participante_estrelas_artigo
    ADD CONSTRAINT participante_estrelas_artigo_pkey PRIMARY KEY (cpf_participante, id_artigo);


--
-- TOC entry 2888 (class 2606 OID 16443)
-- Name: participante participante_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.participante
    ADD CONSTRAINT participante_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2912 (class 2606 OID 16608)
-- Name: publicacao publicacao_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.publicacao
    ADD CONSTRAINT publicacao_pkey PRIMARY KEY (cpf_autor, id_artigo);


--
-- TOC entry 2896 (class 2606 OID 16487)
-- Name: responsavel responsavel_pkey; Type: CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.responsavel
    ADD CONSTRAINT responsavel_pkey PRIMARY KEY (cpf);


--
-- TOC entry 2946 (class 2606 OID 16498)
-- Name: administrador administrador_cpf_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.administrador
    ADD CONSTRAINT administrador_cpf_fkey FOREIGN KEY (cpf) REFERENCES saec.participante(cpf);


--
-- TOC entry 2947 (class 2606 OID 16513)
-- Name: area_conhecimento area_conhecimento_id_area_pai_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.area_conhecimento
    ADD CONSTRAINT area_conhecimento_id_area_pai_fkey FOREIGN KEY (id_area_pai) REFERENCES saec.area_conhecimento(id);


--
-- TOC entry 2951 (class 2606 OID 16584)
-- Name: artigo_areas_conhecimento artigo_areas_conhecimento_id_area_conhecimento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.artigo_areas_conhecimento
    ADD CONSTRAINT artigo_areas_conhecimento_id_area_conhecimento_fkey FOREIGN KEY (id_area_conhecimento) REFERENCES saec.area_conhecimento(id);


--
-- TOC entry 2950 (class 2606 OID 16579)
-- Name: artigo_areas_conhecimento artigo_areas_conhecimento_id_artigo_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.artigo_areas_conhecimento
    ADD CONSTRAINT artigo_areas_conhecimento_id_artigo_fkey FOREIGN KEY (id_artigo) REFERENCES saec.artigo(id);


--
-- TOC entry 2949 (class 2606 OID 16569)
-- Name: artigo artigo_cpf_avaliador_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.artigo
    ADD CONSTRAINT artigo_cpf_avaliador_fkey FOREIGN KEY (cpf_avaliador) REFERENCES saec.avaliador_artigo(cpf);


--
-- TOC entry 2944 (class 2606 OID 16478)
-- Name: autor autor_cpf_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.autor
    ADD CONSTRAINT autor_cpf_fkey FOREIGN KEY (cpf) REFERENCES saec.participante(cpf);


--
-- TOC entry 2948 (class 2606 OID 16544)
-- Name: avaliador_artigo avaliador_artigo_cpf_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.avaliador_artigo
    ADD CONSTRAINT avaliador_artigo_cpf_fkey FOREIGN KEY (cpf) REFERENCES saec.participante(cpf);


--
-- TOC entry 2942 (class 2606 OID 16458)
-- Name: avaliador_evento avaliador_evento_cpf_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.avaliador_evento
    ADD CONSTRAINT avaliador_evento_cpf_fkey FOREIGN KEY (cpf) REFERENCES saec.participante(cpf);


--
-- TOC entry 2972 (class 2606 OID 16893)
-- Name: certificado certificado_cpf_participante_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.certificado
    ADD CONSTRAINT certificado_cpf_participante_fkey FOREIGN KEY (cpf_participante) REFERENCES saec.participante(cpf);


--
-- TOC entry 2973 (class 2606 OID 16898)
-- Name: certificado certificado_id_evento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.certificado
    ADD CONSTRAINT certificado_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES saec.evento(id);


--
-- TOC entry 2964 (class 2606 OID 16818)
-- Name: evento_areas_conhecimento evento_areas_conhecimento_id_area_conhecimento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento_areas_conhecimento
    ADD CONSTRAINT evento_areas_conhecimento_id_area_conhecimento_fkey FOREIGN KEY (id_area_conhecimento) REFERENCES saec.area_conhecimento(id);


--
-- TOC entry 2963 (class 2606 OID 16813)
-- Name: evento_areas_conhecimento evento_areas_conhecimento_id_evento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento_areas_conhecimento
    ADD CONSTRAINT evento_areas_conhecimento_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES saec.evento(id);


--
-- TOC entry 2959 (class 2606 OID 16773)
-- Name: evento evento_cnpj_organizacao_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento
    ADD CONSTRAINT evento_cnpj_organizacao_fkey FOREIGN KEY (cnpj_organizacao) REFERENCES saec.organizacao(cnpj);


--
-- TOC entry 2956 (class 2606 OID 16758)
-- Name: evento evento_cpf_avaliador_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento
    ADD CONSTRAINT evento_cpf_avaliador_fkey FOREIGN KEY (cpf_avaliador) REFERENCES saec.avaliador_evento(cpf);


--
-- TOC entry 2960 (class 2606 OID 16778)
-- Name: evento evento_cpf_responsavel_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento
    ADD CONSTRAINT evento_cpf_responsavel_fkey FOREIGN KEY (cpf_responsavel) REFERENCES saec.participante(cpf);


--
-- TOC entry 2961 (class 2606 OID 16798)
-- Name: evento_formas_pagamento evento_formas_pagamento_id_evento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento_formas_pagamento
    ADD CONSTRAINT evento_formas_pagamento_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES saec.evento(id);


--
-- TOC entry 2962 (class 2606 OID 16803)
-- Name: evento_formas_pagamento evento_formas_pagamento_id_forma_pagamento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento_formas_pagamento
    ADD CONSTRAINT evento_formas_pagamento_id_forma_pagamento_fkey FOREIGN KEY (id_forma_pagamento) REFERENCES saec.forma_pagamento(id);


--
-- TOC entry 2958 (class 2606 OID 16768)
-- Name: evento evento_id_artigo_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento
    ADD CONSTRAINT evento_id_artigo_fkey FOREIGN KEY (id_artigo) REFERENCES saec.artigo(id);


--
-- TOC entry 2957 (class 2606 OID 16763)
-- Name: evento evento_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.evento
    ADD CONSTRAINT evento_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES saec.instituicao(id);


--
-- TOC entry 2968 (class 2606 OID 16861)
-- Name: ingresso ingresso_cpf_participante_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.ingresso
    ADD CONSTRAINT ingresso_cpf_participante_fkey FOREIGN KEY (cpf_participante) REFERENCES saec.participante(cpf);


--
-- TOC entry 2969 (class 2606 OID 16866)
-- Name: ingresso ingresso_id_evento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.ingresso
    ADD CONSTRAINT ingresso_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES saec.evento(id);


--
-- TOC entry 2965 (class 2606 OID 16839)
-- Name: inscricao inscricao_cpf_participante_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.inscricao
    ADD CONSTRAINT inscricao_cpf_participante_fkey FOREIGN KEY (cpf_participante) REFERENCES saec.participante(cpf);


--
-- TOC entry 2966 (class 2606 OID 16844)
-- Name: inscricao inscricao_id_evento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.inscricao
    ADD CONSTRAINT inscricao_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES saec.evento(id);


--
-- TOC entry 2967 (class 2606 OID 16849)
-- Name: inscricao inscricao_id_forma_pagamento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.inscricao
    ADD CONSTRAINT inscricao_id_forma_pagamento_fkey FOREIGN KEY (id_forma_pagamento) REFERENCES saec.forma_pagamento(id);


--
-- TOC entry 2943 (class 2606 OID 16468)
-- Name: palestrante palestrante_cpf_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.palestrante
    ADD CONSTRAINT palestrante_cpf_fkey FOREIGN KEY (cpf) REFERENCES saec.participante(cpf);


--
-- TOC entry 2971 (class 2606 OID 16881)
-- Name: palestrante_ministra_evento palestrante_ministra_evento_cpf_palestrante_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.palestrante_ministra_evento
    ADD CONSTRAINT palestrante_ministra_evento_cpf_palestrante_fkey FOREIGN KEY (cpf_palestrante) REFERENCES saec.palestrante(cpf);


--
-- TOC entry 2970 (class 2606 OID 16876)
-- Name: palestrante_ministra_evento palestrante_ministra_evento_id_evento_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.palestrante_ministra_evento
    ADD CONSTRAINT palestrante_ministra_evento_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES saec.evento(id);


--
-- TOC entry 2952 (class 2606 OID 16594)
-- Name: participante_estrelas_artigo participante_estrelas_artigo_cpf_participante_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.participante_estrelas_artigo
    ADD CONSTRAINT participante_estrelas_artigo_cpf_participante_fkey FOREIGN KEY (cpf_participante) REFERENCES saec.participante(cpf);


--
-- TOC entry 2953 (class 2606 OID 16599)
-- Name: participante_estrelas_artigo participante_estrelas_artigo_id_artigo_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.participante_estrelas_artigo
    ADD CONSTRAINT participante_estrelas_artigo_id_artigo_fkey FOREIGN KEY (id_artigo) REFERENCES saec.artigo(id);


--
-- TOC entry 2941 (class 2606 OID 16446)
-- Name: participante participante_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.participante
    ADD CONSTRAINT participante_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES saec.instituicao(id);


--
-- TOC entry 2954 (class 2606 OID 16609)
-- Name: publicacao publicacao_cpf_autor_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.publicacao
    ADD CONSTRAINT publicacao_cpf_autor_fkey FOREIGN KEY (cpf_autor) REFERENCES saec.autor(cpf);


--
-- TOC entry 2955 (class 2606 OID 16614)
-- Name: publicacao publicacao_id_artigo_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.publicacao
    ADD CONSTRAINT publicacao_id_artigo_fkey FOREIGN KEY (id_artigo) REFERENCES saec.artigo(id);


--
-- TOC entry 2945 (class 2606 OID 16488)
-- Name: responsavel responsavel_cpf_fkey; Type: FK CONSTRAINT; Schema: saec; Owner: diego
--

ALTER TABLE ONLY saec.responsavel
    ADD CONSTRAINT responsavel_cpf_fkey FOREIGN KEY (cpf) REFERENCES saec.participante(cpf);


-- Completed on 2018-10-31 12:23:43 -03

--
-- PostgreSQL database dump complete
--

