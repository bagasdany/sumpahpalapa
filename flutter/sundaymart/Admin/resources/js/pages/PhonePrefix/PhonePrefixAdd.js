import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout, message,
    PageHeader,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import phonePrefixSave from "../../requests/PhonePrefix/PhonePrefixSave";
import phonePrefixGet from "../../requests/PhonePrefix/PhonePrefixGet";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";

const { Content } = Layout;

class PhonePrefixAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        if (this.state.edit) this.getInfoById(this.state.id);
    }

    getInfoById = async (id) => {
        let data = await phonePrefixGet(id);
        if (data.data.success) {
            let phonePrefix = data.data.data;

            this.setState({
                active: phonePrefix.active == 1 ? true : false,
            });

            this.formRef.current.setFieldsValue({
                phone_prefix: phonePrefix.prefix,
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

        let data = await phonePrefixSave(
            values.phone_prefix,
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
                        <Link to="/phone-prefix" className="nav-text">
                            {t("phone_prefix")}
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
                            ? t("phone_prefix_edit")
                            : t("phone_prefix_add")
                    }
                >
                    <Content className="site-layout-background padding-20">
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
                                        label={t("phone_prefix")}
                                        name="phone_prefix"
                                        rules={[
                                            {
                                                required: true,
                                                message: t(
                                                    "missing_phone_prefix"
                                                ),
                                            },
                                        ]}
                                        tooltip={t("enter_phone_prefix")}
                                    >
                                        <Input
                                            placeholder={t("phone_prefix")}
                                        />
                                    </Form.Item>
                                </div>
                                <div className="col-md-6 col-sm-12">
                                    <Form.Item
                                        label={t("status")}
                                        name="active"
                                        tooltip={t(
                                            "uncheck_if_currency_is_inactive"
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
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(PhonePrefixAdd);
