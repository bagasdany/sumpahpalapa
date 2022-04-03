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
import {Link} from "react-router-dom";
import PageLayout from "../../../layouts/PageLayout";
import {PlusOutlined} from "@ant-design/icons";
import shopActive from "../../../requests/Shops/ShopActive";
import roleActive from "../../../requests/RoleActive";
import adminSave from "../../../requests/Admins/AdminSave";
import adminGet from "../../../requests/Admins/AdminGet";
import phonePrefixActive from "../../../requests/PhonePrefix/PhonePrefixActive";
import {withTranslation} from "react-i18next";
import {IMAGE_PATH, IS_DEMO} from "../../../global";

const {Option} = Select;
const {Content} = Layout;

class AdminAdd extends React.Component {
    formRef = React.createRef();

    deliveryBoyIncomeType = [
        {
            "id": 1,
            "name": "salary_from_shop"
        },
        {
            "id": 2,
            "name": "percentage_from_delivery_fee"
        },
        {
            "id": 3,
            "name": "fixed_price_from_delivery_fee"
        }
    ];

    constructor(props) {
        super(props);

        this.state = {
            previewImage: "",
            previewVisible: false,
            previewTitle: "",
            fileList: [],
            shops: [],
            roles: [],
            prefix_phone: [],
            phone_prefix: [],
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
            deliveryBoyIncomeTypeId: 1,
            deliveryBoySalary: 0,
            role_id: 0,
        };

        this.getActiveShops = this.getActiveShops.bind(this);
        this.getActiveRoles = this.getActiveRoles.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.onChangeRole = this.onChangeRole.bind(this);
        this.getActivePhonePrefix = this.getActivePhonePrefix.bind(this);

        this.getActivePhonePrefix();
        this.getActiveShops();
    }

    getInfoById = async (id) => {
        let data = await adminGet(id);
        if (data.data.success) {
            let admin = data.data.data;
            this.setState({
                active: admin.active == 1 ? true : false,
                fileList: [
                    {
                        uid: "-1",
                        name: admin.image_url,
                        status: "done",
                        url: IMAGE_PATH + admin.image_url,
                    },
                ],
            });

            var ppdata = this.getPrefixFromPhone(admin.phone);

            var phone = ppdata.phone;
            var prefix = ppdata.prefix;

            this.formRef.current.setFieldsValue({
                dragger: this.state.fileList,
                name: admin.name,
                surname: admin.surname,
                email_admin: admin.email,
                prefix_phone: prefix,
                phone: phone,
                shop: admin.id_shop,
                role: admin.id_role,
            });
        }
    };

    getPrefixFromPhone = (phoneNum) => {
        var prefix = "";
        var phone = "";

        var index = this.state.phone_prefix.findIndex((element) => {
            var p = element.prefix;
            var array = phoneNum.split(p);

            return array.length > 1;
        });

        if (index > -1) {
            var array = phoneNum.split(this.state.phone_prefix[index].prefix);
            prefix = this.state.phone_prefix[index].prefix;
            phone = array[1];
        }

        return {
            prefix: prefix,
            phone: phone
        };
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

    getActiveShops = async () => {
        let data = await shopActive();
        if (data.data.success && data.data.data.length > 0) {
            this.setState({
                shops: data.data.data,
            });

            this.formRef.current.setFieldsValue({
                shop: data.data.data[0].id,
            });

            this.getActiveRoles();

            if (this.state.edit) this.getInfoById(this.state.id);
        }
    };

    getActiveRoles = async () => {
        let data = await roleActive();
        if (data.data.success && data.data.data.length > 0) {
            this.setState({
                roles: data.data.data,
                role_id: data.data.data[1].id,
            });

            this.formRef.current.setFieldsValue({
                role: data.data.data[1].id,
            });
        }
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    onFinish = async (values) => {
        if (IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        if (values.password_admin != values.confirm_password) {
            message.error("Password and confirm password mismatch");
            return false;
        }

        let data = await adminSave(
            values.name,
            values.surname,
            values.email_admin,
            values.prefix_phone + "" + values.phone,
            values.password_admin,
            values.shop,
            values.role,
            this.state.fileList[0].name,
            this.state.active,
            this.state.id,
            values.payout_type,
            values.payout_value
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

    getBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = () => resolve(reader.result);
            reader.onerror = (error) => reject(error);
        });
    };

    handleCancel = () => this.setState({previewVisible: false});

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

    handleChange = ({fileList}) => {
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

        this.setState({fileList});
    };

    onChangeRole = (e) => {
        this.setState({role_id: e});
    }

    render() {
        const {t} = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{margin: "16px 0"}}>
                    <Breadcrumb.Item>
                        <Link to="/admins" className="nav-text">
                            {t("admins")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={this.state.edit ? t("admin_edit") : t("admin_add")}
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.shops.length > 0 ? (
                            <Form
                                ref={this.formRef}
                                name="basic"
                                layout="vertical"
                                initialValues={{
                                    "payout_type": 1
                                }}
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
                                            <Input placeholder={t("name")}/>
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
                                            <Input placeholder={t("surname")}/>
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
                                            <Input placeholder={t("email")}/>
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
                                            label={t("role")}
                                            name="role"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t("missing_role"),
                                                },
                                            ]}
                                            tooltip={t("select_role")}
                                        >
                                            <Select
                                                placeholder={t("select_role")}
                                                onChange={this.onChangeRole}
                                            >
                                                {this.state.roles.map(
                                                    (item) => {
                                                        return (
                                                            <Option
                                                                disabled={
                                                                    item.id == 1
                                                                        ? true
                                                                        : false
                                                                }
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
                                    {
                                        this.state.role_id == 3 && (
                                            <div className="col-md-6 col-sm-12">
                                                <Form.Item
                                                    label={t("delivery_income_type")}
                                                    name="payout_type"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t("missing_delivery_income_type"),
                                                        },
                                                    ]}
                                                    tooltip={t("select_delivery_income_type")}
                                                >
                                                    <Select
                                                        placeholder={t("select_delivery_income_type")}
                                                    >
                                                        {this.deliveryBoyIncomeType.map(
                                                            (item) => {
                                                                return (
                                                                    <Option
                                                                        value={item.id}
                                                                        key={item.id}
                                                                    >
                                                                        {t(item.name)}
                                                                    </Option>
                                                                );
                                                            }
                                                        )}
                                                    </Select>
                                                </Form.Item>
                                            </div>
                                        )
                                    }
                                    {
                                        this.state.role_id == 3 && (<div className="col-md-6 col-sm-12">
                                            <Form.Item
                                                label={t("delivery_boy_salary")}
                                                name="payout_value"
                                                tooltip={t("enter_delivery_boy_salary")}
                                                rules={[
                                                    {
                                                        required: true,
                                                        message:
                                                            t("missing_delivery_boy_salary"),
                                                    },
                                                ]}
                                            >
                                                <Input
                                                    placeholder={t("delivery_boy_salary")}
                                                />
                                            </Form.Item>
                                        </div>)
                                    }
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
                                                            <PlusOutlined/>
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
                                                    style={{width: "100%"}}
                                                    src={
                                                        this.state.previewImage
                                                    }
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

export default withTranslation()(AdminAdd);
