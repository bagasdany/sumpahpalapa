import React from "react";
import {
    PageHeader,
    Checkbox,
    Form,
    Input,
    Select,
    Button,
    Card,
    InputNumber, message,
} from "antd";
import shopBoxSave from "../../requests/ShopBox/ShopBoxSave";
import shopBoxGet from "../../requests/ShopBox/ShopBoxGet";
import shopBoxActive from "../../requests/ShopBox/ShopBoxActive";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";
const { Option } = Select;

class ShopBoxAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            active: true,
            shippingBoxes: [],
            id: props.id,
            shipping_box_id: 1,
            shop_id: props.shop_id,
            price: 0,
            end: 0,
            start: 0,
            edit: props.id > 0 ? true : false,
        };

        this.onChangeShippingBox = this.onChangeShippingBox.bind(this);
        this.onChangeType = this.onChangeType.bind(this);
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
        this.getActiveShippingBox();
    }

    getInfoById = async (id) => {
        let data = await shopBoxGet(id);
        if (data.data.success) {
            this.setState({
                active: data.data.data.active == 1 ? true : false,
                shipping_box_id: data.data.data.shipping_box_id,
                price: data.data.data.price,
                end: data.data.data.end,
                start: data.data.data.start,
            });

            this.formRef.current.setFieldsValue({
                shipping_box_id: data.data.data.shipping_box_id,
                price: data.data.data.price,
                end: data.data.data.end,
                start: data.data.data.start,
            });
        }
    };
    getActiveShippingBox = async () => {
        const data = await shopBoxActive();
        this.setState({
            shippingBoxes: data.data.data.map((item) => ({
                id: item.id,
                name: item?.language.name,
            })),
        });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await shopBoxSave({
            ...values,
            shop_id: this.state.shop_id,
            active: this.state.active ? 1 : 0,
            id: this.state.id,
        });
        // console.log(values);
        if (data.data.success == 1) {
            this.props.onSave();
        }
    };

    onFinishFailed = (errorInfo) => {};

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };
    changeDefault = (e) => {
        this.setState({
            default: e.target.checked,
        });
    };
    onChangeShippingBox = (e) => {
        this.setState({
            shipping_box_id: e.target.value,
        });
    };
    onChangeType = (e) => {
        this.setState({
            type: e,
        });
    };
    render() {
        const { t } = this.props;
        return (
            <PageHeader
                onBack={() => this.props.onSave()}
                className="site-page-header"
                title={this.state.edit ? t("shop_box_edit") : t("shop_box_add")}
            >
                <Form
                    ref={this.formRef}
                    name="basic"
                    initialValues={{ type: 1 }}
                    layout="vertical"
                    onFinish={this.onFinish}
                    onFinishFailed={this.onFinishFailed}
                >
                    <Card style={{ marginTop: "20px" }}>
                        <div className="row">
                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("shipping_box")}
                                    name="shipping_box_id"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_shipping_box"),
                                        },
                                    ]}
                                    tooltip={t("select_shipping_box")}
                                >
                                    <Select
                                        placeholder={t("select_shipping_box")}
                                    >
                                        {this.state.shippingBoxes?.map(
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
                                    label={t("price")}
                                    name="price"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_price"),
                                        },
                                    ]}
                                    tooltip={t("enter_price")}
                                >
                                    <InputNumber placeholder={t("price")} />
                                </Form.Item>
                            </div>
                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("start")}
                                    name="start"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_start"),
                                        },
                                    ]}
                                    tooltip={t("enter_start")}
                                >
                                    <InputNumber placeholder={t("start")} />
                                </Form.Item>
                            </div>
                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("end")}
                                    name="end"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_end"),
                                        },
                                    ]}
                                    tooltip={t("enter_end")}
                                >
                                    <InputNumber placeholder={t("end")} />
                                </Form.Item>
                            </div>

                            <div className="col-md-3 col-sm-6">
                                <Form.Item label={t("status")} name="active">
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
                    </Card>
                    <Form.Item>
                        <Button
                            type="primary"
                            className="btn-success"
                            style={{
                                marginTop: "40px",
                            }}
                            htmlType="submit"
                        >
                            {t("save")}
                        </Button>
                    </Form.Item>
                </Form>
            </PageHeader>
        );
    }
}

export default withTranslation()(ShopBoxAdd);
