<?php

// Instituicao
$app->get('/instituicao', 'InstituicaoController:index')->setName('instituicao.index');
$app->get('/instituicao/new', 'InstituicaoController:create')->setName('instituicao.create');
$app->post('/instituicao/new', 'InstituicaoController:store')->setName('instituicao.store');
