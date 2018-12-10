<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Controllers\Controller;

class ArtigoController extends Controller
{
    public function index(Request $request, Response $response) {
        $sql = "SELECT * 
                FROM (
                    SELECT DISTINCT id_artigo, data_publicacao
                    FROM publicacao WHERE data_publicacao >= current_date - 30
                ) 
                AS publicacao
                JOIN artigo
                ON publicacao.id_artigo = artigo.id";
        
        $query = $this->db->prepare($sql);
        $query->execute();

        $artigos = $query->fetchAll();

        $this->view->render($response, 'artigo/index.html.twig', [
            'artigos' => $artigos
        ]);
    }

    public function ranking(Request $request, Response $response) {
        $sql = "SELECT * FROM ranking_artigos";
        
        $query = $this->db->prepare($sql);
        $query->execute();

        $ranking = $query->fetchAll();

        $this->view->render($response, 'artigo/ranking.html.twig', [
            'ranking' => $ranking
        ]);        
    }
}
