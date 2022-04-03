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
    Select,
    Spin,
    Upload,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import { PlusOutlined } from "@ant-design/icons";
import shopActive from "../../requests/Shops/ShopActive";
import brandSave from "../../requests/Brands/BrandSave";
import brandGet from "../../requests/Brands/BrandGet";
import brandsCategoryActive from "../../requests/BrandCategories/BrandsCategoryActive";
import { withTranslation } from "react-i18next";
import reqwest from "reqwest";
import {IS_DEMO} from "../../global";

const { Option } = Select;
const { Content } = Layout;

class CategoryTaxAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            categories: [],
            taxes: [],
            tax: props.id,
            active: true,
            id: props.id,
            amount: 0,
            edit: props.id > 0 ? true : false,

            // edit: props.location.state ? props.location.state.edit : false,
        };

        this.getActiveTaxes = this.getActiveTaxes.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.onChangeTax = this.onChangeTax.bind(this);

        if (this.state.edit) this.getInfoById(props.id);
        if (this.props.shop_id) this.getActiveTaxes(this.props.shop_id);
    }

    getInfoById = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: `/api/auth/taxes/get/${id}`,
            method: "get",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            if (data.success) {
                const res = data.data;
                this.setState({
                    active: res.active == 1 ? true : false,
                    tax: res.id,
                });
            }
        });
    };

    getActiveTaxes = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: `/api/auth/taxes/shop/${id}/active`,
            method: "get",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            this.setState({
                taxes: data.data,
            });
        });
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    onFinish = (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        const token = localStorage.getItem("jwt_token");
        reqwest({
            url:
                `/api/auth/category/tax?category_id=${this.props.category_id}&tax_id=${this.state.tax}` +
                `${this.state.edit ? `&id=${this.props.id}` : ""}`,
            method: "post",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            if (data.success == 1) {
                this.props.onSave();
            }
        });
    };
    onChangeTax = (e) => {
        console.log("Tax", e);
        this.setState({
            tax: e,
        });
    };
    onFinishFailed = (errorInfo) => {};

    render() {
        const { t } = this.props;
        return (
            <PageHeader
                onBack={() => this.props.onSave()}
                className="site-page-header"
                title={
                    this.state.edit
                        ? t("category_taxes_edit")
                        : t("category_taxes_add")
                }
            >
                <Content className="site-layout-background padding-20">
                    {this.state.taxes.length > 0 ? (
                        <Form
                            // ref={this.formRef}
                            name="basic"
                            layout="vertical"
                            onFinish={this.onFinish}
                            onFinishFailed={this.onFinishFailed}
                        >
                            <div className="row">
                                <div className="col-md-6 col-sm-12">
                                    <Form.Item
                                        label={t("tax")}
                                        // name="tax"
                                        rules={[
                                            {
                                                required: true,
                                                message: "Missing tax",
                                            },
                                        ]}
                                        tooltip={t("select_tax")}
                                    >
                                        <Select
                                            placeholder={t("select_tax")}
                                            value={this.state.tax}
                                            onChange={this.onChangeTax}
                                        >
                                            {this.state.taxes.map((item) => {
                                                return (
                                                    <Option
                                                        value={item.id}
                                                        key={item.id}
                                                    >
                                                        {item.name}
                                                    </Option>
                                                );
                                            })}
                                        </Select>
                                    </Form.Item>
                                </div>
                                <div className="col-md-3 col-sm-12">
                                    <Form.Item
                                        label={t("status")}
                                        name="active"
                                        tooltip={t(
                                            "uncheck_if_brand_is_inactive"
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
        );
    }
}

export default withTranslation()(CategoryTaxAdd);
