import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout,
    message,
    Modal,
    PageHeader,
    Radio,
    Select,
    Spin,
    Upload,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import shopActive from "../../requests/Shops/ShopActive";
import currencyActive from "../../requests/Currencies/CurrencyActive";
import shopsCurrencyDefault from "../../requests/ShopCurrencies/ShopsCurrencyDefault";
import shopsCurrencySave from "../../requests/ShopCurrencies/ShopsCurrencySave";
import shopsCurrencyGet from "../../requests/ShopCurrencies/ShopsCurrencyGet";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";

const { Content } = Layout;
const { Option } = Select;

class ShopCurrencyAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            shops: [],
            currencies: [],
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.onChangeLanguage = this.onChangeLanguage.bind(this);

        this.getActiveShops();
        this.getActiveCurrencies();

        if (this.state.edit) this.getInfoById(this.state.id);
    }

    // getDefaultCurrency = async (id_shop) => {
    //     let data = await shopsCurrencyDefault(id_shop);
    //     console.log(data);
    //     if (data.data.success == 1) {
    //         this.setState({
    //             defaultCurrency: data.data.data,
    //         });
    //     }
    // };

    getActiveShops = async () => {
        let data = await shopActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                shops: data.data.data,
            });

            //this.getDefaultCurrency(data.data.data[0].id);

            this.formRef.current.setFieldsValue({
                shop: data.data.data[0].id,
            });
        }
    };

    getActiveCurrencies = async () => {
        let data = await currencyActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                currencies: data.data.data,
            });

            // this.formRef.current.setFieldsValue({
            //     currency:
            //         this.state.defaultCurrency != null &&
            //         this.state.defaultCurrency.id != data.data.data[0].id
            //             ? data.data.data[0].id
            //             : data.data.data[1].id,
            // });
        }
    };

    getInfoById = async (id) => {
        let data = await shopsCurrencyGet(id);
        if (data.data.success) {
            let shopCurrency = data.data.data;

            this.formRef.current.setFieldsValue({
                value: shopCurrency.value,
                currency: shopCurrency.id_currency,
                shop: shopCurrency.id_shop,
            });
        }
    };

    onChangeLanguage = (e) => {
        let lang = e.target.value;
        this.setState({
            language: lang,
        });

        this.formRef.current.setFieldsValue({
            name: this.state.names[lang],
        });
    };

    onChangeShop = (e) => {
        //this.getDefaultCurrency(e);
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        var index = this.state.currencies.findIndex((cur) => cur.id == values.currency);
        console.log(this.state.currencies[index]);

        let data = await shopsCurrencySave(
            values.shop,
            values.currency,
            this.state.currencies[index].default,
            this.state.currencies[index].rate,
            this.state.id
        );

        if (data.data.success == 1) window.history.back();
    };

    onFinishFailed = (errorInfo) => {};

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/shops-currencies" className="nav-text">
                            {t("shop_currencies")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={
                        this.state.edit
                            ? t("shop_currency_edit")
                            : t("shop_currency_add")
                    }
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.shops.length > 0 ? (
                            <Form
                                ref={this.formRef}
                                name="basic"
                                initialValues={{}}
                                layout="vertical"
                                onFinish={this.onFinish}
                                onFinishFailed={this.onFinishFailed}
                            >
                                <div className="row">
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("shop")}
                                            name="shop"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t("missing_shop"),
                                                },
                                            ]}
                                            tooltip={t("select_shop")}
                                        >
                                            <Select
                                                placeholder={t("select_shop")}
                                                onChange={this.onChangeShop}
                                            >
                                                {this.state.shops.map(
                                                    (item) => {
                                                        return (
                                                            <Option
                                                                value={item.id}
                                                                key={item.id}
                                                            >
                                                                {item.name}
                                                            </Option>
                                                        );
                                                    }
                                                )}
                                            </Select>
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("currency")}
                                            name="currency"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t("missing_currency"),
                                                },
                                            ]}
                                            tooltip={t("select_currency")}
                                        >
                                            <Select
                                                placeholder={t(
                                                    "select_currency"
                                                )}
                                            >
                                                {this.state.currencies.map(
                                                    (item) => {
                                                        return (
                                                            <Option
                                                                value={item.id}
                                                                key={item.id}
                                                            >
                                                                {
                                                                    item
                                                                        .language
                                                                        .name
                                                                }
                                                            </Option>
                                                        );
                                                    }
                                                )}
                                            </Select>
                                        </Form.Item>
                                    </div>

                                </div>
                                <Form.Item>
                                    <Button
                                        type="primary"
                                        className="btn-success"
                                        style={{ marginTop: "40px" }}
                                        htmlType="submit"
                                    >
                                        {t("save")}
                                    </Button>
                                </Form.Item>
                            </Form>
                        ) : (
                            <div
                                className="d-flex flex-row justify-content-center"
                                style={{ height: "400px" }}
                            >
                                <Spin
                                    style={{
                                        marginTop: "auto",
                                        marginBottom: "auto",
                                    }}
                                    size="large"
                                />
                            </div>
                        )}
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(ShopCurrencyAdd);
