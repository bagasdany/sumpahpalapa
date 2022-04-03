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
    Select,
    Spin,
    Upload,
    message,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../../layouts/PageLayout";
import { PlusOutlined } from "@ant-design/icons";
import {IMAGE_PATH, IS_DEMO} from "../../../global";
import clientSave from "../../../requests/Clients/ClientSave";
import { withTranslation } from "react-i18next";

const { Option } = Select;
const { Content } = Layout;

class ClientsAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            previewImage: "",
            previewVisible: false,
            previewTitle: "",
            fileList: [],
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.changeStatus = this.changeStatus.bind(this);
        this.onFinish = this.onFinish.bind(this);

        if (this.state.edit) this.getInfoById(this.state.id);
    }

    getInfoById = async (id) => {};

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

        if (values.password_client != values.confirm_password) {
            message.error("Password and confirm password mismatch");
            return false;
        }

        let data = await clientSave(
            values.name,
            values.surname,
            values.email_client,
            values.prefix_phone + "" + values.phone,
            values.password_client,
            this.state.fileList[0].name,
            this.state.active,
            this.state.id
        );

        //if (data.data.success == 1) this.props.history.goBack();
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
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/admins" className="nav-text">
                            {t("clients")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => this.props.history.goBack()}
                    className="site-page-header"
                    title={this.state.edit ? t("client_edit") : t("client_add")}
                >
                    <Content className="site-layout-background padding-20">
                        <Form
                            ref={this.formRef}
                            name="basic"
                            initialValues={{
                                prefix_phone: "+1",
                            }}
                            layout="vertical"
                            onFinish={this.onFinish}
                            onFinishFailed={this.onFinishFailed}
                        >
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
                                                message: t("missing_surname"),
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
                                        name="email_client"
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
                                                            width: 70,
                                                        }}
                                                    >
                                                        <Option value="+1">
                                                            +1
                                                        </Option>
                                                        <Option value="+8">
                                                            +8
                                                        </Option>
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
                                        name="password_client"
                                        tooltip={t("enter_password")}
                                        rules={[
                                            {
                                                required: true,
                                                message: t("missing_password"),
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
                                        tooltip={t("enter_confirm_password")}
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
                                            placeholder={t("confirm_password")}
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
                                            getValueFromEvent={this.normFile}
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
                                                fileList={this.state.fileList}
                                                defaultFileList={
                                                    this.state.fileList
                                                }
                                                onPreview={this.handlePreview}
                                                onChange={this.handleChange}
                                            >
                                                {this.state.fileList.length >=
                                                1 ? null : (
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
                                            visible={this.state.previewVisible}
                                            title={this.state.previewTitle}
                                            footer={null}
                                            onCancel={this.handleCancel}
                                        >
                                            <img
                                                alt="example"
                                                style={{ width: "100%" }}
                                                src={this.state.previewImage}
                                            />
                                        </Modal>
                                    </Form.Item>
                                </div>
                                <div className="col-md-6 col-sm-12">
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
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(ClientsAdd);
