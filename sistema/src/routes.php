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
