import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    InputNumber,
    Layout,
    Modal,
    PageHeader,
    Radio,
    Select,
    Spin,
    DatePicker,
    message,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import shopActive from "../../requests/Shops/ShopActive";
import languageActive from "../../requests/Language/LanguageActive";
import couponSave from "../../requests/Coupons/CouponSave";
import couponGet from "../../requests/Coupons/CouponGet";
import * as moment from "moment";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";

const { Option } = Select;
const { Content } = Layout;
const { TextArea } = Input;

class CouponAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            shops: [],
            shop_id: -1,
            language: "en",
            languages: [],
            descriptions: {},
            active: true,
            valid_date: "",
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.getActiveShops = this.getActiveShops.bind(this);
        this.getActiveLanguages = this.getActiveLanguages.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.onChangeShop = this.onChangeShop.bind(this);
        this.onChangeDescription = this.onChangeDescription.bind(this);
        this.getInfoById = this.getInfoById.bind(this);

        this.getActiveLanguages();
        this.getActiveShops();
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
    }

    getInfoById = async (id) => {
        let data = await couponGet(id);
        if (data.data.success) {
            let coupon = data.data.data;
            let coupon_language = data.data.data["languages"];

            var descriptionsArray = this.state.descriptions;
            for (let i = 0; i < coupon_language.length; i++) {
                var lang = coupon_language[i].language.short_name;
                descriptionsArray[lang] = coupon_language[i].description;
            }

            this.setState({
                active: coupon.active == 1 ? true : false,
                description: descriptionsArray,
                shop_id: coupon.id_shop,
            });

            this.formRef.current.setFieldsValue({
                description: descriptionsArray[this.state.language],
                shop: coupon.id_shop,
                name: coupon.name,
                discount_type: coupon.discount_type,
                discount: coupon.discount,
                usage_time: coupon.usage_time,
                valid: moment(coupon.valid_until, "HH:mm:ss"),
            });
        }
    };

    getActiveLanguages = async () => {
        let data = await languageActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                languages: data.data.data,
                language: data.data.data[0].short_name,
            });

            var descriptionsArray = this.state.descriptions;

            for (let i = 0; i < data.data.data.length; i++) {
                var lang = data.data.data[i].short_name;
                descriptionsArray[lang] = "";
            }

            this.setState({
                descriptions: descriptionsArray,
            });
        }
    };

    getActiveShops = async () => {
        let data = await shopActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                shops: data.data.data,
                shop_id: data.data.data[0].id,
            });

            this.formRef.current.setFieldsValue({
                shop: data.data.data[0].id,
            });
        }
    };

    onChangeShop = (e) => {
        this.setState({
            shop_id: e,
        });
    };

    onChangeDescription = (e) => {
        var descriptionArray = this.state.descriptions;
        descriptionArray[this.state.language] = e.target.value;
        this.setState({
            descriptions: descriptionArray,
        });
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    onChangeLanguage = (e) => {
        // 99 805 5856
        let lang = e.target.value;
        this.setState({
            language: lang,
        });

        this.formRef.current.setFieldsValue({
            description: this.state.descriptions[lang],
        });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        let data = await couponSave(
            values.name,
            this.state.descriptions,
            values.shop,
            values.discount_type,
            values.discount,
            values.usage_time,
            this.state.valid_date,
            this.state.active,
            this.state.id
        );

        if (data.data.success == 1) window.history.back();
    };

    onFinishFailed = (errorInfo) => {};

    onChangeDate = (value, dateString) => {
        this.setState({
            valid_date: dateString,
        });
    };

    onOk = (value) => {
        console.log("onOk: ", value);
    };

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/coupons" className="nav-text">
                            {t("coupons")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={this.state.edit ? t("coupon_edit") : t("coupon_add")}
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.languages.length > 0 ? (
                            <Form
                                ref={this.formRef}
                                name="basic"
                                initialValues={{
                                    discount_type: 1,
                                }}
                                layout="vertical"
                                onFinish={this.onFinish}
                                onFinishFailed={this.onFinishFailed}
                            >
                                <div className="row">
                                    <div className="col-md-12 col-sm-12">
                                        <Radio.Group
                                            value={this.state.language}
                                            onChange={this.onChangeLanguage}
                                            className="float-right"
                                        >
                                            {this.state.languages.map(
                                                (item) => {
                                                    return (
                                                        <Radio.Button
                                                            value={
                                                                item.short_name
                                                            }
                                                            key={
                                                                item.short_name
                                                            }
                                                        >
                                                            {item.name}
                                                        </Radio.Button>
                                                    );
                                                }
                                            )}
                                        </Radio.Group>
                                    </div>
                                </div>
                                <div className="row">
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("name")}
                                            name="name"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing category name",
                                                },
                                            ]}
                                            tooltip={t("enter_category_name")}
                                        >
                                            <Input placeholder="Name" />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("description")}
                                            name="description"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing coupon description",
                                                },
                                            ]}
                                            tooltip={t(
                                                "enter_coupon_description"
                                            )}
                                        >
                                            <TextArea
                                                showCount
                                                maxLength={100}
                                                onChange={
                                                    this.onChangeDescription
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("shop")}
                                            name="shop"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: "Missing shop",
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
                                            label={t("discount_type")}
                                            name="discount_type"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing discount type",
                                                },
                                            ]}
                                            tooltip={t("select_discount_type")}
                                        >
                                            <Select
                                                placeholder={t(
                                                    "select_discount_type"
                                                )}
                                            >
                                                <Option value={1} key={1}>
                                                    Percentage
                                                </Option>
                                                <Option value={2} key={2}>
                                                    Fixed price
                                                </Option>
                                            </Select>
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("discount")}
                                            name="discount"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: "Missing discount",
                                                },
                                            ]}
                                            tooltip={t("enter_discount")}
                                        >
                                            <InputNumber
                                                placeholder={t("discount")}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("usage_times")}
                                            name="usage_time"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: "Missing discount",
                                                },
                                            ]}
                                            tooltip={t("enter_usage_times")}
                                        >
                                            <InputNumber
                                                placeholder={t("usage_times")}
                                            />
                                        </Form.Item>
                                    </div>

                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            name="valid"
                                            label={t("valid_until")}
                                            tooltip={t(
                                                "enter_banner_valid_date"
                                            )}
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing banner valid date",
                                                },
                                            ]}
                                        >
                                            <DatePicker
                                                showTime
                                                onChange={this.onChangeDate}
                                                onOk={this.onOk}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("status")}
                                            name="active"
                                            tooltip={t(
                                                "uncheck_if_category_is_inactive"
                                            )}
                                        >
                                            <Checkbox
                                                checked={this.state.active}
                                                onChange={this.changeStatus}
                                            >
                                                {this.state.active
                                                    ? t("active")
                                                    : t("inactive")}
                                            </Checkbox>
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

export default withTranslation()(CouponAdd);
