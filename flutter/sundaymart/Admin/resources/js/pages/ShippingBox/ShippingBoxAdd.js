import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout,
    message,
    PageHeader,
    Radio,
    Spin,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import shippingBoxSave from "../../requests/ShippingBox/ShippingBoxSave";
import shippingBoxGet from "../../requests/ShippingBox/ShippingBoxGet";
import { withTranslation } from "react-i18next";
import languageActive from "../../requests/Language/LanguageActive";
import {IS_DEMO} from "../../global";

const { Content } = Layout;
const { TextArea } = Input;

class ShippingBoxAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            language: "en",
            languages: [],
            descriptions: {},
            names: {},
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.changeStatus = this.changeStatus.bind(this);
        this.getActiveLanguages = this.getActiveLanguages.bind(this);
        this.getActiveLanguages();
        if (this.state.edit) this.getInfoById(this.state.id);
    }

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
    getInfoById = async (id) => {
        let data = await shippingBoxGet(id);
        if (data.data.success) {
            let respData = data.data.data;
            let languages = data.data.data["languages"];

            var namesArray = this.state.names;
            var descriptionsArray = this.state.descriptions;
            for (let i = 0; i < languages.length; i++) {
                var lang = languages[i]?.language.short_name;
                namesArray[lang] = languages[i]?.name;
                descriptionsArray[lang] = languages[i]?.description;
            }
            this.setState({
                names: namesArray,
                descriptions: descriptionsArray,
                active: respData.active == 1 ? true : false,
            });
            this.formRef.current.setFieldsValue({
                name: namesArray[this.state.language],
                description: descriptionsArray[this.state.language],
            });
        }
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await shippingBoxSave(
            this.state.names,
            this.state.descriptions,
            this.state.active,
            this.state.id
        );

        if (data.data.success == 1) window.history.back();
    };

    onFinishFailed = (errorInfo) => {};

    onChangeName = (e) => {
        var namesArray = this.state.names;
        namesArray[this.state.language] = e.target.value;
        this.setState({
            names: namesArray,
        });
    };
    onChangeDescription = (e) => {
        var descriptionArray = this.state.descriptions;
        descriptionArray[this.state.language] = e.target.value;
        this.setState({
            descriptions: descriptionArray,
        });
    };

    onChangeLanguage = (e) => {
        // 99 805 5856
        let lang = e.target.value;
        this.setState({
            language: lang,
        });

        this.formRef.current.setFieldsValue({
            name: this.state.names[lang],
            description: this.state.descriptions[lang],
        });
    };

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/shipping-box" className="nav-text">
                            {t("shipping_box")}
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
                            ? t("shipping_box_edit")
                            : t("shipping_box_add")
                    }
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.languages.length > 0 ? (
                            <Form
                                ref={this.formRef}
                                name="basic"
                                initialValues={{}}
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
                                                    message: "Missing name",
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
                                                    message:
                                                        "Missing description",
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
                                    <div className="col-md-3 col-sm-12">
                                        <Form.Item
                                            label={t("status")}
                                            name="active"
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

export default withTranslation()(ShippingBoxAdd);
