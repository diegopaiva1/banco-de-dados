<?php

$app->get('/', 'DashboardController:index')->setName('dashboard.index');

// Instituicao
$app->get('/instituicoes', 'InstituicaoController:index')->setName('instituicao.index');
$app->get('/instituicoes/new', 'InstituicaoController:create')->setName('instituicao.create');
$app->post('/instituicoes/new', 'InstituicaoController:store')->setName('instituicao.store');
