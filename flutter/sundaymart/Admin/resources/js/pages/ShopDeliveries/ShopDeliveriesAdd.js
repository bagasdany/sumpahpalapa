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
import shopDeliveryTypeActive from "../../requests/ShopDeliveries/ShopDeliveryTypeActive";
import shopDeliverySave from "../../requests/ShopDeliveries/ShopDeliverySave";
import shopDeliveryGet from "../../requests/ShopDeliveries/ShopDeliveryGet";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";
const { Option } = Select;

class ShopDeliveriesAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            active: true,
            deliveryTypes: [],
            types: [
                {
                    id: 1,
                    name: "Hours",
                },
                {
                    id: 2,
                    name: "Days",
                },
                {
                    id: 3,
                    name: "Km",
                },
            ],
            id: props.id,
            delivery_type_id: 1,
            type: 1,
            start: 0,
            end: 0,
            shop_id: props.shop_id,
            amount: 0,
            edit: props.id > 0 ? true : false,
        };

        this.onChangeDeliveryType = this.onChangeDeliveryType.bind(this);
        this.onChangeType = this.onChangeType.bind(this);
        // this.getActiveLanguages();
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
        this.getActiveDeliveryType();
    }

    getInfoById = async (id) => {
        let data = await shopDeliveryGet(id);
        if (data.data.success) {
            this.setState({
                active: data.data.data.active == 1 ? true : false,
                delivery_type_id: data.data.data.delivery_type_id,
                type: data.data.data.type,
                start: data.data.data.start,
                end: data.data.data.end,
                amount: data.data.data.amount,
            });

            this.formRef.current.setFieldsValue({
                delivery_type_id: data.data.data.delivery_type_id,
                type: data.data.data.type,
                start: data.data.data.start,
                end: data.data.data.end,
                amount: data.data.data.amount,
            });
        }
    };
    getActiveDeliveryType = async () => {
        const data = await shopDeliveryTypeActive();
        this.setState({
            deliveryTypes: data.data,
        });
    };


    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await shopDeliverySave(this.state.id, {
            ...values,
            shop_id: this.state.shop_id,
            active: this.state.active ? 1 : 0,
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
    onChangeDeliveryType = (e) => {
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
                        ? t("shop_deliveries_edit")
                        : t("shop_deliveries_add")
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
                    <Card
                        style={{ marginTop: "20px" }}
                        title={t("shop_deliveries")}
                    >
                        <div className="row">
                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("delivery_type")}
                                    name="delivery_type_id"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_delivery_type"),
                                        },
                                    ]}
                                    tooltip={t("select_delivery_type")}
                                >
                                    <Select
                                        placeholder={t("select_delivery_type")}
                                    >
                                        {this.state.deliveryTypes?.map(
                                            (item) => {
                                                return (
                                                    <Option
                                                        value={item.id}
                                                        key={item.id}
                                                    >
                                                        {item.language?.name}
                                                    </Option>
                                                );
                                            }
                                        )}
                                    </Select>
                                </Form.Item>
                            </div>
                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("type")}
                                    name="type"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_type"),
                                        },
                                    ]}
                                    tooltip={t("select_type")}
                                >
                                    <Select
                                        placeholder={t("select_type")}
                                        onChange={this.onChangeType}
                                        value={this.state.type}
                                    >
                                        {this.state.types.map((item) => {
                                            return (
                                                <Option
                                                    value={item?.id}
                                                    key={item?.id}
                                                >
                                                    {item.name}
                                                </Option>
                                            );
                                        })}
                                    </Select>
                                </Form.Item>
                            </div>

                            <>
                                <div className="col-md-6 col-sm-12">
                                    <Form.Item
                                        label={
                                            this.state.type === 1
                                                ? t("from_day")
                                                : "from_km"
                                        }
                                        name="start"
                                        rules={[
                                            {
                                                required: true,
                                                message: t("missing_start"),
                                            },
                                        ]}
                                        tooltip={t("enter_start")}
                                    >
                                        <InputNumber
                                            placeholder={
                                                this.state.type === 1
                                                    ? t("from_day")
                                                    : t("from_km")
                                            }
                                            // onChange={this.onChangeStart}
                                        />
                                    </Form.Item>
                                </div>

                                <div className="col-md-6 col-sm-12">
                                    <Form.Item
                                        label={
                                            this.state.type === 1
                                                ? t("to_day")
                                                : t("to_km")
                                        }
                                        name="end"
                                        rules={[
                                            {
                                                required: true,
                                                message: t("missing_end"),
                                            },
                                        ]}
                                        tooltip={t("enter_end")}
                                    >
                                        <InputNumber
                                            placeholder={
                                                this.state.type === 1
                                                    ? t("to_day")
                                                    : t("to_km")
                                            }
                                            // onChange={this.onChangeEnd}
                                        />
                                    </Form.Item>
                                </div>
                            </>

                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("amount")}
                                    name="amount"
                                    rules={[
                                        {
                                            required: true,
                                            message: t("missing_amount"),
                                        },
                                    ]}
                                    tooltip={t("enter_amount")}
                                >
                                    <InputNumber
                                        placeholder={t("amount")}
                                        // onChange={this.onChangeAmount}
                                    />
                                </Form.Item>
                            </div>

                            <div className="col-md-3 col-sm-6">
                                <Form.Item
                                    label={t("status")}
                                    name="active"
                                    tooltip={t(
                                        "uncheck_if_shop_deliveries_is_inactive"
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

export default withTranslation()(ShopDeliveriesAdd);
