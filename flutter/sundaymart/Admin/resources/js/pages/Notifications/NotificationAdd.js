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
    DatePicker,
    Upload,
    message,
} from "antd";
import { Link } from "react-router-dom";
import { CKEditor } from "@ckeditor/ckeditor5-react";
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
import PageLayout from "../../layouts/PageLayout";
import { PlusOutlined } from "@ant-design/icons";
import shopActive from "../../requests/Shops/ShopActive";
import * as moment from "moment";
import notificationsSave from "../../requests/Notifications/NotificationsSave";
import notificationGet from "../../requests/Notifications/NotificationsGet";
import { withTranslation } from "react-i18next";
import {IMAGE_PATH, IS_DEMO} from "../../global";
const { Option } = Select;
const { Content } = Layout;

class NotificationAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            previewImage: "",
            previewVisible: false,
            previewTitle: "",
            fileList: [],
            shops: [],
            sendTime: moment.now(),
            description: "",
            active: true,
            hasImage: false,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.getActiveShops = this.getActiveShops.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.changeHasImage = this.changeHasImage.bind(this);
        this.onChangeSendTime = this.onChangeSendTime.bind(this);

        this.getActiveShops();
    }

    getInfoById = async (id) => {
        let data = await notificationGet(id);
        if (data.data.success) {
            let notification = data.data.data;
            this.setState({
                active: notification.active == 1 ? true : false,
                hasImage: notification.has_image == 1 ? true : false,
                fileList: [
                    {
                        uid: "-1",
                        name: notification.image_url,
                        status: "done",
                        url: IMAGE_PATH + notification.image_url,
                    },
                ],
                sendTime: notification.send_time,
                description: notification.description,
            });

            this.formRef.current.setFieldsValue({
                dragger: this.state.fileList,
                title: notification.title,
                has_image: notification.has_image,
                shop: notification.id_shop,
                send_time: moment(
                    notification.send_time,
                    "YYYY-MM-DD HH:mm:ss"
                ),
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

            if (this.state.edit) this.getInfoById(this.state.id);
        }
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    changeHasImage = (e) => {
        this.setState({
            hasImage: e.target.checked,
        });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await notificationsSave(
            values.title,
            this.state.description,
            this.state.hasImage,
            this.state.hasImage ? this.state.fileList[0].name : "",
            this.state.sendTime,
            values.shop,
            this.state.active,
            this.state.id
        );

        if (data.data.success == 1) window.history.back();
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

    onChangeSendTime = (time, timeString) => {
        this.setState({
            sendTime: timeString,
        });
    };

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/notifications" className="nav-text">
                            {t("notifications")}
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
                            ? t("notification_edit")
                            : t("notification_add")
                    }
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
                                            label={t("title")}
                                            name="title"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t(
                                                        "missing_notification_title"
                                                    ),
                                                },
                                            ]}
                                            tooltip={t(
                                                "enter_notification_title"
                                            )}
                                        >
                                            <Input placeholder={t("title")} />
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
                                            label={t("description")}
                                            name="description"
                                            tooltip={t("enter_description")}
                                        >
                                            <CKEditor
                                                editor={ClassicEditor}
                                                data={this.state.description}
                                                onChange={(event, editor) => {
                                                    const data =
                                                        editor.getData();
                                                    this.setState({
                                                        description: data,
                                                    });
                                                }}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            name="send_time"
                                            label={t("send_time")}
                                            tooltip={
                                                "enter_a_sending_time_of_notification"
                                            }
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t(
                                                        "missing_a_sending_time_of_notification"
                                                    ),
                                                },
                                            ]}
                                        >
                                            <DatePicker
                                                onChange={this.onChangeSendTime}
                                                format="YYYY-MM-DD HH:mm:ss"
                                                showTime={{
                                                    defaultValue: moment(
                                                        this.state.sendTime,
                                                        "YYYY-MM-DD HH:mm:ss"
                                                    ),
                                                }}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-12">
                                        <Form.Item
                                            label={t("has_top_image")}
                                            name="has_image"
                                            tooltip={t("Uuncheck_if_no_image")}
                                        >
                                            <Checkbox
                                                checked={this.state.hasImage}
                                                onChange={this.changeHasImage}
                                            >
                                                {this.state.hasImage
                                                    ? t("has_image")
                                                    : t("no _image")}
                                            </Checkbox>
                                        </Form.Item>
                                    </div>
                                    {this.state.hasImage && (
                                        <div className="col-md-3 col-sm-12">
                                            <Form.Item
                                                label={t("image")}
                                                tooltip={t(
                                                    "upload_brand_image"
                                                )}
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
                                                            message: t(
                                                                "missing_brand_image"
                                                            ),
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
                                                        onChange={
                                                            this.handleChange
                                                        }
                                                    >
                                                        {this.state.fileList
                                                            .length >=
                                                        1 ? null : (
                                                            <div>
                                                                <PlusOutlined />
                                                                <div
                                                                    style={{
                                                                        marginTop: 8,
                                                                    }}
                                                                >
                                                                    {t(
                                                                        "upload"
                                                                    )}
                                                                </div>
                                                            </div>
                                                        )}
                                                    </Upload>
                                                </Form.Item>
                                                <Modal
                                                    visible={
                                                        this.state
                                                            .previewVisible
                                                    }
                                                    title={
                                                        this.state.previewTitle
                                                    }
                                                    footer={null}
                                                    onCancel={this.handleCancel}
                                                >
                                                    <img
                                                        alt="example"
                                                        style={{
                                                            width: "100%",
                                                        }}
                                                        src={
                                                            this.state
                                                                .previewImage
                                                        }
                                                    />
                                                </Modal>
                                            </Form.Item>
                                        </div>
                                    )}
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

export default withTranslation()(NotificationAdd);
