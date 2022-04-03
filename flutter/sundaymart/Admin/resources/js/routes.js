import React from "react";
import { AuthProvider } from "./helpers/AuthProvider";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import { PrivateRouteProvider } from "./helpers/RouteProvider";
import Dashboard from "./pages/Dashboard";
import Shops from "./pages/Shops/Shops";
import ShopAdd from "./pages/Shops/ShopAdd";
import Brands from "./pages/Brands/Brands";
import BrandAdd from "./pages/Brands/BrandAdd";
import Categories from "./pages/Categories/Categories";
import CategoryAdd from "./pages/Categories/CategoryAdd";
import CouponAdd from "./pages/Coupons/CouponAdd";
import Products from "./pages/Products/Products/Products";
import ProductAdd from "./pages/Products/Products/ProductAdd";
import Extras from "./pages/Products/Extras/Extras";
import ProductsComments from "./pages/Products/Comments/ProductsComments";
import Languages from "./pages/Languages/Languages";
import LanguageAdd from "./pages/Languages/LanguageAdd";
import Units from "./pages/Units/Units";
import UnitAdd from "./pages/Units/UnitAdd";
import TimeUnits from "./pages/TimeUnits/TimeUnits";
import TimeUnitAdd from "./pages/TimeUnits/TimeUnitAdd";
import Login from "./pages/Login";
import Client from "./pages/Users/Clients/Client";
import Address from "./pages/Users/Addresses/Address";
import Admin from "./pages/Users/Admins/Admin";
import AdminAdd from "./pages/Users/Admins/AdminAdd";
import Role from "./pages/Users/Roles/Role";
import Permission from "./pages/Users/Permissions/Permission";
import PaymentMethod from "./pages/Payments/Methods/PaymentMethod";
import PaymentStatus from "./pages/Payments/Statuses/PaymentStatus";
import OrderStatus from "./pages/Orders/Statuses/OrderStatus";
import Banners from "./pages/Banners/Banners";
import BannerAdd from "./pages/Banners/BannerAdd";
import Coupon from "./pages/Coupons/Coupon";
import NotFound from "./pages/NotFound";
import AppLanguage from "./pages/AppSettings/AppLanguages/AppLanguage";
import Order from "./pages/Orders/Orders/Order";
import OrderAdd from "./pages/Orders/Orders/OrderAdd";
import AddressAdd from "./pages/Users/Addresses/AddressAdd";
import OrderComment from "./pages/Orders/Comments/OrderComment";
import AppLanguageAdd from "./pages/AppSettings/AppLanguages/AppLanguageAdd";
import ShopCategories from "./pages/ShopCategories/ShopCategories";
import ShopCategoryAdd from "./pages/ShopCategories/ShopCategoryAdd";
import Currency from "./pages/Currencies/Currency";
import CurrencyAdd from "./pages/Currencies/CurrencyAdd";
import ShopCurrency from "./pages/ShopCurriencies/ShopCurrency";
import ShopCurrencyAdd from "./pages/ShopCurriencies/ShopCurrencyAdd";
import Notification from "./pages/Notifications/Notification";
import NotificationAdd from "./pages/Notifications/NotificationAdd";
import SignUp from "./pages/SignUp/SignUp";
import BrandsCategories from "./pages/BrandsCategories/BrandsCategories";
import BrandsCategoriesAdd from "./pages/BrandsCategories/BrandsCategoriesAdd";
import Discounts from "./pages/Discounts/Discounts";
import DiscountAdd from "./pages/Discounts/DiscountAdd";
import Medias from "./pages/Medias/Medias";
import Payments from "./pages/Payments/Payments/Payments";
import PaymentsAdd from "./pages/Payments/Payments/PaymentsAdd";
import ShopPayments from "./pages/ShopPayments/ShopPayments";
import ShopPaymentsAdd from "./pages/ShopPayments/ShopPaymentsAdd";
import Faq from "./pages/Faq/Faq";
import FaqAdd from "./pages/Faq/FaqAdd";
import PermissionAdd from "./pages/Users/Permissions/PermissionAdd";
import AboutAdd from "./pages/About/AboutAdd";
import About from "./pages/About/About";
import Chat from "./pages/Chat/Chat";
import PhonePrefix from "./pages/PhonePrefix/PhonePrefix";
import PhonePrefixAdd from "./pages/PhonePrefix/PhonePrefixAdd";
import ManagerRequests from "./pages/Users/Admins/ManagerRequests";
import DeliveryBoyList from "./pages/DeliveryBoy/DeliveryBoyList/DeliveryBoyList";
import DeliveryBoyMap from "./pages/DeliveryBoy/DeliveryMap/DeliveryMap";
import ShopDeliveriesType from "./pages/ShopDeliveriesType/ShopDeliveriesType";
import ShopDeliveriesTypeAdd from "./pages/ShopDeliveriesType/ShopDeliveriesTypeAdd";
import Terms from "./pages/Terms/Terms";
import Privacy from "./pages/Privacy/Privacy";
import PrivacyAdd from "./pages/Privacy/PrivacyAdd";
import TermsAdd from "./pages/Terms/TermsAdd";
import DeliveryOrsersStatus from "./pages/DeliveryBoy/DeliveryOrdersStatus/DeliveryOrdersStatus";
import PosSystem from "./pages/PosSystem/PosSystem";
import Taxes from "./pages/Tax/Taxes";
import TaxAdd from "./pages/Tax/TaxAdd";
import CategoryTaxes from "./pages/CategoryTaxes/CategoryTaxes";
import AddCategoryTax from "./pages/CategoryTaxes/CategoryTaxAdd";
import ShippingTransport from "./pages/ShippingTransport/ShippingTransport";
import ShippingTransportAdd from "./pages/ShippingTransport/ShippingTransportAdd";
import ShippingBox from "./pages/ShippingBox/ShippingBox";
import ShippingBoxAdd from "./pages/ShippingBox/ShippingBoxAdd";
import ClientsAdd from "./pages/Users/Clients/ClientAdd";
import Licence from "./pages/Licence";
import ProductImport from "./pages/Products/Products/ProductImport";
import ProductExport from "./pages/Products/Products/ProductExport";
import Transactions from "./pages/Transactions/Transactions";
import ServerInfo from "./pages/ServerInfo/ServerInfo";
import ServerUpdate from "./pages/ServerUpdate/ServerUpdate";

const Routes = () => {
    return (
        <AuthProvider>
            <Router>
                <Switch>
                    <PrivateRouteProvider path="/" exact={true}>
                        <Dashboard />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops" exact={true}>
                        <Shops />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops/add">
                        <ShopAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/shipping-transports"
                        exact={true}
                    >
                        <ShippingTransport />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shipping-transports/add">
                        <ShippingTransportAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shipping-transports/edit">
                        <ShippingTransportAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shipping-box" exact={true}>
                        <ShippingBox />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shipping-box/add">
                        <ShippingBoxAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shipping-box/edit">
                        <ShippingBoxAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/taxes" exact={true}>
                        <Taxes />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/category-taxes" exact={true}>
                        <CategoryTaxes />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/category-taxes/add"
                        exact={true}
                    >
                        <AddCategoryTax />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/category-taxes/edit"
                        exact={true}
                    >
                        <AddCategoryTax />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/taxes/add">
                        <TaxAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/taxes/edit">
                        <TaxAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops/edit">
                        <ShopAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/brands" exact={true}>
                        <Brands />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/brands/add">
                        <BrandAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/brands/edit">
                        <BrandAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/categories" exact={true}>
                        <Categories />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/categories/add">
                        <CategoryAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/categories/edit">
                        <CategoryAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/coupons" exact={true}>
                        <Coupon />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/coupons/add">
                        <CouponAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/coupons/edit">
                        <CouponAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/products" exact={true}>
                        <Products />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/products/add">
                        <ProductAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/products/edit">
                        <ProductAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/import">
                        <ProductImport />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/export">
                        <ProductExport />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/extras" exact={true}>
                        <Extras />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/extras/add">
                        <ProductAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/extras/edit">
                        <ProductAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/product-comments" exact={true}>
                        <ProductsComments />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/delivery-boy" exact={true}>
                        <DeliveryBoyList />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/delivery-orders-status"
                        exact={true}
                    >
                        <DeliveryOrsersStatus />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/delivery-map" exact={true}>
                        <DeliveryBoyMap />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/languages" exact={true}>
                        <Languages />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/languages/add">
                        <LanguageAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/languages/edit">
                        <LanguageAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/units" exact={true}>
                        <Units />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/units/add">
                        <UnitAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/units/edit">
                        <UnitAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/time-units" exact={true}>
                        <TimeUnits />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/time-units/add">
                        <TimeUnitAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/time-units/edit">
                        <TimeUnitAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/clients" exact={true}>
                        <Client />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/clients/add">
                        <ClientsAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/client-addresses" exact={true}>
                        <Address />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/client-addresses/add"
                    >
                        <AddressAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/admins" exact={true}>
                        <Admin />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/admins/add">
                        <AdminAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/admins/edit">
                        <AdminAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/roles" exact={true}>
                        <Role />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/permissions" exact={true}>
                        <Permission />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/permissions/add">
                        <PermissionAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/payment-methods" exact={true}>
                        <PaymentMethod />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/payment-statuses" exact={true}>
                        <PaymentStatus />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/order-statuses" exact={true}>
                        <OrderStatus />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/banners" exact={true}>
                        <Banners />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/banners/add">
                        <BannerAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/banners/edit">
                        <BannerAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/app-language" exact={true}>
                        <AppLanguage />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/app-language/edit">
                        <AppLanguageAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/transactions" exact={true}>
                        <Transactions />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/orders" exact={true}>
                        <Order />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/orders/add">
                        <OrderAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/orders/edit">
                        <OrderAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/order-comments" exact={true}>
                        <OrderComment />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-categories" exact={true}>
                        <ShopCategories />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-categories/add">
                        <ShopCategoryAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-categories/edit">
                        <ShopCategoryAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/currencies" exact={true}>
                        <Currency />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/currencies/add">
                        <CurrencyAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/currencies/edit">
                        <CurrencyAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-currencies" exact={true}>
                        <ShopCurrency />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-currencies/add">
                        <ShopCurrencyAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-currencies/edit">
                        <ShopCurrencyAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/notifications" exact={true}>
                        <Notification />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/notifications/add">
                        <NotificationAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/notifications/edit">
                        <NotificationAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/discounts" exact={true}>
                        <Discounts />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/discounts/add">
                        <DiscountAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/discounts/edit">
                        <DiscountAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/brands-categories"
                        exact={true}
                    >
                        <BrandsCategories />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/brands-categories/add">
                        <BrandsCategoriesAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/brands-categories/edit">
                        <BrandsCategoriesAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/medias">
                        <Medias />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/payments" exact={true}>
                        <Payments />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/payments/add">
                        <PaymentsAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/payments/edit">
                        <PaymentsAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-payments" exact={true}>
                        <ShopPayments />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-payments/add">
                        <ShopPaymentsAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-payments/edit">
                        <ShopPaymentsAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/faq" exact={true}>
                        <Faq />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/faq/add">
                        <FaqAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/faq/edit">
                        <FaqAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/about" exact={true}>
                        <About />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/about/edit">
                        <AboutAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/chat" exact={true}>
                        <Chat />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/phone-prefix" exact={true}>
                        <PhonePrefix />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/phone-prefix/add">
                        <PhonePrefixAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/phone-prefix/edit">
                        <PhonePrefixAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/manager-requests">
                        <ManagerRequests />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider
                        path="/shops-delivery-type"
                        exact={true}
                    >
                        <ShopDeliveriesType />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-delivery-type/add">
                        <ShopDeliveriesTypeAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/shops-delivery-type/edit">
                        <ShopDeliveriesTypeAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/terms" exact={true}>
                        <Terms />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/terms/edit">
                        <TermsAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/privacy" exact={true}>
                        <Privacy />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/pos-system" exact={true}>
                        <PosSystem />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/privacy/edit">
                        <PrivacyAdd />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/server" exact={true}>
                        <ServerInfo />
                    </PrivateRouteProvider>
                    <PrivateRouteProvider path="/update">
                        <ServerUpdate />
                    </PrivateRouteProvider>
                    <Route path="/login">
                        <Login />
                    </Route>
                    <Route path="/licence">
                        <Licence />
                    </Route>
                    <Route path="/sign-up">
                        <SignUp />
                    </Route>
                    <Route>
                        <NotFound />
                    </Route>
                </Switch>
            </Router>
        </AuthProvider>
    );
};

export default Routes;
