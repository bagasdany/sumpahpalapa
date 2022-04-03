import React from "react";
import PageLayout from "../../layouts/PageLayout";
import * as moment from "moment";
import {
    Breadcrumb,
    Layout,
    PageHeader,
    Form,
    Input,
    Button,
    InputNumber,
    Upload,
    TimePicker,
    Radio,
    Spin,
    Modal,
    Select,
    Checkbox,
    Tabs,
    message,
} from "antd";
import { Link } from "react-router-dom";
import {
    PlusOutlined, HomeFilled,
} from "@ant-design/icons";
import GoogleMapReact from "google-map-react";
import languageActive from "../../requests/Language/LanguageActive";
import shopSave from "../../requests/Shops/ShopSave";
import shopGet from "../../requests/Shops/ShopGet";
import shopsCategoryActive from "../../requests/ShopCategories/ShopsCategoryActive";
import phonePrefixActive from "../../requests/PhonePrefix/PhonePrefixActive";
import ShopDeliveries from "../ShopDeliveries/ShopDeliveries";
import ShopDeliveriesAdd from "../ShopDeliveries/ShopDeliveriesAdd";
import ShopTransport from "../ShopTransport/ShopTransport";
import ShopTransportAdd from "../ShopTransport/ShopTransportAdd";
import ShopBox from "../ShopBox/ShopBox";
import ShopBoxAdd from "../ShopBox/ShopBoxAdd";
import {GOOGLE_MAP_API_KEY, IMAGE_PATH, IS_DEMO} from "../../global";
import ShopPayments from "../ShopPayments/ShopPayments";
import { withTranslation } from "react-i18next";

const { Option } = Select;
const { Content } = Layout;
const { TextArea } = Input;
const { TabPane } = Tabs;

const AnyReactComponent = ({ lat, lng, text }) => (
    <div>
        <HomeFilled style={{ fontSize: "32px", color: "red" }} />
    </div>
);

class ShopAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            latitude: 59.95,
            longitude: 30.33,
            language: "en",
            languages: [],
            shopsCategories: [],
            names: {},
            descriptions: {},
            infos: {},
            addresses: {},
            phone_prefix: [],
            previewImage: "",
            previewVisible: false,
            previewTitle: "",
            fileList: [],
            fileListBackground: [],
            open_hours: "",
            close_hours: "",
            active: true,
            tab_id: "1",
            shop_deliveries_id: -1,
            shop_transport_id: -1,
            shop_box_id: -1,
            shop_payments_id: -1,
            shop_deliveries_edit: false,
            shop_transport_edit: false,
            shop_box_edit: false,
            is_closed: false,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.onClickMap = this.onClickMap.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.getActiveLanguages = this.getActiveLanguages.bind(this);
        this.onChangeName = this.onChangeName.bind(this);
        this.onChangeDescription = this.onChangeDescription.bind(this);
        this.onChangeAddress = this.onChangeAddress.bind(this);
        this.onChangeInfo = this.onChangeInfo.bind(this);
        this.onChangeOpenHours = this.onChangeOpenHours.bind(this);
        this.onChangeCloseHours = this.onChangeCloseHours.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.changeClosed = this.changeClosed.bind(this);

        this.getActiveLanguages();
        this.getActiveShopCategories();
        this.getActivePhonePrefix();
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
    }

    getInfoById = async (id) => {
        let data = await shopGet(id);
        if (data.data.success) {
            let shops = data.data.data;
            let shops_language = data.data.data["languages"];

            var namesArray = this.state.names;
            var descriptionsArray = this.state.descriptions;
            var addressesArray = this.state.addresses;
            var infoArray = this.state.infos;
            for (let i = 0; i < shops_language.length; i++) {
                var lang = shops_language[i].language.short_name;
                descriptionsArray[lang] = shops_language[i].description;
                namesArray[lang] = shops_language[i].name;
                addressesArray[lang] = shops_language[i].address;
                infoArray[lang] = shops_language[i].info;
            }

            var ppdata = this.getPrefixFromPhone(shops.phone);

            var phone = ppdata.phone;
            var prefix = ppdata.prefix;

            var ppdata2 = this.getPrefixFromPhone(shops.mobile);

            var phone2 = ppdata2.phone;
            var prefix2 = ppdata2.prefix;

            this.setState({
                names: namesArray,
                descriptions: descriptionsArray,
                addresses: addressesArray,
                infos: infoArray,
                fileList: [
                    {
                        uid: "-1",
                        name: shops.logo_url,
                        status: "done",
                        url: IMAGE_PATH + shops.logo_url,
                    },
                ],
                fileListBackground: [
                    {
                        uid: "-2",
                        name: shops.backimage_url,
                        status: "done",
                        url: IMAGE_PATH + shops.backimage_url,
                    },
                ],
                open_hours: shops.open_hour,
                close_hours: shops.close_hour,
                active: shops.active == 1 ? true : false,
                is_closed: shops.is_closed == 1 ? true : false,
                latitude: shops.latitude,
                longitude: shops.longtitude,
            });

            this.formRef.current.setFieldsValue({
                name: namesArray[this.state.language],
                description: descriptionsArray[this.state.language],
                address: addressesArray[this.state.language],
                info: infoArray[this.state.language],
                prefix_phone: prefix,
                phone: phone,
                prefix_mobile: prefix2,
                mobile: phone2,
                dragger: this.state.fileList,
                dragger2: this.state.fileListBackground,
                commission: shops.admin_percentage,
                delivery_fee: shops.delivery_price,
                delivery_range: shops.delivery_range,
                // tax: shops.tax,
                delivery_type: shops.delivery_type.toString(),
                feature_type: shops.show_type.toString(),
                open_hours: moment(shops.open_hour, "HH:mm:ss"),
                close_hours: moment(shops.close_hour, "HH:mm:ss"),
                amount_limit: parseFloat(shops.amount_limit)
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
                    prefix_mobile: data.data.data[0].prefix,
                });
        }
    };

    getActiveShopCategories = async () => {
        let data = await shopsCategoryActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                shopsCategories: data.data.data,
            });

            if (this.formRef.current != null)
                this.formRef.current.setFieldsValue({
                    shop_categories: data.data.data[0].id,
                });
        } else {
            message.info("Please, add shop category first");
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
            var descriptionsArray = this.state.descriptions;
            var addressesArray = this.state.addresses;
            var infoArray = this.state.infos;
            for (let i = 0; i < data.data.data.length; i++) {
                var lang = data.data.data[i].short_name;
                descriptionsArray[lang] = "";
                namesArray[lang] = "";
                addressesArray[lang] = "";
                infoArray[lang] = "";
            }

            this.setState({
                names: namesArray,
                descriptions: descriptionsArray,
                addresses: addressesArray,
                infos: infoArray,
            });
        }
    };

    onChangeOpenHours = (time, timeString) => {
        this.setState({
            open_hours: timeString,
        });
    };

    onChangeCloseHours = (time, timeString) => {
        this.setState({
            close_hours: timeString,
        });
    };

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

    onChangeAddress = (e) => {
        var addressesArray = this.state.addresses;
        addressesArray[this.state.language] = e.target.value;
        this.setState({
            addresses: addressesArray,
        });
    };

    onChangeInfo = (e) => {
        var infosArray = this.state.infos;
        infosArray[this.state.language] = e.target.value;
        this.setState({
            infos: infosArray,
        });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        var params = {
            names: this.state.names,
            descriptions: this.state.descriptions,
            addresses: this.state.addresses,
            infos: this.state.infos,
            latitude: this.state.latitude,
            longitude: this.state.longitude,
            commission: 0,//values.commission,
            delivery_fee: values.delivery_fee,
            delivery_range: values.delivery_range,
            mobile: values.prefix_mobile + " " + values.mobile,
            phone: values.prefix_phone + " " + values.phone,
            // tax: values.tax,
            amount_limit: values.amount_limit,
            delivery_type: values.delivery_type,
            feature_type: values.feature_type,
            close_hours: this.state.close_hours,
            open_hours: this.state.open_hours,
            active: this.state.active,
            is_closed: this.state.is_closed,
            logo_url: this.state.fileList[0].name,
            back_image_url: this.state.fileListBackground[0].name,
            id: this.state.id,
            shop_categories_id: values.shop_categories,
        };

        let data = await shopSave(params);
        if (data.data.success == 1) window.history.back();
    };

    onFinishFailed = (errorInfo) => {};

    normFile = (e) => {
        if (Array.isArray(e)) {
            return e;
        }

        return e && e.fileList;
    };

    onClickMap = (position) => {
        this.setState({
            latitude: position.lat,
            longitude: position.lng,
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
            address: this.state.addresses[lang],
            info: this.state.infos[lang],
        });
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

    handleChangeBackground = ({ fileList }) => {
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

        this.setState({ fileListBackground: fileList });
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    changeClosed = (e) => {
        this.setState({
            is_closed: e.target.checked,
        });
    };

    onChangeTab = (e) => {
        this.setState({
            tab_id: e,
        });
    };
    onSaveShopDeliveries = () => {
        this.setState({
            shop_deliveries_edit: false,
        });
    };
    onEditShopDeliveries = (id) => {
        this.setState({
            shop_deliveries_id: id,
            shop_deliveries_edit: true,
        });
    };
    onEditShopPayments = (id) => {
        this.setState({
            shop_payments_id: id,
        });
    };
    onEditShopTransport = (id) => {
        this.setState({
            shop_transport_id: id,
            shop_transport_edit: true,
        });
    };
    onSaveShopTransport = () => {
        this.setState({
            shop_transport_edit: false,
        });
    };
    onEditShopBox = (id) => {
        this.setState({
            shop_box_id: id,
            shop_box_edit: true,
        });
    };
    onSaveShopBox = () => {
        this.setState({
            shop_box_edit: false,
        });
    };
    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/shops" className="nav-text">
                            {t("shops")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={this.state.edit ? t("shops_edit") : t("shops_add")}
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.shopsCategories.length > 0 ? (
                            <Tabs
                                defaultActiveKey={this.state.tab_id}
                                onChange={this.onChangeTab}
                            >
                                <TabPane tab={t("shop")} key="1">
                                    <Form
                                        ref={this.formRef}
                                        name="basic"
                                        initialValues={{
                                            feature_type: "1",
                                            delivery_type: "1",
                                            shop_categories:
                                                this.state.shopsCategories[0]
                                                    .id,
                                        }}
                                        layout="vertical"
                                        onFinish={this.onFinish}
                                        onFinishFailed={this.onFinishFailed}
                                    >
                                        <div className="row">
                                            <div className="col-md-12 col-sm-12">
                                                <Radio.Group
                                                    value={this.state.language}
                                                    onChange={
                                                        this.onChangeLanguage
                                                    }
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
                                                    label={t("shop_categories")}
                                                    name="shop_categories"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_categories"
                                                            ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "select_shop_categories"
                                                    )}
                                                >
                                                    <Select
                                                        placeholder={t(
                                                            "select_shop_categories"
                                                        )}
                                                    >
                                                        {this.state.shopsCategories.map(
                                                            (item) => {
                                                                return (
                                                                    <Option
                                                                        value={
                                                                            item.id
                                                                        }
                                                                        key={
                                                                            item.id
                                                                        }
                                                                    >
                                                                        {
                                                                            item.name
                                                                        }
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
                                                            message:
                                                                t(
                                                                    "missing_shop_name"
                                                                ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_name"
                                                    )}
                                                >
                                                    <Input
                                                        placeholder={t("name")}
                                                        onChange={
                                                            this.onChangeName
                                                        }
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
                                                                "missing_shop_description"
                                                            ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_description"
                                                    )}
                                                >
                                                    <TextArea
                                                        onChange={
                                                            this
                                                                .onChangeDescription
                                                        }
                                                    />
                                                </Form.Item>
                                            </div>

                                            <div className="col-md-6 col-sm-12">
                                                <Form.Item
                                                    label={t("info")}
                                                    name="info"
                                                    tooltip={t(
                                                        "enter_shop_info"
                                                    )}
                                                >
                                                    <TextArea
                                                        onChange={
                                                            this.onChangeInfo
                                                        }
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-6 col-sm-12">
                                                <Form.Item
                                                    label={t("address")}
                                                    name="address"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_address"
                                                            ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_address"
                                                    )}
                                                >
                                                    <Input
                                                        placeholder={t(
                                                            "address"
                                                        )}
                                                        onChange={
                                                            this.onChangeAddress
                                                        }
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-6 col-sm-12">
                                                <Form.Item
                                                    label={t("phone")}
                                                    name="phone"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message:
                                                                t(
                                                                    "missing_shop_phone"
                                                                ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_phone"
                                                    )}
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
                                                                        (
                                                                            item
                                                                        ) => {
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
                                                    label={t("mobile")}
                                                    name="mobile"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_mobile_phone"
                                                            ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_mobile_phone"
                                                    )}
                                                >
                                                    <Input
                                                        placeholder={t(
                                                            "mobile"
                                                        )}
                                                        addonBefore={
                                                            <Form.Item
                                                                name="prefix_mobile"
                                                                noStyle
                                                            >
                                                                <Select
                                                                    style={{
                                                                        width: 100,
                                                                    }}
                                                                >
                                                                    {this.state.phone_prefix.map(
                                                                        (
                                                                            item
                                                                        ) => {
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
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    label={t("amount_limit")}
                                                    name="amount_limit"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_amount_limit"
                                                            ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_amount_limit"
                                                    )}
                                                >
                                                    <InputNumber
                                                        placeholder={t(
                                                            "amount_limit"
                                                        )}
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    label={t("delivery_range")}
                                                    name="delivery_range"
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_delivery_range"
                                                            ),
                                                        },
                                                    ]}
                                                    tooltip={t(
                                                        "enter_shop_delivery_range"
                                                    )}
                                                >
                                                    <InputNumber
                                                        placeholder={t(
                                                            "delivery_range"
                                                        )}
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    label={t("logo")}
                                                    tooltip={t(
                                                        "upload_shop_logo"
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
                                                                    "missing_shop_logo_image"
                                                                ),
                                                            },
                                                        ]}
                                                        noStyle
                                                    >
                                                        <Upload
                                                            action="/api/auth/upload"
                                                            listType="picture-card"
                                                            fileList={
                                                                this.state
                                                                    .fileList
                                                            }
                                                            defaultFileList={
                                                                this.state
                                                                    .fileList
                                                            }
                                                            onPreview={
                                                                this
                                                                    .handlePreview
                                                            }
                                                            onChange={
                                                                this
                                                                    .handleChange
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
                                                            this.state
                                                                .previewTitle
                                                        }
                                                        footer={null}
                                                        onCancel={
                                                            this.handleCancel
                                                        }
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
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    label={t(
                                                        "background_image"
                                                    )}
                                                    tooltip={t(
                                                        "upload_shop_background_image"
                                                    )}
                                                >
                                                    <Form.Item
                                                        name="dragger2"
                                                        valuePropName="fileListBackground"
                                                        getValueFromEvent={
                                                            this.normFile
                                                        }
                                                        rules={[
                                                            {
                                                                required: true,
                                                                message: t(
                                                                    "missing_shop_background_image"
                                                                ),
                                                            },
                                                        ]}
                                                        noStyle
                                                    >
                                                        <Upload
                                                            action="/api/auth/upload"
                                                            listType="picture-card"
                                                            fileList={
                                                                this.state
                                                                    .fileListBackground
                                                            }
                                                            defaultFileList={
                                                                this.state
                                                                    .fileListBackground
                                                            }
                                                            onPreview={
                                                                this
                                                                    .handlePreview
                                                            }
                                                            onChange={
                                                                this
                                                                    .handleChangeBackground
                                                            }
                                                        >
                                                            {this.state
                                                                .fileListBackground
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
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    name="open_hours"
                                                    label={t("open_hours")}
                                                    tooltip={t(
                                                        "enter_shop_open_hours"
                                                    )}
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_open_hours"
                                                            ),
                                                        },
                                                    ]}
                                                >
                                                    <TimePicker
                                                        placeholder={t(
                                                            "select_time"
                                                        )}
                                                        onChange={
                                                            this
                                                                .onChangeOpenHours
                                                        }
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    name="close_hours"
                                                    label={t("close_hours")}
                                                    tooltip={t(
                                                        "enter_shop_close_hours"
                                                    )}
                                                    rules={[
                                                        {
                                                            required: true,
                                                            message: t(
                                                                "missing_shop_close_hours"
                                                            ),
                                                        },
                                                    ]}
                                                >
                                                    <TimePicker
                                                        placeholder={t(
                                                            "select_time"
                                                        )}
                                                        onChange={
                                                            this
                                                                .onChangeCloseHours
                                                        }
                                                    />
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    name="delivery_type"
                                                    label={t("delivery_type")}
                                                    tooltip={t(
                                                        "enter_shop_delivery_type"
                                                    )}
                                                >
                                                    <Radio.Group>
                                                        <Radio value="1">
                                                            {t("delivery")}
                                                        </Radio>
                                                        <Radio value="2">
                                                            {t("pickup")}
                                                        </Radio>
                                                        <Radio value="3">
                                                            {t("delivery")} &{" "}
                                                            {t("pickup")}
                                                        </Radio>
                                                    </Radio.Group>
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    name="feature_type"
                                                    label={t("feature_type")}
                                                    tooltip={t(
                                                        "enter_shop_feature_type"
                                                    )}
                                                >
                                                    <Radio.Group>
                                                        <Radio value="1">
                                                            {t("default")}
                                                        </Radio>
                                                        <Radio value="2">
                                                            {t("new")}
                                                        </Radio>
                                                        <Radio value="3">
                                                            {t("top")}
                                                        </Radio>
                                                    </Radio.Group>
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    label={t("status")}
                                                    name="active"
                                                    tooltip={t(
                                                        "uncheck_if_shop_is_inactive"
                                                    )}
                                                >
                                                    <Checkbox
                                                        checked={
                                                            this.state.active
                                                        }
                                                        onChange={
                                                            this.changeStatus
                                                        }
                                                    >
                                                        {this.state.active
                                                            ? t("active")
                                                            : t("inactive")}
                                                    </Checkbox>
                                                </Form.Item>
                                            </div>
                                            <div className="col-md-3 col-sm-6">
                                                <Form.Item
                                                    label={t("closed")}
                                                    name="closed"
                                                    tooltip={t(
                                                        "check_if_shop_is_closed"
                                                    )}
                                                >
                                                    <Checkbox
                                                        checked={
                                                            this.state.is_closed
                                                        }
                                                        onChange={
                                                            this.changeClosed
                                                        }
                                                    >
                                                        {this.state.is_closed
                                                            ? t("closed")
                                                            : t("open")}
                                                    </Checkbox>
                                                </Form.Item>
                                            </div>
                                            <div
                                                className="col-md-12 col-sm-12 mb-3"
                                                style={{ height: "500px" }}
                                            >
                                                <label className="defaultLabel">
                                                    {t("select_shop_location")}
                                                </label>
                                                <GoogleMapReact
                                                    bootstrapURLKeys={{
                                                        key: GOOGLE_MAP_API_KEY,
                                                    }}
                                                    defaultCenter={{
                                                        lat: 59.95,
                                                        lng: 30.33,
                                                    }}
                                                    defaultZoom={11}
                                                    onClick={this.onClickMap}
                                                >
                                                    <AnyReactComponent
                                                        lat={
                                                            this.state.latitude
                                                        }
                                                        lng={
                                                            this.state.longitude
                                                        }
                                                        text={t("new_location")}
                                                    />
                                                </GoogleMapReact>
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
                                </TabPane>
                                {this.state.id > 0 && (
                                    <>
                                        <TabPane
                                            tab={t("shop_deliveries")}
                                            key="2"
                                        >
                                            <>
                                                {this.state
                                                    .shop_deliveries_edit ? (
                                                    <ShopDeliveriesAdd
                                                        shop_id={this.state.id}
                                                        id={
                                                            this.state
                                                                .shop_deliveries_id
                                                        }
                                                        onSave={
                                                            this
                                                                .onSaveShopDeliveries
                                                        }
                                                    />
                                                ) : (
                                                    <ShopDeliveries
                                                        shop_id={this.state.id}
                                                        onEdit={
                                                            this
                                                                .onEditShopDeliveries
                                                        }
                                                    />
                                                )}
                                            </>
                                        </TabPane>
                                        <TabPane
                                            tab={t("shop_transports")}
                                            key="3"
                                        >
                                            <>
                                                {this.state
                                                    .shop_transport_edit ? (
                                                    <ShopTransportAdd
                                                        shop_id={this.state.id}
                                                        id={
                                                            this.state
                                                                .shop_transport_id
                                                        }
                                                        onSave={
                                                            this
                                                                .onSaveShopTransport
                                                        }
                                                    />
                                                ) : (
                                                    <ShopTransport
                                                        shop_id={this.state.id}
                                                        onEdit={
                                                            this
                                                                .onEditShopTransport
                                                        }
                                                    />
                                                )}
                                            </>
                                        </TabPane>
                                        <TabPane tab={t("shop_box")} key="4">
                                            <>
                                                {this.state.shop_box_edit ? (
                                                    <ShopBoxAdd
                                                        shop_id={this.state.id}
                                                        id={
                                                            this.state
                                                                .shop_box_id
                                                        }
                                                        onSave={
                                                            this.onSaveShopBox
                                                        }
                                                    />
                                                ) : (
                                                    <ShopBox
                                                        shop_id={this.state.id}
                                                        onEdit={
                                                            this.onEditShopBox
                                                        }
                                                    />
                                                )}
                                            </>
                                        </TabPane>
                                        <TabPane
                                            tab={t("shop_payments")}
                                            key="5"
                                        >
                                            <ShopPayments
                                                shop_id={this.state.id}
                                                onEdit={this.onEditShopPayments}
                                            />
                                        </TabPane>
                                    </>
                                )}
                            </Tabs>
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

export default withTranslation()(ShopAdd);
