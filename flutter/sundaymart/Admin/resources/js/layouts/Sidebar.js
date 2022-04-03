import React, {useEffect, useState} from "react";
import {Layout, Menu} from "antd";
import {
    PieChartOutlined,
    AppstoreAddOutlined,
    ShopOutlined,
    SettingOutlined,
    ShoppingCartOutlined,
    GoldOutlined,
    AppstoreOutlined,
    GlobalOutlined,
    GiftOutlined,
    UsergroupAddOutlined,
    PayCircleOutlined,
    PictureOutlined,
    MobileOutlined,
    NotificationOutlined,
    PercentageOutlined,
    PushpinOutlined,
    LaptopOutlined, HistoryOutlined,DatabaseFilled
} from "@ant-design/icons";
import {useLocation} from "react-router-dom";
import {Link} from "react-router-dom";
import {isAllowed} from "../helpers/IsAllowed";
import {useTranslation} from "react-i18next";
import {RiEBike2Line} from "react-icons/ri";
import {HiOutlineReceiptTax} from "react-icons/hi";

const {Sider} = Layout;
const {SubMenu} = Menu;

const Sidebar = (props) => {
    const {t} = useTranslation();

    const [collapsed, setCollapse] = useState(false);
    const location = useLocation();
    const path = location.pathname.split("/");

    const handleWindowResize = () => {
        if (window.innerWidth <= 900) {
            setCollapse(true);
        } else {
            setCollapse(false);
        }
    };

    useEffect(() => {
        handleWindowResize();
        window.addEventListener("resize", handleWindowResize);
        return () => window.removeEventListener("resize", handleWindowResize);
    }, []);

    return (
        <Sider
            theme="light"
            collapsible
            collapsed={collapsed}
            onCollapse={() => {
                setCollapse(!collapsed);
            }}
        >
            <div className="logo"/>
            <Menu
                theme="light"
                defaultSelectedKeys={["/" + path[1]]}
                defaultOpenKeys={[path[1]]}
                mode="inline"
            >
                {isAllowed("/") && (
                    <Menu.Item key="/" icon={<PieChartOutlined/>}>
                        <Link to="/" className="nav-text">
                            {t("dashboard")}
                        </Link>
                    </Menu.Item>
                )}
                {(isAllowed("/shops") ||
                    isAllowed("/shops-categories") ||
                    isAllowed("/shops-currencies") ||
                    isAllowed("/shops-delivery-type") ||
                    isAllowed("/shops-payments")) && (
                    <SubMenu
                        key={
                            [
                                "shops",
                                "shops-categories",
                                "shops-currencies",
                                "shops-delivery-type",
                                "shops-payments",
                            ].includes(path[1])
                                ? path[1]
                                : "shops"
                        }
                        icon={<ShopOutlined/>}
                        title={t("shops")}
                    >
                        {isAllowed("/shops") && (
                            <Menu.Item key="/shops">
                                <Link to="/shops" className="nav-text">
                                    {t("shops")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/shops-categories") && (
                            <Menu.Item key="/shops-categories">
                                <Link
                                    to="/shops-categories"
                                    className="nav-text"
                                >
                                    {t("shop_categories")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/shops-currencies") && (
                            <Menu.Item key="/shops-currencies">
                                <Link
                                    to="/shops-currencies"
                                    className="nav-text"
                                >
                                    {t("shop_currencies")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/shops-payments") && (
                            <Menu.Item key="/shops-payments">
                                <Link to="/shops-payments" className="nav-text">
                                    {t("shop_payments")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/shops-delivery-type") && (
                            <Menu.Item key="/shops-delivery-type">
                                <Link
                                    to="/shops-delivery-type"
                                    className="nav-text"
                                >
                                    {t("shop_deliveries_type")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {(isAllowed("/brands") || isAllowed("/brands-categories")) && (
                    <SubMenu
                        key={
                            ["brands", "brands-categories"].includes(path[1])
                                ? path[1]
                                : "brands"
                        }
                        icon={<AppstoreAddOutlined/>}
                        title={t("brands")}
                    >
                        {isAllowed("/brands") && (
                            <Menu.Item key="/brands">
                                <Link to="/brands" className="nav-text">
                                    {t("brands")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/brands-categories") && (
                            <Menu.Item key="/brands-categories">
                                <Link
                                    to="/brands-categories"
                                    className="nav-text"
                                >
                                    {t("brands_categories")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {isAllowed("/pos-system") && (
                    <Menu.Item key="/pos-system" icon={<LaptopOutlined/>}>
                        <Link to="/pos-system" className="nav-text">
                            {t("pos")}
                        </Link>
                    </Menu.Item>
                )}
                {isAllowed("/taxes") && (
                    <Menu.Item key="/taxes" icon={<HiOutlineReceiptTax/>}>
                        <Link to="/taxes" className="nav-text">
                            {t("tax")}
                        </Link>
                    </Menu.Item>
                )}
                {isAllowed("/categories") && (
                    <Menu.Item key="/categories" icon={<AppstoreOutlined/>}>
                        <Link to="/categories" className="nav-text">
                            {t("product_categories")}
                        </Link>
                    </Menu.Item>
                )}
                {(isAllowed("/products") || isAllowed("/product-comments")
                    || isAllowed("/import") || isAllowed("/export")) && (
                    <SubMenu
                        key={
                            ["products", "product-comments", "import", "export"].includes(path[1])
                                ? path[1]
                                : "products"
                        }
                        icon={<GoldOutlined/>}
                        title={t("products")}
                    >
                        {isAllowed("/products") && (
                            <Menu.Item key="/products">
                                <Link to="/products" className="nav-text">
                                    {t("products")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/product-comments") && (
                            <Menu.Item key="/product-comments">
                                <Link
                                    to="/product-comments"
                                    className="nav-text"
                                >
                                    {t("products_comments")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/export") && (
                            <Menu.Item key="/export">
                                <Link to="/export" className="nav-text">
                                    {t("bulk_export")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/import") && (
                            <Menu.Item key="/import">
                                <Link to="/import" className="nav-text">
                                    {t("bulk_upload")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {(isAllowed("/delivery-boy") ||
                    isAllowed("/delivery-map") ||
                    isAllowed("/delivery-orders-status")) && (
                    <SubMenu
                        key={
                            [
                                "delivery-boy",
                                "delivery-map",
                                "delivery-orders-status",
                            ].includes(path[1])
                                ? path[1]
                                : "delivery-boy"
                        }
                        icon={<RiEBike2Line/>}
                        title={t("delivery_boy")}
                    >
                        {isAllowed("/delivery-boy") && (
                            <Menu.Item key="/delivery-boy">
                                <Link to="/delivery-boy" className="nav-text">
                                    {t("delivery_boy")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/delivery-map") && (
                            <Menu.Item key="/delivery-map">
                                <Link to="/delivery-map" className="nav-text">
                                    {t("delivery_map")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/delivery-orders-status") && (
                            <Menu.Item key="/delivery-orders-status">
                                <Link
                                    to="/delivery-orders-status"
                                    className="nav-text"
                                >
                                    {t("delivery_order_statuses")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {isAllowed("/discounts") && (
                    <Menu.Item key="/discounts" icon={<PercentageOutlined/>}>
                        <Link to="/discounts" className="nav-text">
                            {t("discounts")}
                        </Link>
                    </Menu.Item>
                )}
                {(isAllowed("/orders") ||
                    isAllowed("/order-statuses") ||
                    isAllowed("/order-comments")) && (
                    <SubMenu
                        key={
                            [
                                "orders",
                                "order-statuses",
                                "order-comments",
                            ].includes(path[1])
                                ? path[1]
                                : "orders"
                        }
                        icon={<ShoppingCartOutlined/>}
                        title={t("orders")}
                    >
                        {isAllowed("/orders") && (
                            <Menu.Item key="/orders">
                                <Link to="/orders" className="nav-text">
                                    {t("orders")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/order-statuses") && (
                            <Menu.Item key="/order-statuses">
                                <Link to="/order-statuses" className="nav-text">
                                    {t("order_statuses")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/order-comments") && (
                            <Menu.Item key="/order-comments">
                                <Link to="/order-comments" className="nav-text">
                                    {t("order_comments")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {isAllowed("/transactions") && (
                    <Menu.Item key="/transactions" icon={<HistoryOutlined/>}>
                        <Link to="/transactions" className="nav-text">
                            {t("transactions")}
                        </Link>
                    </Menu.Item>
                )}
                {(isAllowed("/payment-statuses")) && (
                    <SubMenu
                        key={
                            [
                                "payment-statuses",
                            ].includes(path[1])
                                ? path[1]
                                : "payment-methods"
                        }
                        icon={<PayCircleOutlined/>}
                        title={t("payments")}
                    >
                        {isAllowed("/payment-statuses") && (
                            <Menu.Item key="/payment-statuses">
                                <Link
                                    to="/payment-statuses"
                                    className="nav-text"
                                >
                                    {t("payment_statuses")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {isAllowed("/coupons") && (
                    <Menu.Item key="/coupons" icon={<GiftOutlined/>}>
                        <Link to="/coupons" className="nav-text">
                            {t("coupons")}
                        </Link>
                    </Menu.Item>
                )}
                {isAllowed("/banners") && (
                    <Menu.Item key="/banners" icon={<PictureOutlined/>}>
                        <Link to="/banners" className="nav-text">
                            {t("banners")}
                        </Link>
                    </Menu.Item>
                )}
                {isAllowed("/notifications") && (
                    <Menu.Item
                        key="/notifications"
                        icon={<NotificationOutlined/>}
                    >
                        <Link to="/notifications" className="nav-text">
                            {t("notifications")}
                        </Link>
                    </Menu.Item>
                )}
                {isAllowed("/languages") && (
                    <Menu.Item key="/languages" icon={<GlobalOutlined/>}>
                        <Link to="/languages" className="nav-text">
                            {t("languages")}
                        </Link>
                    </Menu.Item>
                )}
                {(isAllowed("/units") ||
                    isAllowed("/time-units") ||
                    isAllowed("/shipping-transports") ||
                    isAllowed("/shipping-box") ||
                    isAllowed("/currencies")) && (
                    <SubMenu
                        key={
                            [
                                "units",
                                "time-units",
                                "currencies",
                                "phone-prefix",
                                "shipping-transports",
                                "shipping-box",
                            ].includes(path[1])
                                ? path[1]
                                : "units"
                        }
                        icon={<SettingOutlined/>}
                        title={t("settings")}
                    >
                        {isAllowed("/units") && (
                            <Menu.Item key="/units">
                                <Link to="/units" className="nav-text">
                                    {t("units")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/shipping-transports") && (
                            <Menu.Item key="/shipping-transports">
                                <Link
                                    to="/shipping-transports"
                                    className="nav-text"
                                >
                                    {t("shipping_transports")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/shipping-box") && (
                            <Menu.Item key="/shipping-box">
                                <Link to="/shipping-box" className="nav-text">
                                    {t("shipping_box")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/currencies") && (
                            <Menu.Item key="/currencies">
                                <Link to="/currencies" className="nav-text">
                                    {t("currencies")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/time-units") && (
                            <Menu.Item key="/time-units">
                                <Link to="/time-units" className="nav-text">
                                    {t("time_units")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/phone-prefix") && (
                            <Menu.Item key="/phone-prefix">
                                <Link to="/phone-prefix" className="nav-text">
                                    {t("phone_prefix")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {(isAllowed("/clients") ||
                    isAllowed("/admins") ||
                    isAllowed("/roles") ||
                    isAllowed("/client-addresses") ||
                    isAllowed("/permissions")) && (
                    <SubMenu
                        key={
                            [
                                "clients",
                                "admins",
                                "roles",
                                "client-addresses",
                                "permissions",
                                "manager-requests",
                            ].includes(path[1])
                                ? path[1]
                                : "admins"
                        }
                        icon={<UsergroupAddOutlined/>}
                        title={t("users")}
                    >
                        {isAllowed("/clients") && (
                            <Menu.Item key="/clients">
                                <Link to="/clients" className="nav-text">
                                    {t("clients")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/client-addresses") && (
                            <Menu.Item key="/client-addresses">
                                <Link
                                    to="/client-addresses"
                                    className="nav-text"
                                >
                                    {t("client_addresses")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/admins") && (
                            <Menu.Item key="/admins">
                                <Link to="/admins" className="nav-text">
                                    {t("admins")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/manager-requests") && (
                            <Menu.Item key="/manager-requests">
                                <Link
                                    to="/manager-requests"
                                    className="nav-text"
                                >
                                    {t("manager_requests")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/roles") && (
                            <Menu.Item key="/roles">
                                <Link to="/roles" className="nav-text">
                                    {t("roles")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/permissions") && (
                            <Menu.Item key="/permissions">
                                <Link to="/permissions" className="nav-text">
                                    {t("permissions")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
                {isAllowed("/app-language") && (
                    <SubMenu
                        key={
                            ["app-language"].includes(path[1])
                                ? path[1]
                                : "app-language"
                        }
                        icon={<MobileOutlined/>}
                        title={t("app_settings")}
                    >
                        <Menu.Item key="/app-language">
                            <Link to="/app-language" className="nav-text">
                                {t("app_languages")}
                            </Link>
                        </Menu.Item>
                    </SubMenu>
                )}
                {(isAllowed("/faq") ||
                    isAllowed("/about") ||
                    isAllowed("/terms") ||
                    isAllowed("/privacy")) && (
                    <SubMenu
                        key={
                            ["faq", "about", "terms", "privacy"].includes(
                                path[1]
                            )
                                ? path[1]
                                : "faq"
                        }
                        icon={<PushpinOutlined/>}
                        title={t("page_settings")}
                    >
                        {isAllowed("/faq") && (
                            <Menu.Item key="/faq">
                                <Link to="/faq" className="nav-text">
                                    {t("faq")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/about") && (
                            <Menu.Item key="/about">
                                <Link to="/about" className="nav-text">
                                    {t("about")}
                                </Link>
                            </Menu.Item>
                        )}
                        <Menu.Item key="/terms">
                            <Link to="/terms" className="nav-text">
                                {t("terms_of_condition")}
                            </Link>
                        </Menu.Item>
                        <Menu.Item key="/privacy">
                            <Link to="/privacy" className="nav-text">
                                {t("privacy")}
                            </Link>
                        </Menu.Item>
                    </SubMenu>
                )}
                {isAllowed("/medias") && (
                    <Menu.Item key="/medias" icon={<PictureOutlined/>}>
                        <Link to="/medias" className="nav-text">
                            {t("media")}
                        </Link>
                    </Menu.Item>
                )}
                {(isAllowed("/server") ||
                    isAllowed("/update")) && (
                    <SubMenu
                        key={
                            ["server", "update",].includes(
                                path[1]
                            )
                                ? path[1]
                                : "server"
                        }
                        icon={<DatabaseFilled/>}
                        title={t("page_settings")}
                    >
                        {isAllowed("/server") && (
                            <Menu.Item key="/server">
                                <Link to="/server" className="nav-text">
                                    {t("server_info")}
                                </Link>
                            </Menu.Item>
                        )}
                        {isAllowed("/update") && (
                            <Menu.Item key="/update">
                                <Link to="/update" className="nav-text">
                                    {t("server_update")}
                                </Link>
                            </Menu.Item>
                        )}
                    </SubMenu>
                )}
            </Menu>
        </Sider>
    );
};

export default Sidebar;
