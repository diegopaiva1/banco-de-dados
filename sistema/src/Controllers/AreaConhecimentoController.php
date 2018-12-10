<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Controllers\Controller;

class AreaConhecimentoController extends Controller
{
    public function create(Request $request, Response $response) {
        $sql = "SELECT * FROM area_conhecimento";
        $query = $this->db->prepare($sql);
        $query->execute();

        $areas = $query->fetchAll();

        return $this->view->render($response, 'area-conhecimento/new.html.twig', [
            'areas' => $areas
        ]);
    }

    public function store(Request $request, Response $response) {
        if ($request->getParam('area_pai') === '')
            $id = null;
        else
            $id = $request->getParam('area_pai');

        $params = [$request->getParam('nome'), $id];

        $query = "INSERT INTO area_conhecimento (nome, id_area_pai) VALUES (?, ?)";
        
        $this->db->prepare($query)->execute($params);

        return $response->withRedirect($this->router->pathFor('area.create'));
        die();
    }    
}
