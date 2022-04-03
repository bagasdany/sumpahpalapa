<?php

namespace App\Repositories\Interfaces;

interface OpenRouteInterface
{
    public function getDirections(string $type, array $origin, array $destination);
}
