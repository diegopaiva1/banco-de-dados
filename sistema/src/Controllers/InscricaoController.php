<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Controllers\Controller;

class InscricaoController extends Controller
{
    public function index(Request $request, Response $response) {
        $sql = "SELECT * FROM evento";
        $query = $this->db->prepare($sql);
        $query->execute();

        $eventos = $query->fetchAll();

        return $this->view->render($response, 'inscricao/index.html.twig', [
            'eventos' => $eventos
        ]);
    }

    public function getInscricoesByEventoId(Request $request, Response $response, $args) {
        $id = $args['id'];
        $query = $this->db->prepare("SELECT nome FROM evento WHERE id = ?");
        $query->execute([$id]);
        $evento = $query->fetch();

        $sql = "SELECT *
                FROM ( (SELECT * FROM inscricao WHERE id_evento = ?) ) AS inscritos
                JOIN participante
                ON inscritos.cpf_participante = participante.cpf";

        $query = $this->db->prepare($sql);
        $query->execute([$id]);

        $inscricoes = $query->fetchAll();

        return $this->view->render($response, 'inscricao/list.html.twig', [
            'inscricoes' => $inscricoes,
            'evento'     => $evento[0]
        ]);
    }
}
