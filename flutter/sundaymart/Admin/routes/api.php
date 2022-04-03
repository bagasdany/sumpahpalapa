<?php

use App\Http\Controllers\Backend\Admin\DeliveryTypeController;
use App\Http\Controllers\BalanceController;
use App\Http\Controllers\DeliveryTransportController;
use App\Http\Controllers\Payment\BasePaymentController;
use App\Http\Controllers\Payment\FlutterwaveController;
use App\Http\Controllers\Payment\PaypalController;
use App\Http\Controllers\Payment\PaystackController;
use App\Http\Controllers\Payment\RazorpayController;
use App\Http\Controllers\Payment\SeerafaController;
use App\Http\Controllers\PointController;
use App\Http\Controllers\ShippingBoxController;
use App\Http\Controllers\ShopShippingBoxController;
use App\Http\Controllers\ShopSocialController;
use App\Http\Controllers\ShopTransportController;
use App\Http\Controllers\SocialController;
use App\Http\Controllers\StatisticsController;
use App\Http\Controllers\TaxController;
use App\Http\Controllers\TicketController;
use App\Http\Controllers\TransactionController;
use Illuminate\Support\Facades\Route;
use \App\Http\Controllers\AuthController;
use \App\Http\Controllers\UploadController;
use \App\Http\Controllers\LanguageController;
use \App\Http\Controllers\ShopsController;
use \App\Http\Controllers\BrandController;
use \App\Http\Controllers\CategoryController;
use \App\Http\Controllers\UnitController;
use \App\Http\Controllers\TimeUnitsController;
use \App\Http\Controllers\ProductController;
use \App\Http\Controllers\ClientController;
use \App\Http\Controllers\AddressController;
use \App\Http\Controllers\AdminController;
use \App\Http\Controllers\RolePermissionController;
use \App\Http\Controllers\PaymentController;
use \App\Http\Controllers\OrderController;
use \App\Http\Controllers\BannerController;
use \App\Http\Controllers\CouponController;
use \App\Http\Controllers\AppSettingsController;
use \App\Http\Controllers\ExtraGroupController;
use \App\Http\Controllers\ExtraController;
use \App\Http\Controllers\Mobile;
use \App\Http\Controllers\ShopCategoriesController;
use \App\Http\Controllers\CurrencyController;
use \App\Http\Controllers\ShopsCurrienciesController;
use \App\Http\Controllers\NotificationsController;
use \App\Http\Controllers\DiscountController;
use \App\Http\Controllers\PaymentsController;
use \App\Http\Controllers\ShopPaymentController;
use \App\Http\Controllers\BrandCategoriesController;
use \App\Http\Controllers\MediaController;
use \App\Http\Controllers\ProductsCharactericsController;
use \App\Http\Controllers\FaqController;
use \App\Http\Controllers\AboutController;
use \App\Http\Controllers\PrivacyController;
use \App\Http\Controllers\TermsController;
use \App\Http\Controllers\AdminNotificationsController;
use \App\Http\Controllers\MessageController;
use \App\Http\Controllers\PhonePrefixController;
use \App\Http\Controllers\API\RouteController;
use \App\Http\Controllers\Backend\Admin\ShopDeliveryController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {
    Route::post('/login', [AuthController::class, 'login'])->name('login');
    Route::post('/upload', [UploadController::class, 'upload']);
    Route::post('/manager/save', [AdminController::class, 'create']);
    Route::get('/shop/licensee', [ShopsController::class, 'licensee'])->name('licensee');
    Route::post('/shop/activate', [ShopsController::class, 'activate'])->name('activate');
    Route::post('/product/import', [ProductController::class, 'import']);
    Route::get('/payment/flutterwave/callback', [FlutterwaveController::class, 'flutterwaveCallbackUrl']);
    Route::get('/payment/paystack/callback', [PaystackController::class, 'paystackCallbackUrl']);
    Route::get('/payment/razorpay/callback', [RazorpayController::class, 'razorpayCallbackUrl']);
    Route::post('/payment/paypal/callback', [PaypalController::class, 'paypalCallbackUrl']);
});

Route::group([
    'middleware' => 'jwt.verify',
    'prefix' => 'auth'
], function ($router) {
    //language
    Route::post('/language/save', [LanguageController::class, 'save']);
    Route::post('/language/datatable', [LanguageController::class, 'datatable']);
    Route::post('/language/delete', [LanguageController::class, 'delete']);
    Route::post('/language/get', [LanguageController::class, 'get']);
    Route::post('/language/default', [LanguageController::class, 'makeDefault']);
    Route::post('/language/active', [LanguageController::class, 'active']);

    //shops
    Route::post('/shop/save', [ShopsController::class, 'save']);
    Route::post('/shop/datatable', [ShopsController::class, 'datatable']);
    Route::post('/shop/get', [ShopsController::class, 'get']);
    Route::post('/shop/delete', [ShopsController::class, 'delete']);
    Route::post('/shop/active', [ShopsController::class, 'active']);
    Route::get('/shop/{id}/transactions', [TransactionController::class, 'shopTransaction']);

    // shop delivery
    Route::get('/shop/deliveries/datatable', [ShopDeliveryController::class, 'datatable']);
    Route::post('/shop/deliveries/save', [ShopDeliveryController::class, 'save']);
    Route::get('/shop/deliveries/get/{id}', [ShopDeliveryController::class, 'get']);
    Route::post('/shop/deliveries/delete', [ShopDeliveryController::class, 'delete']);
    Route::get('/shop/deliveries/shop/{id}', [ShopDeliveryController::class, 'getByShopId']);
    Route::get('/shop/deliveries/active/{id}', [ShopDeliveryController::class, 'getActiveShopDeliveries']);
    Route::post('/shop/deliveries/status', [ShopDeliveryController::class, 'changeStatus']);

    // shop transport
    Route::get('/shop/transports/datatable', [ShopTransportController::class, 'datatable']);
    Route::post('/shop/transports/save', [ShopTransportController::class, 'save']);
    Route::get('/shop/transports/get/{id}', [ShopTransportController::class, 'get']);
    Route::delete('/shop/transports/delete/{id}', [ShopTransportController::class, 'destroy']);
    Route::get('/shop/transports/active', [ShopTransportController::class, 'active']);
    Route::get('/shop/transports/default', [ShopTransportController::class, 'default']);

    // shop shipping box
    Route::get('/shop/shipping-box/datatable', [ShopShippingBoxController::class, 'datatable']);
    Route::post('/shop/shipping-box/save', [ShopShippingBoxController::class, 'save']);
    Route::get('/shop/shipping-box/get/{id}', [ShopShippingBoxController::class, 'get']);
    Route::delete('/shop/shipping-box/delete/{id}', [ShopShippingBoxController::class, 'delete']);
    Route::get('/shop/shipping-box/active', [ShopShippingBoxController::class, 'active']);

    // delivery types
    Route::get('/deliveries/datatable', [DeliveryTypeController::class, 'datatable']);
    Route::post('/deliveries/save', [DeliveryTypeController::class, 'save']);
    Route::get('/deliveries/get/{id}', [DeliveryTypeController::class, 'get']);
    Route::post('/deliveries/delete/{id}', [DeliveryTypeController::class, 'delete']);
    Route::get('/deliveries/active', [DeliveryTypeController::class, 'active']);

    // delivery transport
    Route::get('/deliveries/transports/datatable', [DeliveryTransportController::class, 'datatable']);
    Route::post('/deliveries/transports/save', [DeliveryTransportController::class, 'save']);
    Route::get('/deliveries/transports/get/{id}', [DeliveryTransportController::class, 'get']);
    Route::delete('/deliveries/transports/delete/{id}', [DeliveryTransportController::class, 'destroy']);
    Route::get('/deliveries/transports/active', [DeliveryTransportController::class, 'active']);

    //brands
    Route::post('/brand/save', [BrandController::class, 'save']);
    Route::post('/brand/datatable', [BrandController::class, 'datatable']);
    Route::post('/brand/get', [BrandController::class, 'get']);
    Route::post('/brand/active', [BrandController::class, 'active']);
    Route::post('/brand/delete', [BrandController::class, 'delete']);

    //categories
    Route::post('/category/parent', [CategoryController::class, 'parent']);
    Route::post('/category/save', [CategoryController::class, 'save']);
    Route::post('/category/datatable', [CategoryController::class, 'datatable']);
    Route::post('/category/delete', [CategoryController::class, 'delete']);
    Route::post('/category/get', [CategoryController::class, 'get']);
    Route::post('/category/active', [CategoryController::class, 'active']);
    Route::post('/category/tax', [CategoryController::class, 'setCategoryTax']);

    //units
    Route::post('/unit/get', [UnitController::class, 'get']);
    Route::post('/unit/save', [UnitController::class, 'save']);
    Route::post('/unit/datatable', [UnitController::class, 'datatable']);
    Route::post('/unit/delete', [UnitController::class, 'delete']);
    Route::post('/unit/active', [UnitController::class, 'active']);

    //time units
    Route::post('/time-unit/get', [TimeUnitsController::class, 'get']);
    Route::post('/time-unit/save', [TimeUnitsController::class, 'save']);
    Route::post('/time-unit/datatable', [TimeUnitsController::class, 'datatable']);
    Route::post('/time-unit/delete', [TimeUnitsController::class, 'delete']);
    Route::post('/time-unit/active', [TimeUnitsController::class, 'active']);

    //products
    Route::post('/product/get', [ProductController::class, 'get']);
    Route::post('/product/save', [ProductController::class, 'save']);
    Route::post('/product/active', [ProductController::class, 'active']);
    Route::post('/product/datatable', [ProductController::class, 'datatable']);
    Route::post('/product/delete', [ProductController::class, 'delete']);
    Route::post('/product/comments', [ProductController::class, 'commentsDatatable']);
    Route::post('/product/comments/delete', [ProductController::class, 'commentsDelete']);
    Route::get('/product/export', [ProductController::class, 'export']);
    Route::get('/product/import', [ProductController::class, 'import']);

    //clients
    Route::post('/client/datatable', [ClientController::class, 'datatable']);
    Route::post('/client/delete', [ClientController::class, 'delete']);
    Route::post('/client/active', [ClientController::class, 'active']);
    Route::post('/client/save', [ClientController::class, 'save']);
    Route::get('/client/{id}/transactions', [TransactionController::class, 'clientTransaction']);

    //admin
    Route::post('/admin/datatable', [AdminController::class, 'datatable']);
    Route::post('/admin/delete', [AdminController::class, 'delete']);
    Route::post('/admin/save', [AdminController::class, 'save']);
    Route::post('/admin/get', [AdminController::class, 'get']);
    Route::post('/admin/delivery-boy/active', [AdminController::class, 'deliveryBoyActive']);
    Route::get('/admin/delivery-boys/{id}', [AdminController::class, 'deliveryBoyById']);
    Route::get('/admin/delivery-boys', [AdminController::class, 'deliveryBoys']);

    // balance
    Route::post('/users/balance/topup', [BalanceController::class, 'topUpUserBalance']);

    // create manager
    Route::post('/manager/activate', [AdminController::class, 'activate']);
    Route::post('/manager/datatable', [AdminController::class, 'managerDatatable']);
    Route::post('/manager/edit', [AdminController::class, 'managerEdit']);

    //addresses
    Route::post('/address/datatable', [AddressController::class, 'datatable']);
    Route::post('/address/delete', [AddressController::class, 'delete']);
    Route::post('/address/active', [AddressController::class, 'active']);
    Route::post('/address/save', [AddressController::class, 'save']);

    //roles
    Route::post('/role/active', [RolePermissionController::class, 'roles']);
    Route::post('/role/datatable', [RolePermissionController::class, 'datatable']);

    //permissions
    Route::post('/permission/datatable', [RolePermissionController::class, 'permissionDatatable']);
    Route::post('/permission/save', [RolePermissionController::class, 'save']);
    Route::post('/permission/savepermission', [RolePermissionController::class, 'savepermission']);
    Route::post('/permission/deletepermission', [RolePermissionController::class, 'deletepermission']);
    Route::post('/permission/getpermission', [RolePermissionController::class, 'getpermission']);

    //payments
    Route::post('/payment/method', [PaymentController::class, 'methodDatatable']);
    Route::post('/payment/method/active', [PaymentController::class, 'activeMethod']);
    Route::post('/payment/status', [PaymentController::class, 'statusDatatable']);
    Route::post('/payment/status/active', [PaymentController::class, 'activeStatus']);

    //orders
    Route::post('/order/status', [OrderController::class, 'statusDatatable']);
    Route::post('/order/status/active', [OrderController::class, 'activeStatus']);
    Route::post('/order/save', [OrderController::class, 'save']);
    Route::post('/order/get', [OrderController::class, 'get']);
    Route::post('/order/datatable', [OrderController::class, 'datatable']);
    Route::post('/order/delete', [OrderController::class, 'delete']);
    Route::post('/order/comments', [OrderController::class, 'commentsDatatable']);
    Route::post('/order/status/refund', [OrderController::class, 'refundOrderTransaction']);

    //banners
    Route::post('/banner/save', [BannerController::class, 'save']);
    Route::post('/banner/get', [BannerController::class, 'get']);
    Route::post('/banner/delete', [BannerController::class, 'delete']);
    Route::post('/banner/datatable', [BannerController::class, 'datatable']);

    //coupons
    Route::post('/coupon/save', [CouponController::class, 'save']);
    Route::post('/coupon/datatable', [CouponController::class, 'datatable']);
    Route::post('/coupon/delete', [CouponController::class, 'delete']);
    Route::post('/coupon/get', [CouponController::class, 'get']);

    //app settings
    Route::post('/app-language/datatable', [AppSettingsController::class, 'appLanguageDatatable']);
    Route::post('/app-language/datatableWord', [AppSettingsController::class, 'appLanguageDatatableWord']);
    Route::post('/app-language/save', [AppSettingsController::class, 'save']);

    //extra group
    Route::post('/extra-group/types', [ExtraGroupController::class, 'types']);
    Route::post('/extra-group/save', [ExtraGroupController::class, 'save']);
    Route::post('/extra-group/datatable', [ExtraGroupController::class, 'datatable']);
    Route::post('/extra-group/delete', [ExtraGroupController::class, 'delete']);
    Route::post('/extra-group/get', [ExtraGroupController::class, 'get']);
    Route::post('/extra-group/active', [ExtraGroupController::class, 'active']);

    //extra
    Route::post('/extra/save', [ExtraController::class, 'save']);
    Route::post('/extra/datatable', [ExtraController::class, 'datatable']);
    Route::post('/extra/delete', [ExtraController::class, 'delete']);
    Route::post('/extra/get', [ExtraController::class, 'get']);

    // shop categories
    Route::post('/shop-category/save', [ShopCategoriesController::class, 'save']);
    Route::post('/shop-category/datatable', [ShopCategoriesController::class, 'datatable']);
    Route::post('/shop-category/get', [ShopCategoriesController::class, 'get']);
    Route::post('/shop-category/active', [ShopCategoriesController::class, 'active']);
    Route::post('/shop-category/delete', [ShopCategoriesController::class, 'delete']);

    // currency
    Route::post('/currency/save', [CurrencyController::class, 'save']);
    Route::post('/currency/datatable', [CurrencyController::class, 'datatable']);
    Route::post('/currency/delete', [CurrencyController::class, 'delete']);
    Route::post('/currency/get', [CurrencyController::class, 'get']);
    Route::post('/currency/active', [CurrencyController::class, 'active']);
    Route::post('/currency/default', [CurrencyController::class, 'default']);

    // Shops Curriencies
    Route::post('/shops-currency/save', [ShopsCurrienciesController::class, 'save']);
    Route::post('/shops-currency/datatable', [ShopsCurrienciesController::class, 'datatable']);
    Route::post('/shops-currency/delete', [ShopsCurrienciesController::class, 'delete']);
    Route::post('/shops-currency/get', [ShopsCurrienciesController::class, 'get']);
    Route::post('/shops-currency/currency', [ShopsCurrienciesController::class, 'currency']);
    Route::post('/shops-currency/change', [ShopsCurrienciesController::class, 'change']);


    // notifications
    Route::post('/notification/save', [NotificationsController::class, 'save']);
    Route::post('/notification/datatable', [NotificationsController::class, 'datatable']);
    Route::post('/notification/delete', [NotificationsController::class, 'delete']);
    Route::post('/notification/get', [NotificationsController::class, 'get']);
    Route::post('/notification/send', [NotificationsController::class, 'sendNotification']);

    // products characterics
    Route::post('/products-characterics/save', [ProductsCharactericsController::class, 'save']);
    Route::post('/products-characterics/datatable', [ProductsCharactericsController::class, 'datatable']);
    Route::post('/products-characterics/delete', [ProductsCharactericsController::class, 'delete']);
    Route::post('/products-characterics/get', [ProductsCharactericsController::class, 'get']);

    // discount
    Route::post('/discount/save', [DiscountController::class, 'save']);
    Route::post('/discount/datatable', [DiscountController::class, 'datatable']);
    Route::post('/discount/delete', [DiscountController::class, 'delete']);
    Route::post('/discount/get', [DiscountController::class, 'get']);

    // brand categories
    Route::post('/brand-category/save', [BrandCategoriesController::class, 'save']);
    Route::post('/brand-category/datatable', [BrandCategoriesController::class, 'datatable']);
    Route::post('/brand-category/get', [BrandCategoriesController::class, 'get']);
    Route::post('/brand-category/active', [BrandCategoriesController::class, 'active']);
    Route::post('/brand-category/delete', [BrandCategoriesController::class, 'delete']);

    // payments
    Route::post('/payments/save', [PaymentsController::class, 'save']);
    Route::post('/payments/datatable', [PaymentsController::class, 'datatable']);
    Route::post('/payments/delete', [PaymentsController::class, 'delete']);
    Route::post('/payments/get', [PaymentsController::class, 'get']);
    Route::post('/payments/active', [PaymentsController::class, 'active']);
    Route::post('/payment/payment-system/payment', [BasePaymentController::class, 'payment']);

    // payments
    Route::post('/payments/attributes/save', [PaymentsController::class, 'paymentAttributesSave']);
    Route::get('/payments/attributes/get/{id}', [PaymentsController::class, 'paymentAttributesGet']);

    // shop payment
    Route::post('/shop-payment/save', [ShopPaymentController::class, 'save']);
    Route::post('/shop-payment/datatable', [ShopPaymentController::class, 'datatable']);
    Route::post('/shop-payment/delete', [ShopPaymentController::class, 'delete']);
    Route::post('/shop-payment/get', [ShopPaymentController::class, 'get']);
    Route::get('/shop-payment/active', [ShopPaymentController::class, 'active']);

    // media
    Route::post('/media/media', [MediaController::class, 'media']);
    Route::post('/media/delete', [MediaController::class, 'delete']);
    Route::post('/media/get', [MediaController::class, 'get']);

    //faq
    Route::post('/faq/save', [FaqController::class, 'save']);
    Route::post('/faq/datatable', [FaqController::class, 'datatable']);
    Route::post('/faq/get', [FaqController::class, 'get']);
    Route::post('/faq/delete', [FaqController::class, 'delete']);

    //about
    Route::post('/about/save', [AboutController::class, 'save']);
    Route::post('/about/datatable', [AboutController::class, 'datatable']);
    Route::post('/about/get', [AboutController::class, 'get']);

    //privacy
    Route::post('/privacy/save', [PrivacyController::class, 'save']);
    Route::post('/privacy/datatable', [PrivacyController::class, 'datatable']);
    Route::post('/privacy/get', [PrivacyController::class, 'get']);
    Route::post('/privacy/delete', [PrivacyController::class, 'delete']);

    //terms
    Route::post('/terms/save', [TermsController::class, 'save']);
    Route::post('/terms/datatable', [TermsController::class, 'datatable']);
    Route::post('/terms/get', [TermsController::class, 'get']);
    Route::post('/terms/delete', [TermsController::class, 'delete']);

    // admin notifications
    Route::post('/admin-notifications/datatable', [AdminNotificationsController::class, 'datatable']);
    Route::post('/admin-notifications/get', [AdminNotificationsController::class, 'get']);
    Route::post('/admin-notifications/delete', [AdminNotificationsController::class, 'delete']);

    //dashboard
    Route::post('/dashboard/client/total', [ClientController::class, 'getTotalClientsCount']);
    Route::post('/dashboard/client/active', [OrderController::class, 'getActiveClients']);
    Route::post('/dashboard/shops/total', [ShopsController::class, 'getTotalShopsCount']);
    Route::post('/dashboard/orders/total', [OrderController::class, 'getTotalOrdersCount']);
    Route::post('/dashboard/products/total', [ProductController::class, 'getTotalProductsCount']);
    Route::post('/dashboard/products/most-sold', [ProductController::class, 'getMostSoldProducts']);

    Route::post('/dashboard/orders/totalByStatus', [OrderController::class, 'getOrdersStaticByStatus']);
    Route::post('/dashboard/orders/totalByShops', [OrderController::class, 'getShopsSalesInfo']);

    //statistics
    Route::get('/statistics/server-info', [StatisticsController::class, 'serverInfo']);
    Route::get('/statistics/order-info', [StatisticsController::class, 'orderStatistics']);


    //chat
    Route::post('/chat/users', [MessageController::class, 'getChatUsers']);
    Route::post('/chat/message', [MessageController::class, 'getMessages']);
    Route::post('/chat/send', [MessageController::class, 'sendMessage']);

    //Phone prefix
    Route::post('/phone-prefix/save', [PhonePrefixController::class, 'save']);
    Route::post('/phone-prefix/datatable', [PhonePrefixController::class, 'datatable']);
    Route::post('/phone-prefix/get', [PhonePrefixController::class, 'get']);
    Route::post('/phone-prefix/delete', [PhonePrefixController::class, 'delete']);
    Route::post('/phone-prefix/active', [PhonePrefixController::class, 'active']);

    //tax
    Route::get('/taxes/datatable', [TaxController::class, 'datatable']);
    Route::post('/taxes/save', [TaxController::class, 'save']);
    Route::get('/taxes/get/{id}', [TaxController::class, 'get']);
    Route::delete('/taxes/delete/{id}', [TaxController::class, 'delete']);
    Route::get('/taxes/shop/{shop_id}/active', [TaxController::class, 'shopActiveTaxes']);
    Route::get('/taxes/shop/{shop_id}/default', [TaxController::class, 'shopDefaultTaxes']);

    //ticket
    Route::get('/tickets/datatable', [TicketController::class, 'datatable']);
    Route::post('/tickets/save', [TicketController::class, 'save']);
    Route::get('/tickets/get/{id}', [TicketController::class, 'get']);
    Route::delete('/tickets/delete/{id}', [TicketController::class, 'delete']);
    Route::post('/tickets/status/change/{id}', [TicketController::class, 'changeStatus']);
    Route::get('/tickets/properties', [TicketController::class, 'getTicketProperties']);

    //social
    Route::get('/socials/datatable', [SocialController::class, 'datatable']);
    Route::post('/socials/save', [SocialController::class, 'save']);
    Route::get('/socials/get/{id}', [SocialController::class, 'get']);
    Route::delete('/socials/delete/{id}', [SocialController::class, 'delete']);
    Route::get('/socials/active', [SocialController::class, 'active']);

    //shop social
    Route::get('/shop/socials/datatable', [ShopSocialController::class, 'datatable']);
    Route::post('/shop/socials/save', [ShopSocialController::class, 'save']);
    Route::get('/shop/socials/get/{id}', [ShopSocialController::class, 'get']);
    Route::delete('/shop/socials/delete/{id}', [ShopSocialController::class, 'delete']);
    Route::get('/shop/socials/active', [ShopSocialController::class, 'active']);


    //shipping box
    Route::get('/shipping-box/datatable', [ShippingBoxController::class, 'datatable']);
    Route::post('/shipping-box/save', [ShippingBoxController::class, 'save']);
    Route::get('/shipping-box/get/{id}', [ShippingBoxController::class, 'get']);
    Route::delete('/shipping-box/delete/{id}', [ShippingBoxController::class, 'delete']);
    Route::get('/shipping-box/active', [ShippingBoxController::class, 'active']);

    //point
    Route::get('/points/datatable', [PointController::class, 'datatable']);
    Route::post('/points/save', [PointController::class, 'save']);
    Route::get('/points/get/{id}', [PointController::class, 'get']);
    Route::delete('/points/delete/{id}', [PointController::class, 'delete']);
    Route::get('/points/active', [PointController::class, 'active']);
    Route::get('/points/rate/show', [PointController::class, 'pointRateShow']);
    Route::post('/points/rate/save', [PointController::class, 'pointRateSave']);

    // transactions
    Route::get('/transactions/datatable', [TransactionController::class, 'datatable']);

    // Auto updates
    Route::post('/project-upload', [UploadController::class, 'projectUpdate']);
    Route::post('/project-update', function() {
        try {
            Artisan::call('project:update');
            return response()->json(['status' => true, 'message' => 'Updated successfully done!']);
        } catch (Exception $exception){
            return response()->json(['status' => false, 'message' => $exception->getMessage()]);
        }
    });
});

Route::group(['middleware' => 'api', 'prefix' => 'auth'], function ($router) {
    // API's for activate or deactivate shop
    Route::post('/shops/deactivated/{uuid}', [ClientController::class, 'deactivateShop']);
    Route::post('/shops/activated/{uuid}', [ClientController::class, 'activateShop']);
});

// API's for mobile use
Route::group([
    'middleware' => 'api',
    'prefix' => 'm'
], function ($router) {
    Route::post('/upload', [UploadController::class, 'upload']);
    // clients
    Route::post('/client/signup', [Mobile\ClientController::class, 'signup']);
    Route::post('/client/update', [Mobile\ClientController::class, 'update']);
    Route::post('/client/reset', [Mobile\ClientController::class, 'reset']);
    Route::post('/client/login', [Mobile\ClientController::class, 'login']);
    Route::post('/client/save-push', [Mobile\ClientController::class, 'savePushToken']);
    Route::post('/client/find/shops', [RouteController::class, 'findNearbyShops']);

    // brands
    Route::post('/brand/get', [Mobile\BrandsController::class, 'get']);
    Route::post('/brand/products', [Mobile\BrandsController::class, 'products']);
    Route::post('/brand/categories', [Mobile\BrandsController::class, 'categories']);

    // categories
    Route::post('/category/products', [Mobile\CategoriesController::class, 'products']);
    Route::post('/category/categories', [Mobile\CategoriesController::class, 'categories']);

    // product
    Route::post('/product/extra', [Mobile\ProductController::class, 'extraData']);
    Route::post('/product/coupon', [Mobile\CouponController::class, 'coupon']);
    Route::post('/product/discount', [Mobile\DiscountController::class, 'discount']);

    // product comments
    Route::post('/product/comments', [Mobile\ProductController::class, 'comments']);

    // order comments
    Route::post('/order/comments', [Mobile\OrderController::class, 'commentCreate']);
    Route::post('/order/save', [Mobile\OrderController::class, 'save']);
    Route::post('/order/history', [Mobile\OrderController::class, 'allOrderByStatus']);
    Route::post('/order/count', [Mobile\OrderController::class, 'getNewOrderCount']);
    Route::post('/order/cancel', [Mobile\OrderController::class, 'orderCancel']);
    Route::post('/order/checkout', [Mobile\OrderController::class, 'checkout']);

    //coupons
    Route::post('/coupon/check', [CouponController::class, 'getByName']);

    // shops currencies
    Route::post('/currency/currency', [Mobile\CurrencyController::class, 'active']);

    // shops
    Route::post('/shops/timeunits', [Mobile\ShopsController::class, 'timeunits']);
    Route::post('/shops/balance/payments', [Mobile\ShopsController::class, 'getPaymentsForBalanceTopup']);
    Route::post('/shops/user', [Mobile\ShopsController::class, 'getShopUser']);
    Route::get('/shops/categories', [Mobile\ShopsController::class, 'categories']);
    Route::post('/shops/shops', [Mobile\ShopsController::class, 'shops']);
    Route::post('/shops/shipping-box/active', [Mobile\ShopsController::class, 'shopShippingBox']);
    Route::post('/shops/{id}', [Mobile\ShopsController::class, 'getShopById']);

    // language
    Route::post('/language/active', [Mobile\LanguageController::class, 'active']);
    Route::post('/language/language', [Mobile\LanguageController::class, 'language']);

    // banner
    Route::post('/banner/banners', [Mobile\BannerController::class, 'banners']);
    Route::post('/banner/products', [Mobile\BannerController::class, 'products']);

    // notifications
    Route::post('/notification/notifications', [Mobile\NotificationsController::class, 'notifications']);

    // faq
    Route::post('/faq/faq', [Mobile\FaqController::class, 'faq']);

    // about
    Route::post('/about/about', [Mobile\AboutController::class, 'about']);
    Route::post('/privacy/privacy', [Mobile\PrivacyContoller::class, 'privacy']);
    Route::post('/terms/terms', [Mobile\TermsController::class, 'terms']);

    //chat
    Route::post('/chat/dialog', [MessageController::class, 'dialog']);
    Route::post('/chat/send', [MessageController::class, 'sendMessage']);

    //delivery boy
    Route::post('/deliveryboy/login', [AdminController::class, 'deliveryBoyLogin']);
    Route::post('/deliveryboy/order', [OrderController::class, 'getDeliveryBoyOrder']);
    Route::post('/deliveryboy/statistics', [OrderController::class, 'getDeliveryBoyStatistics']);
    Route::post('/deliveryboy/changeStatus', [OrderController::class, 'changeStatus']);
    Route::post('/deliveryboy/update', [AdminController::class, 'updateDeliveryBoy']);
    Route::get('/deliveryboy/balance/{id}', [AdminController::class, 'deliveryBoyById']);
    Route::post('/deliveryboy/offline-status', [AdminController::class, 'setOfflineStatus']);
    Route::post('/deliveryboy/payout/history', [OrderController::class, 'getDeliveryBoyPayoutHistory']);

    Route::post('/order/delivery/route', [RouteController::class, 'setDeliveryRoute']);
    Route::post('/order/delivery/length', [RouteController::class, 'getDeliveryRouteLength']);

    //ticket
    Route::post('/tickets/save', [Mobile\TicketController::class, 'createTicket']);
    Route::get('/tickets/get/{id}', [Mobile\TicketController::class, 'getTicket']);

    Route::match(['POST','GET'],'/admin/live/tracking', [RouteController::class, 'adminLiveTracking']);

    // Payment Links
    Route::post('/payment-system/payment', [BasePaymentController::class, 'payment']);
    Route::post('/payment-system/seerafa/payment', [SeerafaController::class, 'payment']);

});



