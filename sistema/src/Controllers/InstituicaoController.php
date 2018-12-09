<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Controllers\Controller;

class InstituicaoController extends Controller
{
    public function index(Request $request, Response $response) {
        $sql = "SELECT * FROM instituicao";
        $query = $this->db->prepare($sql);
        $query->execute();

        $instituicoes = $query->fetchAll();

        return $this->view->render($response, 'instituicao/index.html.twig', [
            "instituicoes" => $instituicoes
        ]);
    }

    public function create(Request $request, Response $response) {
        $this->view->render($response, 'instituicao/new.html.twig');
    }

    public function store(Request $request, Response $response) {
        $params = [$request->getParam('sigla'), $request->getParam('nome')];

        $query = "INSERT INTO instituicao (sigla, nome) VALUES (?, ?)";
        
        return $this->db->prepare($query)->execute($params);
    }
}
