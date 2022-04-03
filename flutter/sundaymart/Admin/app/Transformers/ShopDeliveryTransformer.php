<?php

namespace App\Transformers;

use App\Models\ShopDelivery;
use League\Fractal\TransformerAbstract;

class ShopDeliveryTransformer extends TransformerAbstract
{
    public function transform(ShopDelivery $shopDelivery)
    {
        return [
            'id'      => (int) $shopDelivery->id,
            'shop_id'   => (int) $shopDelivery->shop_id,
            'delivery_type_id'    => (int) $shopDelivery->delivery_type_id,
            'type'    => (int) $shopDelivery->type,
            'start'    => (int) $shopDelivery->start,
            'end'    => (int) $shopDelivery->end,
            'amount'    => (int) $shopDelivery->amount,
            'active'    => (boolean) $shopDelivery->active,
        ];
    }
}
