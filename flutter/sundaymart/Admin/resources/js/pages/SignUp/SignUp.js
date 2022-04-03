import React from "react";
import {
    Button,
    Card,
    Checkbox,
    Form,
    Input,
    Layout,
    Modal,
    Select,
    Upload,
} from "antd";
import { PlusOutlined } from "@ant-design/icons";
import managerSave from "../../requests/Managers/ManagersSave";
import phonePrefixActive from "../../requests/PhonePrefix/PhonePrefixActive";
import { withTranslation } from "react-i18next";
import {APP_NAME, IMAGE_PATH} from "../../global";
const { Option } = Select;

class SignUp extends React.Component {
    state = {
        previewImage: "",
        previewVisible: false,
        previewTitle: "",
        fileList: [],
        error: "",
        phone_prefix: [],
        success: false,
    };

    constructor(props) {
        super(props);

        this.getActivePhonePrefix = this.getActivePhonePrefix.bind(this);

        this.getActivePhonePrefix();
    }

    getActivePhonePrefix = async () => {
        let data = await phonePrefixActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                phone_prefix: data.data.data,
            });

            if (this.formRef.current != null)
                this.formRef.current.setFieldsValue({
                    prefix_phone: data.data.data[0].prefix,
                });
        }
    };

    onFinish = async (values) => {
        if (values.password_admin !== values.confirm_password) {
            this.setState({
                error: "Password and confirm password mismatch",
            });

            setTimeout(() => {
                this.setState({
                    error: "",
                });
            }, 5000);

            return;
        }

        var data = await managerSave(
            values.name,
            values.surname,
            values.email_admin,
            values.phone,
            values.password_admin,
            this.state.fileList[0].name
        );

        if (data.data.success == 1) {
            this.setState({
                success: true,
            });
        } else {
            this.setState({
                error: data.data.msg,
            });

            setTimeout(() => {
                this.setState({ error: "" });
            }, 5000);
        }
    };

    onFinishFailed = (errorInfo) => {};

    normFile = (e) => {
        if (Array.isArray(e)) {
            return e;
        }

        return e && e.fileList;
    };

    getBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = () => resolve(reader.result);
            reader.onerror = (error) => reject(error);
        });
    };

    handleCancel = () => this.setState({ previewVisible: false });

    handlePreview = async (file) => {
        if (!file.url && !file.preview) {
            file.preview = await this.getBase64(file.originFileObj);
        }

        this.setState({
            previewImage: file.url || file.preview,
            previewVisible: true,
            previewTitle:
                file.name || file.url.substring(file.url.lastIndexOf("/") + 1),
        });
    };

    handleChange = ({ fileList }) => {
        fileList = fileList.map((file) => {
            if (file.response) {
                return {
                    uid: file.uid,
                    name: file.response.name,
                    status: "done",
                    url: IMAGE_PATH + file.response.name,
                };
            }
            return file;
        });

        this.setState({ fileList });
    };

    render() {
        const { t } = this.props;
        return (
            <Layout
                className="site-layout-background justify-content-center"
                style={{ minHeight: "100vh" }}
            >
                <div className="container">
                    <Card className="overflow-hidden">
                        {!this.state.success ? (
                            <Form
                                name="basic"
                                initialValues={{
                                    remember: true,
                                }}
                                layout="vertical"
                                onFinish={this.onFinish}
                                onFinishFailed={this.onFinishFailed}
                            >
                                <h1 className="h4 text-gray-900 mb-4 text-center">
                                    {t("welcome_to")}{" "}
                                    <b className="text-success">{APP_NAME}</b>
                                </h1>
                                {this.state.error.length > 0 && (
                                    <div className="text-center">
                                        <span className="text-danger">
                                            {this.state.error}
                                        </span>
                                    </div>
                                )}
                                <div className="row">
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("name")}
                                            name="name"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t("missing_name"),
                                                },
                                            ]}
                                            tooltip={t("enter_name")}
                                        >
                                            <Input placeholder={t("name")} />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("surname")}
                                            name="surname"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t("missing_surname"),
                                                },
                                            ]}
                                            tooltip={t("enter_surname")}
                                        >
                                            <Input placeholder={t("surname")} />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("email")}
                                            name="email_admin"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t("missing_email"),
                                                },
                                            ]}
                                            tooltip={t("enter_email")}
                                        >
                                            <Input placeholder={t("email")} />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("phone")}
                                            name="phone"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t("missing_phone"),
                                                },
                                            ]}
                                            tooltip={t("enter_phone")}
                                        >
                                            <Input
                                                addonBefore={
                                                    <Form.Item
                                                        name="prefix_phone"
                                                        noStyle
                                                    >
                                                        <Select
                                                            style={{
                                                                width: 100,
                                                            }}
                                                        >
                                                            {this.state.phone_prefix.map(
                                                                (item) => {
                                                                    return (
                                                                        <Option
                                                                            value={
                                                                                item.prefix
                                                                            }
                                                                            key={
                                                                                item.id
                                                                            }
                                                                        >
                                                                            {
                                                                                item.prefix
                                                                            }
                                                                        </Option>
                                                                    );
                                                                }
                                                            )}
                                                        </Select>
                                                    </Form.Item>
                                                }
                                                placeholder={t("phone")}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("password")}
                                            name="password_admin"
                                            tooltip={t("enter_password")}
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t("missing_password"),
                                                },
                                            ]}
                                        >
                                            <Input.Password
                                                placeholder={t("password")}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("confirm_password")}
                                            name="confirm_password"
                                            tooltip={t(
                                                "enter_confirm_password"
                                            )}
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t(
                                                        "missing_confirm_password"
                                                    ),
                                                },
                                            ]}
                                        >
                                            <Input.Password
                                                placeholder={t(
                                                    "confirm_password"
                                                )}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("avatar")}
                                            tooltip={t("upload_avatar")}
                                        >
                                            <Form.Item
                                                name="dragger"
                                                valuePropName="fileList"
                                                getValueFromEvent={
                                                    this.normFile
                                                }
                                                rules={[
                                                    {
                                                        required: true,
                                                        message:
                                                            t("missing_avatar"),
                                                    },
                                                ]}
                                                noStyle
                                            >
                                                <Upload
                                                    action="/api/auth/upload"
                                                    listType="picture-card"
                                                    fileList={
                                                        this.state.fileList
                                                    }
                                                    defaultFileList={
                                                        this.state.fileList
                                                    }
                                                    onPreview={
                                                        this.handlePreview
                                                    }
                                                    onChange={this.handleChange}
                                                >
                                                    {this.state.fileList
                                                        .length >= 1 ? null : (
                                                        <div>
                                                            <PlusOutlined />
                                                            <div
                                                                style={{
                                                                    marginTop: 8,
                                                                }}
                                                            >
                                                                {t("upload")}
                                                            </div>
                                                        </div>
                                                    )}
                                                </Upload>
                                            </Form.Item>
                                            <Modal
                                                visible={
                                                    this.state.previewVisible
                                                }
                                                title={this.state.previewTitle}
                                                footer={null}
                                                onCancel={this.handleCancel}
                                            >
                                                <img
                                                    alt="example"
                                                    style={{ width: "100%" }}
                                                    src={
                                                        this.state.previewImage
                                                    }
                                                />
                                            </Modal>
                                        </Form.Item>
                                    </div>
                                </div>
                                <Form.Item>
                                    <Button type="primary" htmlType="submit">
                                        {t("submit")}
                                    </Button>
                                </Form.Item>
                            </Form>
                        ) : (
                            <h1 className="h4 text-gray-900 mb-4 text-center text-success">
                                Your application saved successfully. We will
                                contact with you in short time
                            </h1>
                        )}
                    </Card>
                </div>
            </Layout>
        );
    }
}

export default withTranslation()(SignUp);
