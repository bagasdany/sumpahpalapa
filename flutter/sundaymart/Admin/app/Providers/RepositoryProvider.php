<?php

namespace App\Providers;

use App\Repositories\AboutRepository;
use App\Repositories\AddressRepository;
use App\Repositories\AdminRepository;
use App\Repositories\AppSettingsRepository;
use App\Repositories\BalanceRepository;
use App\Repositories\BannerRepository;
use App\Repositories\BrandCategoryRepository;
use App\Repositories\BrandRepository;
use App\Repositories\CategoryRepository;
use App\Repositories\ClientRepository;
use App\Repositories\CouponRepository;
use App\Repositories\CurrencyRepository;
use App\Repositories\DeliveryRepository;
use App\Repositories\DeliveryTransportRepository;
use App\Repositories\DiscountRepository;
use App\Repositories\ExtraGroupRepository;
use App\Repositories\ExtraRepository;
use App\Repositories\FaqRepository;
use App\Repositories\Interfaces\AboutInterface;
use App\Repositories\Interfaces\AddressInterface;
use App\Repositories\Interfaces\AdminInterface;
use App\Repositories\Interfaces\AppSettingsInterface;
use App\Repositories\Interfaces\BalanceRepoInterface;
use App\Repositories\Interfaces\BannerInterface;
use App\Repositories\Interfaces\BrandCategoryInterface;
use App\Repositories\Interfaces\BrandInterface;
use App\Repositories\Interfaces\CategoryInterface;
use App\Repositories\Interfaces\ClientInterface;
use App\Repositories\Interfaces\CouponInterface;
use App\Repositories\Interfaces\CurrencyInterface;
use App\Repositories\Interfaces\DeliveryInterface;
use App\Repositories\Interfaces\DeliveryTransportRepoInterface;
use App\Repositories\Interfaces\DiscountInterface;
use App\Repositories\Interfaces\ExtraGroupInterface;
use App\Repositories\Interfaces\ExtraInterface;
use App\Repositories\Interfaces\FaqInterface;
use App\Repositories\Interfaces\LanguageInterface;
use App\Repositories\Interfaces\NotificationInterface;
use App\Repositories\Interfaces\OpenRouteInterface;
use App\Repositories\Interfaces\OrderInterface;
use App\Repositories\Interfaces\Payment\FlutterwaveInterface;
use App\Repositories\Interfaces\Payment\PaypalInterface;
use App\Repositories\Interfaces\Payment\PaystackRepoInterface;
use App\Repositories\Interfaces\Payment\RazorpayInterface;
use App\Repositories\Interfaces\Payment\SeerafaInterface;
use App\Repositories\Interfaces\Payment\StripeInterface;
use App\Repositories\Interfaces\PaymentInterface;
use App\Repositories\Interfaces\PhonePrefixInterface;
use App\Repositories\Interfaces\PointInterface;
use App\Repositories\Interfaces\PrivacyInterface;
use App\Repositories\Interfaces\ProductCharactericsInterface;
use App\Repositories\Interfaces\ProductInterface;
use App\Repositories\Interfaces\RolePermissionInterface;
use App\Repositories\Interfaces\ShippingBoxRepoInterface;
use App\Repositories\Interfaces\ShopCategoryInterface;
use App\Repositories\Interfaces\ShopCurrencyInterface;
use App\Repositories\Interfaces\ShopDeliveryInterface;
use App\Repositories\Interfaces\ShopInterface;
use App\Repositories\Interfaces\ShopPaymentInterface;
use App\Repositories\Interfaces\ShopShippingBoxRepoInterface;
use App\Repositories\Interfaces\ShopTransportRepoInterface;
use App\Repositories\Interfaces\TaxRepoInterface;
use App\Repositories\Interfaces\TermsInterface;
use App\Repositories\Interfaces\TicketRepoInterface;
use App\Repositories\Interfaces\TimeUnitInterface;
use App\Repositories\Interfaces\TransactionInterface;
use App\Repositories\Interfaces\UnitInterface;
use App\Repositories\LanguageRepository;
use App\Repositories\NotificationRepository;
use App\Repositories\OpenRouteRepository;
use App\Repositories\OrderRepository;
use App\Repositories\Payment\FlutterwaveRepository;
use App\Repositories\Payment\PaypalRepository;
use App\Repositories\Payment\PaystackRepository;
use App\Repositories\Payment\RazorpayRepository;
use App\Repositories\Payment\SeerafaRepository;
use App\Repositories\Payment\StripeRepository;
use App\Repositories\PaymentRepository;
use App\Repositories\PhonePrefixRepository;
use App\Repositories\PointRepository;
use App\Repositories\PrivacyRepository;
use App\Repositories\ProductCharactericsRepository;
use App\Repositories\ProductRepository;
use App\Repositories\RolePermissionRepository;
use App\Repositories\ShippingBoxRepository;
use App\Repositories\ShopCategoryRepository;
use App\Repositories\ShopCurrencyRepository;
use App\Repositories\ShopDeliveryRepository;
use App\Repositories\ShopPaymentRepository;
use App\Repositories\ShopRepository;
use App\Repositories\ShopShippingBoxRepository;
use App\Repositories\ShopTransportRepository;
use App\Repositories\TaxRepository;
use App\Repositories\TermsRepository;
use App\Repositories\TicketRepository;
use App\Repositories\TimeUnitRepository;
use App\Repositories\TransactionRepository;
use App\Repositories\UnitRepository;
use Illuminate\Support\ServiceProvider;

class RepositoryProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(StripeInterface::class, StripeRepository::class);
        $this->app->bind(DiscountInterface::class, DiscountRepository::class);
        $this->app->bind(AboutInterface::class, AboutRepository::class);
        $this->app->bind(ShopInterface::class, ShopRepository::class);
        $this->app->bind(FaqInterface::class, FaqRepository::class);
        $this->app->bind(OrderInterface::class, OrderRepository::class);
        $this->app->bind(BrandInterface::class, BrandRepository::class);
        $this->app->bind(BannerInterface::class, BannerRepository::class);
        $this->app->bind(CategoryInterface::class, CategoryRepository::class);
        $this->app->bind(ClientInterface::class, ClientRepository::class);
        $this->app->bind(CouponInterface::class, CouponRepository::class);
        $this->app->bind(CurrencyInterface::class, CurrencyRepository::class);
        $this->app->bind(LanguageInterface::class, LanguageRepository::class);
        $this->app->bind(NotificationInterface::class, NotificationRepository::class);
        $this->app->bind(ProductInterface::class, ProductRepository::class);
        $this->app->bind(ShopCategoryInterface::class, ShopCategoryRepository::class);
        $this->app->bind(BrandCategoryInterface::class, BrandCategoryRepository::class);
        $this->app->bind(AddressInterface::class, AddressRepository::class);
        $this->app->bind(AdminInterface::class, AdminRepository::class);
        $this->app->bind(AppSettingsInterface::class, AppSettingsRepository::class);
        $this->app->bind(ExtraInterface::class, ExtraRepository::class);
        $this->app->bind(ExtraGroupInterface::class, ExtraGroupRepository::class);
        $this->app->bind(PaymentInterface::class, PaymentRepository::class);
        $this->app->bind(PrivacyInterface::class, PrivacyRepository::class);
        $this->app->bind(TermsInterface::class, TermsRepository::class);
        $this->app->bind(ProductCharactericsInterface::class, ProductCharactericsRepository::class);
        $this->app->bind(RolePermissionInterface::class, RolePermissionRepository::class);
        $this->app->bind(ShopPaymentInterface::class, ShopPaymentRepository::class);
        $this->app->bind(TimeUnitInterface::class, TimeUnitRepository::class);
        $this->app->bind(UnitInterface::class, UnitRepository::class);
        $this->app->bind(ShopCurrencyInterface::class, ShopCurrencyRepository::class);
        $this->app->bind(PhonePrefixInterface::class, PhonePrefixRepository::class);
        $this->app->bind(OpenRouteInterface::class, OpenRouteRepository::class);
        $this->app->bind(ShopDeliveryInterface::class, ShopDeliveryRepository::class);
        $this->app->bind(TransactionInterface::class, TransactionRepository::class);
        $this->app->bind(DeliveryInterface::class, DeliveryRepository::class);
        $this->app->bind(TaxRepoInterface::class, TaxRepository::class);
        $this->app->bind(DeliveryTransportRepoInterface::class, DeliveryTransportRepository::class);
        $this->app->bind(ShopTransportRepoInterface::class, ShopTransportRepository::class);
        $this->app->bind(ShippingBoxRepoInterface::class, ShippingBoxRepository::class);
        $this->app->bind(ShopShippingBoxRepoInterface::class, ShopShippingBoxRepository::class);
        $this->app->bind(BalanceRepoInterface::class, BalanceRepository::class);
        $this->app->bind(TicketRepoInterface::class, TicketRepository::class);
        $this->app->bind(PointInterface::class, PointRepository::class);

        // Payment System
        $this->app->bind(PaystackRepoInterface::class, PaystackRepository::class);
        $this->app->bind(FlutterwaveInterface::class, FlutterwaveRepository::class);
        $this->app->bind(RazorpayInterface::class, RazorpayRepository::class);
        $this->app->bind(SeerafaInterface::class, SeerafaRepository::class);
        $this->app->bind(PaypalInterface::class, PaypalRepository::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
