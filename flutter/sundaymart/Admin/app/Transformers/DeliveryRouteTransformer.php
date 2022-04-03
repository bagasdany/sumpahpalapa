<?php

namespace App\Transformers;

use App\Models\DeliveryRoute;
use League\Fractal\TransformerAbstract;

class DeliveryRouteTransformer extends TransformerAbstract
{
    public function transform(DeliveryRoute $deliveryRoute)
    {
        return [
            'id'            => (int) $deliveryRoute->id,
            'order_id'      => (int) $deliveryRoute->order_id,
            'origin'        => (string) $deliveryRoute->origin_address,
            'destination'   => (string) $deliveryRoute->destination_address,
            'distance'      => round(($deliveryRoute->distance / 1000), 1,PHP_ROUND_HALF_UP) . ' km',
            'duration'      => round(($deliveryRoute->duration / 60), 1, PHP_ROUND_HALF_UP) . ' min',
            'price'        => $deliveryRoute->price,
            'type'          => $deliveryRoute->type,
            'properties'    => $deliveryRoute->properties
        ];
    }
}
