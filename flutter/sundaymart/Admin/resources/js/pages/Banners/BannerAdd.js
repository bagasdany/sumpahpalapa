import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout,
    message,
    Modal,
    PageHeader,
    Radio,
    Select,
    Spin,
    Upload,
} from "antd";
import { Link } from "react-router-dom";
import { SketchPicker } from "react-color";
import PageLayout from "../../layouts/PageLayout";
import { PlusOutlined } from "@ant-design/icons";
import shopActive from "../../requests/Shops/ShopActive";
import languageActive from "../../requests/Language/LanguageActive";
import productActive from "../../requests/Products/ProductActive";
import bannerSave from "../../requests/Banners/BannerSave";
import bannerGet from "../../requests/Banners/BannerGet";
import { CKEditor } from "@ckeditor/ckeditor5-react";
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
import { withTranslation } from 'react-i18next';
import {IMAGE_PATH, IS_DEMO} from "../../global";

const { Option } = Select;
const { Content } = Layout;
const { TextArea } = Input;

class BannerAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            previewImage: "",
            previewVisible: false,
            previewTitle: "",
            fileList: [],
            shops: [],
            shop_id: -1,
            category_id: -1,
            language: "en",
            languages: [],
            products: [],
            names: {},
            name: "",
            description: "",
            button_text: "",
            descriptions: {},
            subTitles: {},
            button_texts: {},
            isConnectedToProduct: false,
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
            title_color: "#fff",
            button_color: "#fff",
            indicator_color: "#fff",
            background_color: "#fff",
        };

        this.getActiveShops = this.getActiveShops.bind(this);
        this.getActiveProducts = this.getActiveProducts.bind(this);
        this.getActiveLanguages = this.getActiveLanguages.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.changeConnectedToProduct =
            this.changeConnectedToProduct.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.onChangeName = this.onChangeName.bind(this);
        this.onChangeDescription = this.onChangeDescription.bind(this);
        this.onChangeSubTitles = this.onChangeSubTitles.bind(this);
        this.onChangeShop = this.onChangeShop.bind(this);
        this.getInfoById = this.getInfoById.bind(this);
        this.handleChangeTitleColor = this.handleChangeTitleColor.bind(this);
        this.handleChangeButtonColor = this.handleChangeButtonColor.bind(this);
        this.handleChangeIndicatorColor =
            this.handleChangeIndicatorColor.bind(this);
        this.handleChangeBackgroundColor =
            this.handleChangeBackgroundColor.bind(this);

        this.getActiveLanguages();
        this.getActiveShops();
    }

    handleChangeTitleColor = (color) => {
        this.setState({ title_color: color.hex });
    };

    handleChangeButtonColor = (color) => {
        this.setState({ button_color: color.hex });
    };

    handleChangeIndicatorColor = (color) => {
        this.setState({ indicator_color: color.hex });
    };

    handleChangeBackgroundColor = (color) => {
        this.setState({ background_color: color.hex });
    };

    getInfoById = async (id) => {
        let data = await bannerGet(id);
        if (data.data.success) {
            let banner = data.data.data;
            let banner_language = data.data.data["languages"];
            let banner_products = data.data.data["products"];

            var namesArray = this.state.names;
            var descriptionsArray = this.state.descriptions;
            var subTitlesArray = this.state.subTitles;
            var buttonTextsArray = this.state.button_texts;
            for (let i = 0; i < banner_language.length; i++) {
                var lang = banner_language[i].language.short_name;
                namesArray[lang] = banner_language[i].title ?? "";
                descriptionsArray[lang] = banner_language[i].description ?? "";
                subTitlesArray[lang] = banner_language[i].sub_title ?? "";
                buttonTextsArray[lang] = banner_language[i].button_text ?? "";
            }

            this.setState({
                active: banner.active == 1 ? true : false,
                names: namesArray,
                descriptions: descriptionsArray,
                subTitles: subTitlesArray,
                button_texts: buttonTextsArray,
                shop_id: banner.id_shop,
                category_id: banner.parent,
                title_color: banner.title_color,
                button_color: banner.button_color,
                indicator_color: banner.indicator_color,
                background_color: banner.background_color,
                fileList: [
                    {
                        uid: "-1",
                        name: banner.image_url,
                        status: "done",
                        url: IMAGE_PATH + banner.image_url,
                    },
                ],
                isConnectedToProduct: banner_products.length > 0 ? true : false,
            });

            var productsArray = [];
            if (banner_products.length > 0) {
                for (var i = 0; i < banner_products.length; i++) {
                    productsArray.push(
                        banner_products[i].id_product.toString()
                    );
                }
            }

            this.formRef.current.setFieldsValue({
                dragger: this.state.fileList,
                name: namesArray[this.state.language],
                description: descriptionsArray[this.state.language],
                sub_titles: subTitlesArray[this.state.language],
                button_text: buttonTextsArray[this.state.language],
                shop: banner.id_shop,
                position: banner.position,
                products: productsArray,
                title_color: banner.title_color,
                button_color: banner.button_color,
                indicator_color: banner.indicator_color,
                background_color: banner.background_color,
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
            var desriptionArray = this.state.descriptions;
            var subTitlesArray = this.state.subTitles;
            var buttonTextArray = this.state.button_texts;

            for (let i = 0; i < data.data.data.length; i++) {
                var lang = data.data.data[i].short_name;
                namesArray[lang] = "";
                desriptionArray[lang] = "";
                subTitlesArray[lang] = "";
                buttonTextArray[lang] = "";
            }

            this.setState({
                names: namesArray,
                descriptions: desriptionArray,
                subTitles: subTitlesArray,
                button_texts: buttonTextArray,
            });

            if (this.state.edit) this.getInfoById(this.state.id);
        }
    };

    getActiveShops = async () => {
        let data = await shopActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                shops: data.data.data,
                shop_id: data.data.data[0].id,
            });

            this.getActiveProducts(data.data.data[0].id);

            if (this.formRef.current)
                this.formRef.current.setFieldsValue({
                    shop: data.data.data[0].id,
                });
        }
    };

    getActiveProducts = async (shop_id) => {
        let data = await productActive(shop_id);
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                products: data.data.data,
            });
        }
    };

    onChangeShop = (e) => {
        this.setState({
            shop_id: e,
        });

        this.getActiveProducts(e);
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    changeConnectedToProduct = (e) => {
        this.setState({
            isConnectedToProduct: e.target.checked,
        });
    };

    onChangeName = (e) => {
        var namesArray = this.state.names;
        namesArray[this.state.language] = e.target.value;
        this.setState({
            names: namesArray,
        });
    };

    onChangeButtonText = (e) => {
        var buttonTextsArray = this.state.button_texts;
        buttonTextsArray[this.state.language] = e.target.value;
        this.setState({
            button_texts: buttonTextsArray,
        });
    };

    onChangeDescription = (event, editor) => {
        const data = editor.getData();

        var descriptionsArray = this.state.descriptions;
        descriptionsArray[this.state.language] = data;
        this.setState({
            descriptions: descriptionsArray,
        });
    };

    onChangeSubTitles = (e) => {
        var subTitlesArray = this.state.subTitles;
        subTitlesArray[this.state.language] = e.target.value;
        this.setState({
            subTitles: subTitlesArray,
        });
    };

    onChangeLanguage = (e) => {
        let lang = e.target.value;
        this.setState({
            language: lang,
        });

        if (this.formRef.current)
            this.formRef.current.setFieldsValue({
                name: this.state.names[lang],
                description: this.state.descriptions[lang],
                sub_titles: this.state.subTitles[lang],
                button_text: this.state.button_texts[lang],
            });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await bannerSave(
            this.state.names,
            this.state.descriptions,
            this.state.subTitles,
            this.state.button_texts,
            values.shop,
            this.state.fileList[0].name,
            values.content_position,
            this.state.title_color,
            this.state.button_color,
            this.state.indicator_color,
            this.state.background_color,
            values.products,
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

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/banners" className="nav-text">
                            {t("banners")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={this.state.edit ? t("banner_edit") : t("banner_add")}
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.languages.length > 0 ? (
                            <Form
                                ref={this.formRef}
                                name="basic"
                                initialValues={{
                                    content_position: 1,
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
                                            label={t("title")}
                                            name="name"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: "Missing title",
                                                },
                                            ]}
                                            tooltip={t("enter_title")}
                                        >
                                            <Input
                                                placeholder={t("title")}
                                                onChange={this.onChangeName}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("sub_title")}
                                            name="sub_titles"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing sub title",
                                                },
                                            ]}
                                            tooltip={t("enter_sub_title")}
                                        >
                                            <Input
                                                placeholder={t("sub_title")}
                                                onChange={
                                                    this.onChangeSubTitles
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("button_text")}
                                            name="button_text"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing button text",
                                                },
                                            ]}
                                            tooltip={t("enter_button_text")}
                                        >
                                            <Input
                                                placeholder={t("button_text")}
                                                onChange={
                                                    this.onChangeButtonText
                                                }
                                            />
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
                                                data={
                                                    this.state.descriptions[
                                                        this.state.language
                                                    ]
                                                }
                                                onChange={
                                                    this.onChangeDescription
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-12">
                                        <Form.Item
                                            label={t("banner_image")}
                                            tooltip={t("upload_shop_logo")}
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
                                                            "Missing banner image",
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
                                    <div className="col-md-3 col-sm-12">
                                        <Form.Item
                                            label={t("content_position")}
                                            name="content_position"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing content position",
                                                },
                                            ]}
                                            tooltip={t(
                                                "select_content_position"
                                            )}
                                        >
                                            <Select
                                                placeholder={t(
                                                    "select_content_position"
                                                )}
                                            >
                                                <Option value={1} key={1}>
                                                    {t("left")}
                                                </Option>
                                                <Option value={2} key={2}>
                                                    {t("right")}
                                                </Option>
                                            </Select>
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label="Shop"
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
                                                onChange={this.onChangeShop}
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
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("title_color")}
                                            name="title_color"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing title color",
                                                },
                                            ]}
                                            tooltip={t("select_title_color")}
                                        >
                                            <SketchPicker
                                                color={this.state.title_color}
                                                onChangeComplete={
                                                    this.handleChangeTitleColor
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("button_color")}
                                            name="button_color"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing button color",
                                                },
                                            ]}
                                            tooltip={t("select_button_color")}
                                        >
                                            <SketchPicker
                                                color={this.state.button_color}
                                                onChangeComplete={
                                                    this.handleChangeButtonColor
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("indicator_color")}
                                            name="indicator_color"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing indicator color",
                                                },
                                            ]}
                                            tooltip={t(
                                                "select_indicator_color"
                                            )}
                                        >
                                            <SketchPicker
                                                color={
                                                    this.state.indicator_color
                                                }
                                                onChangeComplete={
                                                    this
                                                        .handleChangeIndicatorColor
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("background_color")}
                                            name="background_color"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        "Missing background color",
                                                },
                                            ]}
                                            tooltip={t(
                                                "select_background_color"
                                            )}
                                        >
                                            <SketchPicker
                                                color={
                                                    this.state.background_color
                                                }
                                                onChangeComplete={
                                                    this
                                                        .handleChangeBackgroundColor
                                                }
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("connected_to_product")}
                                            name="connect_product"
                                            tooltip={t(
                                                "uncheck_if_products_is_not_connected"
                                            )}
                                        >
                                            <Checkbox
                                                checked={
                                                    this.state
                                                        .isConnectedToProduct
                                                }
                                                onChange={
                                                    this
                                                        .changeConnectedToProduct
                                                }
                                            >
                                                {this.state.isConnectedToProduct
                                                    ? t("connected")
                                                    : t("not_connected")}
                                            </Checkbox>
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("status")}
                                            name="active"
                                            tooltip={t(
                                                "uncheck_if_banner_is_inactive"
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
                                    {this.state.isConnectedToProduct && (
                                        <div className="col-md-6 col-sm-12">
                                            <Form.Item
                                                label={t("products")}
                                                name="products"
                                                tooltip={t("select_products")}
                                            >
                                                <Select
                                                    placeholder={t(
                                                        "select_products"
                                                    )}
                                                    mode="tags"
                                                >
                                                    {this.state.products.map(
                                                        (item) => {
                                                            return (
                                                                <Option
                                                                    value={item.id.toString()}
                                                                    key={
                                                                        item.id
                                                                    }
                                                                >
                                                                    {item.name}
                                                                </Option>
                                                            );
                                                        }
                                                    )}
                                                </Select>
                                            </Form.Item>
                                        </div>
                                    )}
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

export default withTranslation()(BannerAdd);
