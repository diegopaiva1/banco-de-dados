<?php

$app->get('/', 'DashboardController:index')->setName('dashboard.index');

// Inscricao
$app->get('/inscricoes', 'InscricaoController:index')->setName('inscricao.index');
$app->get('/inscricoes/evento/[{id}]', 'InscricaoController:getInscricoesByEventoId')
    ->setName('inscricao.evento');

// Instituicao
$app->get('/instituicoes', 'InstituicaoController:index')->setName('instituicao.index');
$app->get('/instituicoes/new', 'InstituicaoController:create')->setName('instituicao.create');
$app->post('/instituicoes/new', 'InstituicaoController:store')->setName('instituicao.store');

// Artigo
$app->get('/artigos', 'ArtigoController:index')->setName('artigo.index');
$app->get('/artigos/ranking', 'ArtigoController:ranking')->setName('artigo.ranking');

// Área do conhecimento
$app->get('/areas/new', 'AreaConhecimentoController:create')->setName('area.create');
$app->post('/areas/new', 'AreaConhecimentoController:store')->setName('area.store');
