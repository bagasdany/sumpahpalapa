<?php

namespace Database\Seeders;

use App\Models\Permissions;
use App\Models\RolePermissions;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PermissionDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            [
                'id' => 1,
                'name' => 'dashboard',
                'url' => '/',
                'type' => 1
            ],
            [
                'id' => 2,
                'name' => 'shops',
                'url' => '/shops',
                'type' => 1
            ],
            [
                'id' => 3,
                'name' => 'shops.add',
                'url' => '/shops/add',
                'type' => 1
            ],
            [
                'id' => 4,
                'name' => 'shops.edit',
                'url' => '/shops/edit',
                'type' => 1
            ],
            [
                'id' => 5,
                'name' => 'shops.delete',
                'url' => '/shops/delete',
                'type' => 1
            ],
            [
                'id' => 6,
                'name' => 'shops-categories',
                'url' => '/shops-categories',
                'type' => 1
            ],
            [
                'id' => 7,
                'name' => 'shops-categories.add',
                'url' => '/shops-categories/add',
                'type' => 1
            ],
            [
                'id' => 8,
                'name' => 'shops-categories.edit',
                'url' => '/shops-categories/edit',
                'type' => 1
            ],
            [
                'id' => 9,
                'name' => 'shops-categories.delete',
                'url' => '/shops-categories/delete',
                'type' => 1
            ],
            [
                'id' => 10,
                'name' => 'shops-currencies',
                'url' => '/shops-currencies',
                'type' => 1
            ],
            [
                'id' => 11,
                'name' => 'shops-currencies.add',
                'url' => '/shops-currencies/add',
                'type' => 1
            ],
            [
                'id' => 12,
                'name' => 'shops-currencies.edit',
                'url' => '/shops-currencies/edit',
                'type' => 1
            ],
            [
                'id' => 13,
                'name' => 'shops-currencies.delete',
                'url' => '/shops-currencies/delete',
                'type' => 1
            ],
            [
                'id' => 14,
                'name' => 'brands',
                'url' => '/brands',
                'type' => 1
            ],
            [
                'id' => 15,
                'name' => 'brands.add',
                'url' => '/brands/add',
                'type' => 1
            ],
            [
                'id' => 16,
                'name' => 'brands.edit',
                'url' => '/brands/edit',
                'type' => 1
            ],
            [
                'id' => 17,
                'name' => 'brands.delete',
                'url' => '/brands/delete',
                'type' => 1
            ],
            [
                'id' => 18,
                'name' => 'brands-categories',
                'url' => '/brands-categories',
                'type' => 1
            ],
            [
                'id' => 19,
                'name' => 'brands-categories.add',
                'url' => '/brands-categories/add',
                'type' => 1
            ],
            [
                'id' => 20,
                'name' => 'brands-categories.edit',
                'url' => '/brands-categories/edit',
                'type' => 1
            ],
            [
                'id' => 21,
                'name' => 'brands-categories.delete',
                'url' => '/brands-categories/delete',
                'type' => 1
            ],
            [
                'id' => 22,
                'name' => 'categories',
                'url' => '/categories',
                'type' => 1
            ],
            [
                'id' => 23,
                'name' => 'categories.add',
                'url' => '/categories/add',
                'type' => 1
            ],
            [
                'id' => 24,
                'name' => 'categories.edit',
                'url' => '/categories/edit',
                'type' => 1
            ],
            [
                'id' => 25,
                'name' => 'categories.delete',
                'url' => '/categories/delete',
                'type' => 1
            ],
            [
                'id' => 26,
                'name' => 'products',
                'url' => '/products',
                'type' => 1
            ],
            [
                'id' => 27,
                'name' => 'products.add',
                'url' => '/products/add',
                'type' => 1
            ],
            [
                'id' => 28,
                'name' => 'products.edit',
                'url' => '/products/edit',
                'type' => 1
            ],
            [
                'id' => 29,
                'name' => 'products.delete',
                'url' => '/products/delete',
                'type' => 1
            ],
            [
                'id' => 30,
                'name' => 'product-comments',
                'url' => '/product-comments',
                'type' => 1
            ],
            [
                'id' => 31,
                'name' => 'product-comments.add',
                'url' => '/product-comments/add',
                'type' => 1
            ],
            [
                'id' => 32,
                'name' => 'product-comments.edit',
                'url' => '/product-comments/edit',
                'type' => 1
            ],
            [
                'id' => 33,
                'name' => 'product-comments.delete',
                'url' => '/product-comments/delete',
                'type' => 1
            ],
            [
                'id' => 34,
                'name' => 'discounts',
                'url' => '/discounts',
                'type' => 1
            ],
            [
                'id' => 35,
                'name' => 'discounts.add',
                'url' => '/discounts/add',
                'type' => 1
            ],
            [
                'id' => 36,
                'name' => 'discounts.edit',
                'url' => '/discounts/edit',
                'type' => 1
            ],
            [
                'id' => 37,
                'name' => 'discounts.delete',
                'url' => '/discounts/delete',
                'type' => 1
            ],
            [
                'id' => 38,
                'name' => 'orders',
                'url' => '/orders',
                'type' => 1
            ],
            [
                'id' => 39,
                'name' => 'orders.add',
                'url' => '/orders/add',
                'type' => 1
            ],
            [
                'id' => 40,
                'name' => 'orders.edit',
                'url' => '/orders/edit',
                'type' => 1
            ],
            [
                'id' => 41,
                'name' => 'orders.delete',
                'url' => '/orders/delete',
                'type' => 1
            ],
            [
                'id' => 42,
                'name' => 'order-statuses',
                'url' => '/order-statuses',
                'type' => 1
            ],
            [
                'id' => 43,
                'name' => 'order-statuses.add',
                'url' => '/order-statuses/add',
                'type' => 1
            ],
            [
                'id' => 44,
                'name' => 'order-statuses.edit',
                'url' => '/order-statuses/edit',
                'type' => 1
            ],
            [
                'id' => 45,
                'name' => 'order-statuses.delete',
                'url' => '/order-statuses/delete',
                'type' => 1
            ],
            [
                'id' => 46,
                'name' => 'order-comments',
                'url' => '/order-comments',
                'type' => 1
            ],
            [
                'id' => 47,
                'name' => 'order-comments.add',
                'url' => '/order-comments/add',
                'type' => 1
            ],
            [
                'id' => 48,
                'name' => 'order-comments.edit',
                'url' => '/order-comments/edit',
                'type' => 1
            ],
            [
                'id' => 49,
                'name' => 'order-comments.delete',
                'url' => '/order-comments/delete',
                'type' => 1
            ],
            [
                'id' => 50,
                'name' => 'payment-methods',
                'url' => '/payment-methods',
                'type' => 1
            ],
            [
                'id' => 51,
                'name' => 'payment-methods.add',
                'url' => '/payment-methods/add',
                'type' => 1
            ],
            [
                'id' => 52,
                'name' => 'payment-methods.edit',
                'url' => '/payment-methods/edit',
                'type' => 1
            ],
            [
                'id' => 53,
                'name' => 'payment-methods.delete',
                'url' => '/payment-methods/delete',
                'type' => 1
            ],
            [
                'id' => 54,
                'name' => 'payment-statuses',
                'url' => '/payment-statuses',
                'type' => 1
            ],
            [
                'id' => 55,
                'name' => 'payment-statuses.add',
                'url' => '/payment-statuses/add',
                'type' => 1
            ],
            [
                'id' => 56,
                'name' => 'payment-statuses.edit',
                'url' => '/payment-statuses/edit',
                'type' => 1
            ],
            [
                'id' => 57,
                'name' => 'payment-statuses.delete',
                'url' => '/payment-statuses/delete',
                'type' => 1
            ],
            [
                'id' => 58,
                'name' => 'payments',
                'url' => '/payments',
                'type' => 1
            ],
            [
                'id' => 59,
                'name' => 'payments.add',
                'url' => '/payments/add',
                'type' => 1
            ],
            [
                'id' => 60,
                'name' => 'payments.edit',
                'url' => '/payments/edit',
                'type' => 1
            ],
            [
                'id' => 61,
                'name' => 'payments.delete',
                'url' => '/payments/delete',
                'type' => 1
            ],
            [
                'id' => 62,
                'name' => 'coupons',
                'url' => '/coupons',
                'type' => 1
            ],
            [
                'id' => 63,
                'name' => 'coupons.add',
                'url' => '/coupons/add',
                'type' => 1
            ],
            [
                'id' => 64,
                'name' => 'coupons.edit',
                'url' => '/coupons/edit',
                'type' => 1
            ],
            [
                'id' => 65,
                'name' => 'coupons.delete',
                'url' => '/coupons/delete',
                'type' => 1
            ],
            [
                'id' => 66,
                'name' => 'banners',
                'url' => '/banners',
                'type' => 1
            ],
            [
                'id' => 67,
                'name' => 'banners.add',
                'url' => '/banners/add',
                'type' => 1
            ],
            [
                'id' => 68,
                'name' => 'banners.edit',
                'url' => '/banners/edit',
                'type' => 1
            ],
            [
                'id' => 69,
                'name' => 'banners.delete',
                'url' => '/banners/delete',
                'type' => 1
            ],
            [
                'id' => 70,
                'name' => 'notifications',
                'url' => '/notifications',
                'type' => 1
            ],
            [
                'id' => 71,
                'name' => 'notifications.add',
                'url' => '/notifications/add',
                'type' => 1
            ],
            [
                'id' => 72,
                'name' => 'notifications.edit',
                'url' => '/notifications/edit',
                'type' => 1
            ],
            [
                'id' => 73,
                'name' => 'notifications.delete',
                'url' => '/notifications/delete',
                'type' => 1
            ],
            [
                'id' => 74,
                'name' => 'languages',
                'url' => '/languages',
                'type' => 1
            ],
            [
                'id' => 75,
                'name' => 'languages.add',
                'url' => '/languages/add',
                'type' => 1
            ],
            [
                'id' => 76,
                'name' => 'languages.edit',
                'url' => '/languages/edit',
                'type' => 1
            ],
            [
                'id' => 77,
                'name' => 'languages.delete',
                'url' => '/languages/delete',
                'type' => 1
            ],
            [
                'id' => 78,
                'name' => 'languages.default',
                'url' => '/languages/default',
                'type' => 1
            ],
            [
                'id' => 79,
                'name' => 'units',
                'url' => '/units',
                'type' => 1
            ],
            [
                'id' => 80,
                'name' => 'units.add',
                'url' => '/units/add',
                'type' => 1
            ],
            [
                'id' => 81,
                'name' => 'units.edit',
                'url' => '/units/edit',
                'type' => 1
            ],
            [
                'id' => 82,
                'name' => 'units.delete',
                'url' => '/units/delete',
                'type' => 1
            ],
            [
                'id' => 83,
                'name' => 'currencies',
                'url' => '/currencies',
                'type' => 1
            ],
            [
                'id' => 84,
                'name' => 'currencies.add',
                'url' => '/currencies/add',
                'type' => 1
            ],
            [
                'id' => 85,
                'name' => 'currencies.edit',
                'url' => '/currencies/edit',
                'type' => 1
            ],
            [
                'id' => 86,
                'name' => 'currencies.delete',
                'url' => '/currencies/delete',
                'type' => 1
            ],
            [
                'id' => 87,
                'name' => 'time-units',
                'url' => '/time-units',
                'type' => 1
            ],
            [
                'id' => 88,
                'name' => 'time-units.add',
                'url' => '/time-units/add',
                'type' => 1
            ],
            [
                'id' => 89,
                'name' => 'time-units.edit',
                'url' => '/time-units/edit',
                'type' => 1
            ],
            [
                'id' => 90,
                'name' => 'time-units.delete',
                'url' => '/time-units/delete',
                'type' => 1
            ],
            [
                'id' => 91,
                'name' => 'clients',
                'url' => '/clients',
                'type' => 1
            ],
            [
                'id' => 92,
                'name' => 'clients.delete',
                'url' => '/clients/delete',
                'type' => 1
            ],
            [
                'id' => 93,
                'name' => 'client-addresses',
                'url' => '/client-addresses',
                'type' => 1
            ],
            [
                'id' => 94,
                'name' => 'client-addresses.delete',
                'url' => '/client-addresses/delete',
                'type' => 1
            ],
            [
                'id' => 95,
                'name' => 'admins',
                'url' => '/admins',
                'type' => 1
            ],
            [
                'id' => 96,
                'name' => 'admins.add',
                'url' => '/admins/add',
                'type' => 1
            ],
            [
                'id' => 97,
                'name' => 'admins.edit',
                'url' => '/admins/edit',
                'type' => 1
            ],
            [
                'id' => 98,
                'name' => 'admins.delete',
                'url' => '/admins/delete',
                'type' => 1
            ],
            [
                'id' => 99,
                'name' => 'roles',
                'url' => '/roles',
                'type' => 1
            ],
            [
                'id' => 100,
                'name' => 'permissions',
                'url' => '/permissions',
                'type' => 1
            ],
            [
                'id' => 101,
                'name' => 'app-language',
                'url' => '/app-language',
                'type' => 1
            ],
            [
                'id' => 102,
                'name' => 'medias',
                'url' => '/medias',
                'type' => 1
            ],
            [
                'id' => 103,
                'name' => 'medias.delete',
                'url' => '/medias/delete',
                'type' => 1
            ],
            [
                'id' => 104,
                'name' => 'terms',
                'url' => '/terms',
                'type' => 1
            ],
            [
                'id' => 105,
                'name' => 'terms.edit',
                'url' => '/terms/edit',
                'type' => 1
            ],
            [
                'id' => 106,
                'name' => 'faq',
                'url' => '/faq',
                'type' => 1
            ],
            [
                'id' => 107,
                'name' => 'faq.edit',
                'url' => '/faq/edit',
                'type' => 1
            ],
            [
                'id' => 108,
                'name' => 'about',
                'url' => '/about',
                'type' => 1
            ],
            [
                'id' => 109,
                'name' => 'about.edit',
                'url' => '/about/edit',
                'type' => 1
            ],
            [
                'id' => 110,
                'name' => 'privacy',
                'url' => '/privacy',
                'type' => 1
            ],
            [
                'id' => 111,
                'name' => 'privacy.edit',
                'url' => '/privacy/edit',
                'type' => 1
            ],
            [
                'id' => 112,
                'name' => 'app-language.edit',
                'url' => '/app-language/edit',
                'type' => 1
            ],
            [
                'id' => 113,
                'name' => 'faq.add',
                'url' => '/faq/add',
                'type' => 1
            ],
            [
                'id' => 114,
                'name' => 'faq.delete',
                'url' => '/faq/delete',
                'type' => 1
            ],
            [
                'id' => 115,
                'name' => 'client-addresses.add',
                'url' => '/client-addresses/add',
                'type' => 1
            ],
            [
                'id' => 116,
                'name' => 'chat',
                'url' => '/chat',
                'type' => 1
            ],
            [
                'id' => 117,
                'name' => 'phone-prefix',
                'url' => '/phone-prefix',
                'type' => 1
            ],
            [
                'id' => 118,
                'name' => 'phone-prefix.add',
                'url' => '/phone-prefix/add',
                'type' => 1
            ],
            [
                'id' => 119,
                'name' => 'phone-prefix.edit',
                'url' => '/phone-prefix/edit',
                'type' => 1
            ],
            [
                'id' => 120,
                'name' => 'phone-prefix.delete',
                'url' => '/phone-prefix/delete',
                'type' => 1
            ],
            [
                'id' => 121,
                'name' => 'manager-requests',
                'url' => '/manager-requests',
                'type' => 1
            ],
            [
                'id' => 122,
                'name' => 'manager-requests.edit',
                'url' => '/manager-requests/edit',
                'type' => 1
            ],
            [
                'id' => 123,
                'name' => 'about.delete',
                'url' => '/about/delete',
                'type' => 1
            ],
            [
                'id' => 128,
                'name' => 'shop-delivery-type',
                'url' => '/shop-delivery-type',
                'type' => 1
            ],
            [
                'id' => 129,
                'name' => 'shop-delivery-type.add',
                'url' => '/shop-delivery-type/add',
                'type' => 1
            ],
            [
                'id' => 130,
                'name' => 'shop-delivery-type.edit',
                'url' => '/shop-delivery-type/edit',
                'type' => 1
            ],
            [
                'id' => 131,
                'name' => 'shop-delivery-type.delete',
                'url' => '/shop-delivery-type/delete',
                'type' => 1
            ],
            [
                'id' => 132,
                'name' => 'shops.deliveries',
                'url' => '/shops/deliveries',
                'type' => 1
            ],
            [
                'id' => 133,
                'name' => 'shops.deliveries.add',
                'url' => '/shops/deliveries/add',
                'type' => 1
            ],
            [
                'id' => 134,
                'name' => 'shops.deliveries.edit',
                'url' => '/shops/deliveries/edit',
                'type' => 1
            ],
            [
                'id' => 135,
                'name' => 'shops.deliveries.delete',
                'url' => '/shops/deliveries/delete',
                'type' => 1
            ],
            [
                'id' => 136,
                'name' => 'delivery-boy',
                'url' => '/delivery-boy',
                'type' => 1
            ],
            [
                'id' => 137,
                'name' => 'delivery-map',
                'url' => '/delivery-map',
                'type' => 1
            ],
            [
                'id' => 138,
                'name' => 'delivery-orders-status',
                'url' => '/delivery-orders-status',
                'type' => 1
            ],
            [
                'id' => 139,
                'name' => 'pos-system',
                'url' => '/pos-system',
                'type' => 1
            ],
            [
                'id' => 140,
                'name' => 'taxes',
                'url' => '/taxes',
                'type' => 1
            ],
            [
                'id' => 141,
                'name' => 'taxes.add',
                'url' => '/taxes/add',
                'type' => 1
            ],
            [
                'id' => 142,
                'name' => 'taxes.edit',
                'url' => '/taxes/edit',
                'type' => 1
            ],
            [
                'id' => 143,
                'name' => 'taxes.delete',
                'url' => '/taxes/delete',
                'type' => 1
            ],
            [
                'id' => 144,
                'name' => 'shipping-transports',
                'url' => '/shipping-transports',
                'type' => 1
            ],
            [
                'id' => 145,
                'name' => 'shipping-transports.add',
                'url' => '/shipping-transports/add',
                'type' => 1
            ],
            [
                'id' => 146,
                'name' => 'shipping-transports.edit',
                'url' => '/shipping-transports/edit',
                'type' => 1
            ],
            [
                'id' => 147,
                'name' => 'shipping-transports.delete',
                'url' => '/shipping-transports/delete',
                'type' => 1
            ],
            [
                'id' => 148,
                'name' => 'shipping-box',
                'url' => '/shipping-box',
                'type' => 1
            ],
            [
                'id' => 149,
                'name' => 'shipping-box.add',
                'url' => '/shipping-box/add',
                'type' => 1
            ],
            [
                'id' => 150,
                'name' => 'shipping-box.edit',
                'url' => '/shipping-box/edit',
                'type' => 1
            ],
            [
                'id' => 151,
                'name' => 'shipping-box.delete',
                'url' => '/shipping-box/delete',
                'type' => 1
            ],
            [
                'id' => 152,
                'name' => 'category-taxes',
                'url' => '/category-taxes',
                'type' => 1
            ],
            [
                'id' => 153,
                'name' => 'category-taxes.add',
                'url' => '/category-taxes/add',
                'type' => 1
            ],
            [
                'id' => 154,
                'name' => 'category-taxes.delete',
                'url' => '/category-taxes/delete',
                'type' => 1
            ],
            [
                'id' => 155,
                'name' => 'category-taxes.edit',
                'url' => '/category-taxes/edit',
                'type' => 1
            ],
            [
                'id' => 156,
                'name' => 'clients.add',
                'url' => '/clients/add',
                'type' => 1
            ],
            [
                'id' => 157,
                'name' => 'clients.edit',
                'url' => '/clients/edit',
                'type' => 1
            ],
            [
                'id' => 158,
                'name' => 'import',
                'url' => '/import',
                'type' => 1
            ],
            [
                'id' => 159,
                'name' => 'transactions',
                'url' => '/transactions',
                'type' => 1
            ],
            [
                'id' => 160,
                'name' => 'export',
                'url' => '/export',
                'type' => 1
            ],
            [
                'id' => 161,
                'name' => 'server',
                'url' => '/server',
                'type' => 1
            ],
            [
                'id' => 162,
                'name' => 'update',
                'url' => '/update',
                'type' => 1
            ],
        ];



        foreach ($data as $value) {
            Permissions::firstOrCreate(['id' => $value['id']],[
                'name' => $value['name'],
                'url' => $value['url'],
                'type' => $value['type'],
            ]);

            RolePermissions::firstOrCreate(['id_permission' => $value['id']],[
                'id_role' => 1,
                'created_at' => now()
                ]);
        }
    }
}
