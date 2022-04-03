import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout,
    Modal,
    PageHeader,
    Radio,
    Select,
    Spin,
    Upload,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../../layouts/PageLayout";
import languageActive from "../../../requests/Language/LanguageActive";
import paymentsSave from "../../../requests/Payments/PaymentsSave";
import paymentGet from "../../../requests/Payments/PaymentsGet";
import { withTranslation } from "react-i18next";

const { Content } = Layout;

class PaymentsAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            language: "en",
            languages: [],
            names: {},
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.getActiveLanguages = this.getActiveLanguages.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.onChangeName = this.onChangeName.bind(this);
        this.getInfoById = this.getInfoById.bind(this);

        this.getActiveLanguages();
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
    }

    getInfoById = async (id) => {
        let data = await paymentGet(id);
        if (data.data.success) {
            let payment = data.data.data;
            let payment_language = data.data.data["languages"];

            var namesArray = this.state.names;
            for (let i = 0; i < payment_language.length; i++) {
                var lang = payment_language[i].language.short_name;
                namesArray[lang] = payment_language[i].name;
            }

            this.setState({
                active: payment.active == 1 ? true : false,
                names: namesArray,
            });

            this.formRef.current.setFieldsValue({
                name: namesArray[this.state.language],
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

            var namesArray = this.state.names;

            for (let i = 0; i < data.data.data.length; i++) {
                var lang = data.data.data[i].short_name;
                namesArray[lang] = "";
            }

            this.setState({
                names: namesArray,
            });
        }
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    onChangeName = (e) => {
        var namesArray = this.state.names;
        namesArray[this.state.language] = e.target.value;
        this.setState({
            names: namesArray,
        });
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

    onFinish = async (values) => {
        let data = await paymentsSave(
            this.state.names,
            this.state.active,
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
                        <Link to="/payments" className="nav-text">
                            {t("payments")}
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
                        this.state.edit ? t("payment_edit") : t("payment_add")
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
                                                    message: t(
                                                        "missing_category_name"
                                                    ),
                                                },
                                            ]}
                                            tooltip={t("enter_category_name")}
                                        >
                                            <Input
                                                placeholder={t("name")}
                                                onChange={this.onChangeName}
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

export default withTranslation()(PaymentsAdd);
