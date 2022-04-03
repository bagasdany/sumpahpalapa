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
import shopTransportSave from "../../requests/ShopTransport/ShopTransportSave";
import shopTransportGet from "../../requests/ShopTransport/ShopTransportGet";
import shopTransportActive from "../../requests/ShopTransport/ShopTransportActive";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";
const { Option } = Select;

class ShopTransportAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            active: true,
            default: true,
            deliveryTransports: [],
            id: props.id,
            delivery_transport_id: 1,
            shop_id: props.shop_id,
            price: 0,
            edit: props.id > 0 ? true : false,
        };

        this.onChangeDeliveryType = this.onChangeDeliveryType.bind(this);
        this.onChangeType = this.onChangeType.bind(this);
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
        this.getActiveDeliveryTransport();
    }

    getInfoById = async (id) => {
        let data = await shopTransportGet(id);
        if (data.data.success) {
            this.setState({
                active: data.data.data.active == 1 ? true : false,
                default: data.data.data.default == 1 ? true : false,
                delivery_transport_id: data.data.data.delivery_transport_id,
                price: data.data.data.price,
            });

            this.formRef.current.setFieldsValue({
                delivery_transport_id: data.data.data.delivery_transport_id,
                price: data.data.data.price,
            });
        }
    };
    getActiveDeliveryTransport = async () => {
        const data = await shopTransportActive();
        this.setState({
            deliveryTransports: data.data.data.map((item) => ({
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

        let data = await shopTransportSave({
            ...values,
            shop_id: this.state.shop_id,
            active: this.state.active ? 1 : 0,
            defaultValue: this.state.default ? 1 : 0,
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
    onChangeDeliveryType = (e) => {
        console.log(e.target.value);
        this.setState({
            delivery_type_id: e.target.value,
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
                title={
                    this.state.edit
                        ? t("shop_transport_edit")
                        : t("shop_transport_add")
                }
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
                                    label={t("delivery_transport")}
                                    name="delivery_transport_id"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_delivery_type"),
                                        },
                                    ]}
                                    tooltip={t("select_delivery_transport")}
                                >
                                    <Select
                                        placeholder={t(
                                            "select_delivery_transport"
                                        )}
                                    >
                                        {this.state.deliveryTransports?.map(
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
                                    <InputNumber
                                        placeholder={t("price")}
                                        // onChange={this.onChangeAmount}
                                    />
                                </Form.Item>
                            </div>

                            <div className="col-md-3 col-sm-6">
                                <Form.Item
                                    label={t("default")}
                                    name="default"
                                    tooltip={t(
                                        "uncheck_if_shop_transport_is_inactive"
                                    )}
                                >
                                    <Checkbox
                                        checked={this.state.default}
                                        onChange={this.changeDefault}
                                    >
                                        {this.state.default
                                            ? t("default")
                                            : t("no_default")}
                                    </Checkbox>
                                </Form.Item>
                            </div>
                            <div className="col-md-3 col-sm-6">
                                <Form.Item
                                    label={t("status")}
                                    name="active"
                                    tooltip={t(
                                        "uncheck_if_shop_transport_is_inactive"
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

export default withTranslation()(ShopTransportAdd);
