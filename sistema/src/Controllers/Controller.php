<?php

namespace App\Controllers;

use Interop\Container\ContainerInterface;

abstract class Controller
{
    protected $view;
    protected $db;
    protected $router;

    public function __construct(ContainerInterface $container) {
        $this->view = $container->view;
        $this->db = $container->db;
        $this->router = $container->router;
    }
}
