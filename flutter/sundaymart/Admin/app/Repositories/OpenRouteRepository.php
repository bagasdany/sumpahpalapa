<?php
/*
 * Class for working with maps and geolocations via a service OPEN ROUTE SERVICE
 * https://openrouteservice.org/
 *
 * The key for working with this API is provided by the account "tony.sapay@gmail.com"
 */
namespace App\Repositories;

use App\Repositories\Interfaces\OpenRouteInterface;
use App\Models\DeliveryRoute as Model;
use Http;

class OpenRouteRepository extends CoreRepository implements OpenRouteInterface
{
    const BASIC_URL = 'https://api.openrouteservice.org';
    const API_KEY = '5b3ce3597851110001cf62485d270d34426b44ce91f848bc10152428';

    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass(): string
    {
        return $this->model = Model::class;
    }

    /**
     * Returns a route between two or more locations for a selected profile and its settings as JSON
     * @param string $type is path param, which can be "driving-car" or "foot-walking"
     * @param array $origin is start coordinates should be "[lon,lat]"
     * @param array $destination is end coordinates should be "[lon,lat]"
     * @return mixed
     * @throws \GuzzleHttp\Exception\GuzzleException
     */
    public function getDirections(string $type, array $origin, array $destination)
    {
        $headers = ['Authorization' => self::API_KEY];
        $params = [
            'coordinates' => [$origin, $destination]
        ];

        try {
            $response = Http::withHeaders($headers)->post(self::BASIC_URL . '/v2/directions/' . $type . '/geojson', $params);
        } catch (\Exception $exception) {
            return json_decode($exception->getMessage());
        }
        return json_decode($response->body());
    }
}
