<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Controllers\Controller;

class DashboardController extends Controller
{
    public function index(Request $request, Response $response) {
        $this->view->render($response, 'dashboard/index.html.twig');
    }
}
