import React, {useEffect, useMemo, useRef, useState} from "react";
import {Row, Col, Button, Layout, Spin, message} from "antd";

const {Footer, Content} = Layout;
import Sidebar from "../../layouts/Sidebar";
import ChatButton from "../../layouts/ChatButton";

import {useTranslation} from "react-i18next";
import CustomCard from "./components/ProductCard";
import Cart from "./components/Cart";
import Filter from "./components/Filter";
import Tabs from "./components/Tabs";
import OrderSummary from "./components/OrderSummary";
import AddUser from "./components/AddUser";
import ShippingAddress from "./components/ShippingAddress";
import DeliveryTime from "./components/DeliveryTime";
import ExtraProduct from "./components/ExtraProduct";
import SuccessDialog from "./components/SuccessDialog";
import reqwest from "reqwest";
import getActiveShipping from "../../requests/Shops/GetActiveShopping";
import getActiveDeliveryTransport from "../../requests/Shops/GetDeliveryTransport";
import timeUnitActive from "../../requests/TimeUnits/TimeUnitActive";
import addressActive from "../../requests/Address/AddressActive";
import orderSave from "../../requests/Orders/OrderSave";
import DeliveryType from "./components/DeliveryType";
import clientActive from "../../requests/Clients/ClientActive";
import {IMAGE_PATH, IS_DEMO} from "../../global";
import getActiveShippingBox from "../../requests/ShippingBox/ShippingBoxActive";

const PosSystem = () => {
    const {t} = useTranslation();
    const [userOpen, setUserOpen] = useState(false);
    const [productTotal, setProductTotal] = useState(0);
    const [search, setSearch] = useState("");
    const [pageIndex, setPageIndex] = useState(1);
    const [pageSize, setPageSize] = useState(12);
    const [shop, setShop] = useState(undefined);
    const [category, setCategory] = useState(undefined);
    const [brand, setBrand] = useState(undefined);

    const [deliveryTypeOpen, setDeliveryTypeOpen] = useState(false);
    const [deliveryOpen, setDeliveryOpen] = useState(false);
    const [shippingOpen, setShippingOpen] = useState(false);
    const [productOpen, setProductOpen] = useState(false);
    const [orderSummaryOpen, setOrderSummaryOpen] = useState(false);
    const [loading, setLoading] = useState(false);
    const [isOrderSuccess, setIsOrderSuccess] = useState(false);
    const [successData, setSuccessData] = useState({});
    const [orderId, setOrderId] = useState(0);

    const [userOptions, setUserOptions] = useState([]);
    const [brandOptions, setBrandOptions] = useState([]);
    const [shippings, setShippings] = useState([]);
    const [categoryOptions, setCategoryOptions] = useState([]);
    const [timeUnit, setTimeUnit] = useState([]);
    const [shopOptions, setShopOptions] = useState([]);
    const [products, setProducts] = useState([]);
    const [clients, setClients] = useState([]);
    const [addresses, setAddresses] = useState([]);
    const [bags, setBags] = useState([1]);
    const [bagIndex, setBagIndex] = useState(0);
    const [extrasData, setExtrasData] = useState([]);
    const [selectedProduct, setSelectedProduct] = useState(undefined);
    const [deliveryType, setDeliveryType] = useState([]);
    const [shippingBox, setShippingBox] = useState([]);
    const [delivery, setDelivery] = useState({});
    const [cart, setCart] = useState([
        {
            products: [],
            total: 0,
            tax: 0,
            discount: 0,
            delivery_fee: 0,
            user: undefined,
            deliveryTime: undefined,
            address: undefined,
            deliveryDate: undefined,
            shippingId: undefined,
            shopId: undefined,
            shop_tax: 0
        },
    ]);

    const [total, setTotal] = useState(0);
    const [user, setUser] = useState(undefined);
    const [address, setAddress] = useState(undefined);

    const categoryQuery = useMemo(
        () => (category ? `&category_id=${category}` : ""),
        [category]
    );

    const shopQuery = useMemo(() => (shop ? `&shop_id=${shop}` : ""), [shop]);
    const brandQuery = useMemo(
        () => (brand ? `&brand_id=${brand}` : ""),
        [brand]
    );

    const pageSizeQuery = useMemo(
        () => (pageSize ? `&length=${pageSize}` : ""),
        [pageSize]
    );

    const pageQuery = useMemo(() => `start=${pageIndex}`, [pageIndex, search]);

    const query = useMemo(
        () =>
            `${pageQuery}${pageSizeQuery}${categoryQuery}${shopQuery}${brandQuery}`,
        [pageQuery, pageSizeQuery, categoryQuery, brandQuery, shopQuery]
    );

    useEffect(() => {
        fetchShops();
        fetchUsers();
        getActiveClient();
    }, []);

    useEffect(() => {
        if (shop)
            fetch({
                current: 1,
                pageSize: 12,
                query: query,
            });
    }, [query]);

    const fetchShops = () => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/shop/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            setShopOptions(data.data);
            setShop(data.data[0].id);
            setBagIndex(0);
            const newData = [...cart];
            newData[0].products = [];
            newData[0].total = 0;
            newData[0].shopId = data.data[0].id;
            setCart(newData);

            setProducts([]);
            setProductTotal(0);
            getShipping(data.data[0].id);
            getDeliveryType(data.data[0].id);
            getDeliveryBox(data.data[0].id);
            fetchCategories(data.data[0].id);
            fetchBrands(data.data[0].id);
            getActiveTimeUnits(data.data[0].id);
        });
    };

    const fetchCategories = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/category/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                shop_id: id,
            },
        }).then((data) => {
            setCategoryOptions(data.data);
        });
    };

    const fetchBrands = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/brand/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                shop_id: id,
            },
        }).then((data) => {
            setBrandOptions(data.data);
        });
    };
    const fetchUsers = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: " /api/auth/client/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            setUserOptions(data.data);
        });
    };

    const fetch = (params = {}) => {
        setLoading(true);
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url:
                "/api/auth/product/datatable" +
                `?${params?.query ? params?.query : ""}${
                    params?.search ? `&search=${params?.search}` : ""
                }${`&active=${1}`}`,
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            setLoading(false);
            const newData = data.data.map((item) => ({
                ...item,
                image_url: IMAGE_PATH + item.image_url,
            }));
            setProducts(products.concat(newData));
            setProductTotal(data.total);
        });
    };

    const getShipping = async (id) => {
        let data = await getActiveShipping(id);
        if (data.data.data.length > 0) {
            const newData = data.data?.data.map((item) => ({
                ...item,
                name: item.delivery_type?.name,
            }));
            setShippings(newData);
        } else {
            setShippings([]);
        }
    };
    const getDeliveryType = async (id) => {
        let data = await getActiveDeliveryTransport(id);
        if (data.data.data.length > 0) {
            const newData = data.data?.data.map((item) => ({
                ...item,
                name: item?.delivery_transport?.name,
            }));

            setDeliveryType(newData);
        } else {
            setDeliveryType([]);
        }
    };

    const getDeliveryBox = async (id) => {
        let data = await getActiveShippingBox(id);
        if (data.data.data.length > 0) {
            const newData = data.data?.data.map((item) => ({
                ...item,
                name: item?.shipping_box?.name,
            }));

            setShippingBox(newData);
        } else {
            setShippingBox([]);
        }
    };

    const getActiveAddress = async (client_id) => {
        let data = await addressActive(client_id);
        if (data.data.success == 1 && data.data.data.length > 0) {
            setAddresses(data.data.data);
            setAddress(data.data.data[0]);
        }
    };
    const getActiveClient = async () => {
        let data = await clientActive();
        setClients(data.data.data);
    };

    const onChangeShop = (e) => {
        const newData = [...cart];
        if (!newData[bagIndex].shopId) {
            newData[bagIndex].shopId = e;
            setCart(newData);
        } else {
            newData[bagIndex].products = [];
            newData[bagIndex].total = 0;
            newData[bagIndex].shopId = e;
            setCart(newData);
        }
        setProducts([]);
        setProductTotal(0);
        setShop(e);
        getShipping(e);
        getDeliveryType(e);
        getDeliveryBox(e);
        fetchCategories(e);
        fetchBrands(e);
        getActiveTimeUnits(e);
        setBrand(undefined);
        setCategory(undefined);
    };

    const onChangeCategory = (e) => {
        setCategory(e);
    };

    const onChangeBrand = (e) => {
        setBrand(e);
    };

    const setShopTax = (amount) => {
        if (cart[bagIndex].shopId) {
            var index = shopOptions.findIndex((item) => item['id'] == shop);
            if (index > -1) {
                var tax = shopOptions[index].taxes.reduce(
                    (previousValue, currentValue) =>
                        previousValue + currentValue?.percent,
                    0
                );
                var shopTax = ((amount * tax) / 100).toFixed(2);
                cart[bagIndex].shop_tax = shopTax;
            }
        }
    }

    const onChangeSearch = (event) => {
        setSearch(event);
    };

    const addProduct = (e) => {
        if (cart[bagIndex].shopId) {
            if (cart[bagIndex].products.some((item) => item.id === e.id)) {
                const newData = cart[bagIndex].products.map((item) => {
                    const taxes = item.taxes.reduce(
                        (cal, val) => cal + val.percent,
                        0
                    );

                    if (item.id === e.id) {
                        return {
                            ...item,
                            qty: (item.qty += 1),
                            tax: ((taxes * (item.price_with_extras * 1 - item.discount * 1)) / 100).toFixed(2),
                        };
                    } else {
                        return {
                            ...item,
                            tax: ((taxes * (item.price_with_extras * 1 - item.discount * 1)) / 100).toFixed(2),
                        };
                    }
                });
                const total = newData.reduce(
                    (cal, val) => cal + val.price_with_extras * val.qty,
                    0
                );
                const tax = newData.reduce((cal, val) => cal + val.tax * val.qty, 0);

                const discountTotal = newData.reduce(
                    (cal, val) => cal + val.discount * val.qty,
                    0
                );

                const data = [...cart];
                setShopTax((total * 1 - discountTotal * 1));
                data[bagIndex].tax = (tax * 1).toFixed(2);
                data[bagIndex].discount = (discountTotal * 1).toFixed(2);
                data[bagIndex].total = (total * 1 + tax * 1 - discountTotal * 1).toFixed(2);
                data[bagIndex].products = newData;

                setCart(data);
            } else {
                const taxes = e.taxes.reduce(
                    (cal, val) => cal + val.percent,
                    0
                );

                const discount = e.actual_discount == null ? 0 : e.actual_discount.discount_type === 0
                    ? 0
                    : e.actual_discount.discount_type === 1
                        ? (e.actual_discount.discount_amount * e.price) / 100
                        : e.actual_discount.discount_amount;

                var price = e.extras != null ? calculatePriceWithExtras(e, e.extras) : e.price;

                const data = {
                    ...e,
                    qty: 1,
                    price_with_extras: price,
                    discount: discount.toFixed(2),
                    tax: ((taxes * (price - discount)) / 100).toFixed(2),
                };
                const newData = [...cart];
                newData[bagIndex].products.push(data);

                const total = newData[bagIndex].products.reduce(
                    (cal, val) => cal + val.price_with_extras * val.qty,
                    0
                );

                const tax = newData[bagIndex].products.reduce(
                    (cal, val) => cal + val.tax * val.qty,
                    0
                );

                const discountTotal = newData[bagIndex].products.reduce(
                    (cal, val) => cal + val.discount * val.qty,
                    0
                );

                setShopTax((total * 1 - discountTotal * 1));
                newData[bagIndex].tax = (tax * 1).toFixed(2);
                newData[bagIndex].discount = (discountTotal * 1).toFixed(2);
                newData[bagIndex].total = (total * 1 + tax * 1 - discountTotal * 1).toFixed(2);
                setCart(newData);
            }
        } else {
            message.warn("Please select shop!");
        }
    };

    const calculatePriceWithExtras = (product, extras) => {
        return (product.price * 1 + extras.reduce(
            (previousValue, currentValue) =>
                previousValue + currentValue?.price,
            0
        ) * 1).toFixed(2);
    }

    const addProductWithExtrass = (extrasData) => {
        if (cart[bagIndex].shopId) {
            if (
                cart[bagIndex].products.some(
                    (item) => item.id === selectedProduct?.id
                )
            ) {
                const newData = cart[bagIndex].products.map((item) => {
                    if (item.id === selectedProduct.id) {
                        return {
                            ...item,
                            price_with_extras: calculatePriceWithExtras(item, extrasData),
                            qty: item.qty,
                            price: item.price,
                            extras: extrasData,
                        };
                    } else {
                        return item;
                    }
                });

                const total = newData.reduce(
                    (cal, val) => cal + val.price_with_extras * val.qty,
                    0
                );

                const tax = newData.reduce(
                    (cal, val) => cal + val.tax * val.qty,
                    0
                );

                const discountTotal = newData.reduce(
                    (cal, val) => cal + val.discount * val.qty,
                    0
                );

                setShopTax((total * 1 - discountTotal * 1));
                const data = [...cart];
                data[bagIndex].tax = (tax * 1).toFixed(2);
                data[bagIndex].discount = (discountTotal * 1).toFixed(2);
                data[bagIndex].total = (total * 1 + tax * 1 - discountTotal * 1).toFixed(2);
                data[bagIndex].products = newData;
                setCart(data);
            } else {
                const taxes = selectedProduct.taxes.reduce(
                    (cal, val) => cal + val.percent,
                    0
                );

                const discount = selectedProduct.actual_discount == null ? 0 : selectedProduct.actual_discount.discount_type === 0
                    ? 0
                    : selectedProduct.actual_discount.discount_type === 1
                        ? (selectedProduct.actual_discount.discount_amount * selectedProduct.price) / 100
                        : selectedProduct.actual_discount.discount_amount;

                var price = selectedProduct.extras != null ? calculatePriceWithExtras(selectedProduct, extrasData) : selectedProduct.price;

                const data = {
                    ...selectedProduct,
                    qty: 1,
                    extras: extrasData,
                    price_with_extras: price,
                    price: selectedProduct?.price,
                    discount: discount.toFixed(2),
                    tax: ((taxes * (price - discount)) / 100).toFixed(2),
                };

                const newData = [...cart];
                newData[bagIndex].products.push(data);

                const total = newData[bagIndex].products.reduce(
                    (cal, val) => cal + val.price_with_extras * val.qty,
                    0
                );

                const tax = newData[bagIndex].products.reduce(
                    (cal, val) => cal + val.tax * val.qty,
                    0
                );

                const discountTotal = newData[bagIndex].products.reduce(
                    (cal, val) => cal + val.discount * val.qty,
                    0
                );

                setShopTax((total * 1 - discountTotal * 1));
                newData[bagIndex].tax = (tax * 1).toFixed(2);
                newData[bagIndex].discount = (discountTotal * 1).toFixed(2);
                newData[bagIndex].total = (total * 1 + tax * 1 - discountTotal * 1).toFixed(2);
                setCart(newData);
            }
        } else {
            message.warn("Please select shop!");
        }
    };

    const viewMore = (page) => {
        setPageIndex((prev) => prev + 1);
    };

    const handleClose = () => {
        setUserOpen(false);
        fetchUsers();
    };

    const getExtrasData = (itm) => {
        setSelectedProduct(itm);
        setLoading(true);
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/product/get" + `?id=${itm?.id}`,
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            setProductOpen(true);
            const newData = data.data.extras.map((item) => ({
                ...item,
                extras: item.extras.map((itm) => ({
                    ...itm,
                    image_url: IMAGE_PATH + itm.image_url,
                })),
            }));
            // console.log(newData);

            setExtrasData(newData);

            setLoading(false);
        });
    };

    const getActiveTimeUnits = async (id) => {
        let data = await timeUnitActive(id);
        if (data.data.success == 1 && data.data.data.length > 0) {
            setTimeUnit(data.data.data);
        }
    };

    const onChangeUser = (e) => {
        setUser(e);
        const newData = [...cart];
        newData[bagIndex].user = e;

        getActiveAddress(e.id);

        setCart(newData);
    };

    const onFinish = async () => {
        // if (IS_DEMO) {
        //     message.warn("You cannot save in demo mode");
        //     return;
        // }
        setLoading(true);
        const newProducts = cart.map((cart) => ({
            total: (cart.total + cart.delivery_fee),
            product_details: cart.products.map((item) => ({
                ...item,
                quantity: item.qty
            })),
            delivery_time_id: cart.deliveryTime,
            delivery_date: cart.deliveryDate != null ? (cart.deliveryDate.getFullYear() + "-" + (cart.deliveryDate.getMonth() + 1) + "-" + cart.deliveryDate.getDay()) : "",
            total_discount: cart.discount,
            delivery_boy: null,
            delivery_boy_comment: "",
            order_status: 1,
            payment_method: 1,
            payment_status: 1,
            tax: cart.tax,
            shop_tax: cart.shop_tax,
            ...delivery,
        }));

        const params = cart.map((cart) => ({
            client: cart.user?.id,
            address: cart.address?.id,
            shop: cart.shopId,
            delivery_time: cart.deliveryTime,
            shipping_id: cart.shippingId,
            order_status: 1,
            delivery_type: delivery.type,
            payment_method: 4,
            delivery_boy: null
        }));

        let data = await orderSave(params[bagIndex], newProducts[bagIndex], null);

        if (data.data.success == 1) {
            setLoading(false);
            if(data.data.data.missed_products != null) {
                message.warn(t("out_of_stock"));
                return;
            }

            const saveData = cart[bagIndex];
            setIsOrderSuccess(true);
            setSuccessData(saveData);
            setOrderId(data.data.data.id);

            cart[bagIndex] = {
                products: [],
                total: 0,
                tax: 0,
                discount: 0,
                delivery_fee: 0,
                user: undefined,
                deliveryTime: undefined,
                address: undefined,
                deliveryDate: undefined,
                shippingId: undefined,
                shopId: undefined,
                shop_tax: 0
            };
            setAddress(undefined);
            setUser(undefined);
            setTotal(0);
            setShop(undefined);
            setBrand(undefined);
            setCategory(undefined);
            setOrderSummaryOpen(false);
        }
    };

    const clearBags = () => {
        setBagIndex(0);
        setBags([1]);
        setCart([
            {
                products: [],
                total: 0,
                tax: 0,
                delivery_fee: 0,
                user: undefined,
                deliveryTime: undefined,
                address: undefined,
                deliveryDate: undefined,
                shippingId: undefined,
                shopId: undefined,
                shop_tax: 0,
            },
        ]);
    };

    const handleChangeBadge = (idx) => {
        setBagIndex(idx);
        setShop(cart[idx].shopId);
        setProducts([]);
    };

    const handleDeliveryData = (value) => {
        const newData = [...cart];
        newData[bagIndex].delivery_fee = value?.delivery_fee;

        setDelivery(value);
    };

    return (
        <>
            <Layout
                style={{
                    minHeight: "100vh",
                    position: "relative",
                }}
            >
                <Sidebar/>
                <Layout className="site-layout">
                    <Content style={{margin: "16px"}}>
                        <Spin
                            size="large"
                            style={{
                                width: "100%",
                                height: "100%",
                            }}
                            spinning={loading}
                            wrapperClassName="d-flex flex-row justify-content-center align-items-center"
                        >
                            <Row gutter={20} style={{width: '100%'}}>
                                <Col span={16}>
                                    <Filter
                                        search={search}
                                        setSearch={onChangeSearch}
                                        shop={cart[bagIndex].shopId}
                                        setShop={onChangeShop}
                                        brand={brand}
                                        setBrand={onChangeBrand}
                                        category={category}
                                        setCategory={onChangeCategory}
                                        brandOptions={brandOptions}
                                        categoryOptions={categoryOptions}
                                        shopOptions={shopOptions}
                                        setCart={clearBags}
                                    />
                                    <CustomCard
                                        products={products}
                                        showMore={viewMore}
                                        addProduct={addProduct}
                                        extrasData={getExtrasData}
                                        handleOpen={getExtrasData}
                                    />
                                </Col>
                                <Col
                                    className="d-flex flex-column align-items-end"
                                    span={8}
                                    style={{
                                        borderRadius: 12,
                                    }}
                                >
                                    <Tabs
                                        setUserOpen={setUserOpen}
                                        cart={cart}
                                        setCart={setCart}
                                        bagIndex={bagIndex}
                                        setBagIndex={setBagIndex}
                                        shippingAddress={setShippingOpen}
                                        onChangeUser={onChangeUser}
                                        addresses={addresses}
                                        userOptions={userOptions}
                                        disable={!shop}
                                        bags={bags}
                                        handleChangeBadge={handleChangeBadge}
                                        setBags={setBags}
                                        setDeliveryTypeOpen={
                                            setDeliveryTypeOpen
                                        }
                                        setDeliveryOpen={setDeliveryOpen}
                                    />
                                    <Cart
                                        disable={
                                            false
                                        }
                                        setCart={setCart}
                                        setShopTax={setShopTax}
                                        cart={cart}
                                        bagIndex={bagIndex}
                                        total={cart[bagIndex].total}
                                        setTotal={setTotal}
                                        placeOrder={() => {
                                            if (!cart[bagIndex].user) {
                                                message.warn(t("select_user"));
                                                return false;
                                            } else if (!cart[bagIndex].address) {
                                                message.warn(t("select_address"));
                                                return false;
                                            } else if (!cart[bagIndex].deliveryDate) {
                                                message.warn(t("select_delivery_date"));
                                                return false;
                                            } else if (!cart[bagIndex].deliveryTime) {
                                                message.warn(t("select_delivery_time"));
                                                return false;
                                            } else if (cart[bagIndex].products.length == 0) {
                                                message.warn(t("select_products"));
                                                return false;
                                            } else if (delivery.type == null) {
                                                message.warn(t("select_delivery_type"));
                                                return false;
                                            }

                                            setOrderSummaryOpen(true);
                                        }}
                                    />
                                </Col>
                            </Row>
                        </Spin>
                    </Content>
                    <ChatButton/>
                </Layout>

                <AddUser
                    open={userOpen}
                    close={handleClose}
                    outSideClick={() => setUserOpen(false)}
                />
                <DeliveryType
                    shippings={shippings}
                    shippingBoxData={shippingBox}
                    deliveryTypeOptions={deliveryType}
                    open={deliveryTypeOpen}
                    close={() => setDeliveryTypeOpen(false)}
                    outSideClick={() => setDeliveryTypeOpen(false)}
                    handleSave={(value) => {
                        handleDeliveryData(value);
                        setDeliveryTypeOpen(false);
                    }}
                />
                <ShippingAddress
                    open={shippingOpen}
                    clients={clients}
                    close={() => setShippingOpen(false)}
                    outSideClick={() => setShippingOpen(false)}
                />
                <DeliveryTime
                    setCart={setCart}
                    cart={cart}
                    bagIndex={bagIndex}
                    open={deliveryOpen}
                    timeUnit={timeUnit}
                    outSideClick={() => setDeliveryOpen(false)}
                    close={() => setDeliveryOpen(false)}
                />
                <ExtraProduct
                    addExtras={(e) => addProductWithExtrass(e)}
                    open={productOpen}
                    extrasData={extrasData}
                    close={() => setProductOpen(false)}
                    outSideClick={() => setProductOpen(false)}
                />
                <SuccessDialog
                    isOrderSuccess={isOrderSuccess}
                    setIsOrderSuccess={setIsOrderSuccess}
                    datas={successData}
                    orderId={orderId}
                    delivery={delivery}
                />
                <OrderSummary
                    setCart={setCart}
                    cart={cart}
                    bagIndex={bagIndex}
                    onFinish={onFinish}
                    disable={
                        !cart[bagIndex].user ||
                        // !cart[bagIndex].shippingId ||
                        !cart[bagIndex].address ||
                        !cart[bagIndex].deliveryDate ||
                        !cart[bagIndex].deliveryTime
                    }
                    open={orderSummaryOpen}
                    outSideClick={() => setOrderSummaryOpen(false)}
                    close={() => setOrderSummaryOpen(false)}
                />
            </Layout>
        </>
    );
};

export default PosSystem;
