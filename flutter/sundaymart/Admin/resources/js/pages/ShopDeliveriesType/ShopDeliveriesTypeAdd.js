import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout,
    PageHeader,
    Radio,
    Spin,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import languageActive from "../../requests/Language/LanguageActive";
import shopDeliveryTypeSave from "../../requests/ShopDeliveryType/ShopDelivsryTypeSave";
import shopDeliveryTypeGet from "../../requests/ShopDeliveryType/ShopDeliveryTypeGet";
import { withTranslation } from "react-i18next";

const { Content } = Layout;
const { TextArea } = Input;

class ShopDeliveriesTypeAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            name: {},
            language: "en",
            languages: [],
            descriptions: {},
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.changeStatus = this.changeStatus.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.onChangeDescription = this.onChangeDescription.bind(this);
        this.onChangeName = this.onChangeName.bind(this);

        this.getActiveLanguages();
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
    }

    getInfoById = async (id) => {
        let data = await shopDeliveryTypeGet(id);
        if (data.data.success) {
            let delivery_type = data.data.data;
            let delivery_type_language = data.data.data["languages"];
            console.log("delivery type", delivery_type);
            console.log("delivery type languages", delivery_type_language);

            var descriptionsArray = this.state.descriptions;
            for (let i = 0; i < delivery_type_language.length; i++) {
                var lang = delivery_type_language[i].language.short_name;
                descriptionsArray[lang] = delivery_type_language[i].description;
            }
            this.setState({
                active: delivery_type.status == 1 ? true : false,
                description: descriptionsArray,
            });
            var nameArray = this.state.name;
            for (let i = 0; i < delivery_type_language.length; i++) {
                var lang = delivery_type_language[i].language.short_name;
                nameArray[lang] = delivery_type_language[i].name;
            }
            this.setState({
                name: nameArray,
            });
            this.formRef.current.setFieldsValue({
                description: descriptionsArray[this.state.language],
                name: nameArray[this.state.language],
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

    onChangeDescription = (e) => {
        var descriptionArray = this.state.descriptions;
        descriptionArray[this.state.language] = e.target.value;
        this.setState({
            descriptions: descriptionArray,
        });
    };
    onChangeName = (e) => {
        var nameArray = this.state.name;
        nameArray[this.state.language] = e.target.value;
        this.setState({
            name: nameArray,
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

    onFinish = async () => {
        const createData = {
            name: this.state.name,
            description: this.state.descriptions,
            status: this.state.active ? 1 : 0,
        };
        let data = await shopDeliveryTypeSave(this.state.id, createData);
        if (data.status == 200) window.history.back();
    };

    onFinishFailed = (errorInfo) => {};

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/shops-delivery-type" className="nav-text">
                            {t("shop_delivery_type")}
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
                            ? "shop_delivery_type_edit"
                            : "shop_delivery_type_add"
                    }
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
                                                    message: t("missing _name"),
                                                },
                                            ]}
                                            tooltip={t("enter_name")}
                                        >
                                            <Input
                                                placeholder={t("name")}
                                                onChange={this.onChangeName}
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
                                                        "missing_description"
                                                    ),
                                                },
                                            ]}
                                            tooltip={t("enter_description")}
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
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("status")}
                                            name="active"
                                            tooltip={t("uncheck_is_inactive")}
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

export default withTranslation()(ShopDeliveriesTypeAdd);
