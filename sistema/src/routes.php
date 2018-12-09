<?php

use Slim\Http\Request;
use Slim\Http\Response;

// Routes

$app->get('/[{name}]', function (Request $request, Response $response, array $args) {
    $query = $this->db->prepare("SELECT * FROM participante");
    $query->execute();

    $result = $query->fetchAll();
    print_r($result);
});
