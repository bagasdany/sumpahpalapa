import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    InputNumber,
    Layout,
    message,
    PageHeader,
    Select,
    Spin,
} from "antd";
import {Link} from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import shopActive from "../../requests/Shops/ShopActive";
import taxSave from "../../requests/Taxes/TaxSave";
import taxGet from "../../requests/Taxes/TaxGet";
import {withTranslation} from "react-i18next";
import {IS_DEMO} from "../../global";

const {Option} = Select;
const {Content} = Layout;
const {TextArea} = Input;

class TaxAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            previewImage: "",
            previewVisible: false,
            previewTitle: "",
            fileList: [],
            shops: [],
            active: true,
            isDefaultTax: false,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.getActiveShops = this.getActiveShops.bind(this);
        this.changeStatus = this.changeStatus.bind(this);

        this.getActiveShops();

        if (this.state.edit) this.getInfoById(this.state.id);
    }

    getInfoById = async (id) => {
        let data = await taxGet(id);
        if (data.data.success) {
            let tax = data.data.data;
            this.setState({
                active: tax.active == 1 ? true : false,
                isDefaultTax: tax.default == 1 ? true : false
            });

            this.formRef.current.setFieldsValue({
                name: tax.name,
                shop: tax.shop_id,
                percentage: tax.percent,
                description: tax.description,
            });
        }
    };

    getActiveShops = async () => {
        let data = await shopActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                shops: data.data.data,
            });

            this.formRef.current.setFieldsValue({
                shop: data.data.data[0].id,
            });
        }
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    changeTaxDefault = (e) => {
        this.setState({
            isDefaultTax: e.target.checked,
        });
    };

    onFinish = async (values) => {
        if (IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await taxSave(
            values.name,
            values.shop,
            values.description,
            values.percentage,
            this.state.active,
            this.state.isDefaultTax,
            this.state.id
        );

        if (data.data.success == 1) window.history.back();
    };

    onFinishFailed = (errorInfo) => {
    };

    normFile = (e) => {
        if (Array.isArray(e)) {
            return e;
        }

        return e && e.fileList;
    };

    handleCancel = () => this.setState({previewVisible: false});

    render() {
        const {t} = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{margin: "16px 0"}}>
                    <Breadcrumb.Item>
                        <Link to="/taxes" className="nav-text">
                            {t("taxes")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={this.state.edit ? t("tax_edit") : t("tax_add")}
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
                                                    message: "Missing shop",
                                                },
                                            ]}
                                            tooltip={t("select_shop")}
                                        >
                                            <Select
                                                placeholder={t("select_shop")}
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
                                            label={t("name")}
                                            name="name"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: "Missing tax name",
                                                },
                                            ]}
                                            tooltip={t("enter_tax_name")}
                                        >
                                            <Input placeholder={t("name")}/>
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("percentage")}
                                            name="percentage"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing tax percentage",
                                                },
                                            ]}
                                            tooltip={t("enter_tax_percentage")}
                                        >
                                            <InputNumber
                                                placeholder={t("percentage")}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("description")}
                                            name="description"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t(
                                                        "missing_tax_description"
                                                    ),
                                                },
                                            ]}
                                            tooltip={t("enter_tax_description")}
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
                                    <div className="col-md-3 col-sm-12">
                                        <Form.Item
                                            label={t("tax_is_shop_default")}
                                            name="default"
                                            tooltip={t(
                                                "uncheck_if_tax_not_default"
                                            )}
                                        >
                                            <Checkbox
                                                checked={this.state.isDefaultTax}
                                                onChange={this.changeTaxDefault}
                                            >
                                                {this.state.isDefaultTax
                                                    ? t("yes")
                                                    : t("no")}
                                            </Checkbox>
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
                                        style={{marginTop: "40px"}}
                                        htmlType="submit"
                                    >
                                        {t("save")}
                                    </Button>
                                </Form.Item>
                            </Form>
                        ) : (
                            <div
                                className="d-flex flex-row justify-content-center"
                                style={{height: "400px"}}
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

export default withTranslation()(TaxAdd);
