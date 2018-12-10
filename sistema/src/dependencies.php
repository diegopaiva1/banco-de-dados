<?php
// DIC configuration

$container = $app->getContainer();

// view renderer
$container['renderer'] = function ($c) {
    $settings = $c->get('settings')['renderer'];
    return new Slim\Views\PhpRenderer($settings['template_path']);
};

// Register Twig View helper
$container['view'] = function ($c) {
    $settings = $c->get('settings')['renderer'];
    $view = new \Slim\Views\Twig($settings['template_path']);
    
    // Instantiate and add Slim specific extension
    $router = $c->get('router');
    $uri = \Slim\Http\Uri::createFromEnvironment(new \Slim\Http\Environment($_SERVER));
    $view->addExtension(new \Slim\Views\TwigExtension($router, $uri));

    return $view;
};

// monolog
$container['logger'] = function ($c) {
    $settings = $c->get('settings')['logger'];
    $logger = new Monolog\Logger($settings['name']);
    $logger->pushProcessor(new Monolog\Processor\UidProcessor());
    $logger->pushHandler(new Monolog\Handler\StreamHandler($settings['path'], $settings['level']));
    return $logger;
};

$container['db'] = function($c) {
    $settings = $c->get('settings')['db'];

    // PDO first string paramater 
    $dsn = $settings['driver'] . ':host=' . $settings['host'] . ';port=' .
           $settings['port'] . ';dbname=' . $settings['database'];

    try {
        return new PDO($dsn, $settings['username'], $settings['password'], 
                       [PDO::ATTR_PERSISTENT => true, PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    }
    catch(PDOException $e) {
        throw new PDOException($e);
    }    
};

$container['InstituicaoController'] = function ($c) {
    return new App\Controllers\InstituicaoController($c);
};

$container['DashboardController'] = function ($c) {
    return new App\Controllers\DashboardController($c);
};

$container['InscricaoController'] = function ($c) {
    return new App\Controllers\InscricaoController($c);
};

$container['ArtigoController'] = function ($c) {
    return new App\Controllers\ArtigoController($c);
};

$container['AreaConhecimentoController'] = function ($c) {
    return new App\Controllers\AreaConhecimentoController($c);
};
