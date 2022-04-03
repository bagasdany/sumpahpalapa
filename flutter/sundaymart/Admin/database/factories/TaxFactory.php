<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class TaxFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'shop_id' => $this->faker->numberBetween(1,4),
            'name' => $this->faker->name(),
            'description' => $this->faker->text(500),
            'price' => $this->faker->numberBetween(2,30 ),
            'default' => true,
            'active' => true,
        ];
    }
}
