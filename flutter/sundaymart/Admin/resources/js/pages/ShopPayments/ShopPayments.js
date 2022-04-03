import React from "react";
import {
    Button,
    Layout,
    PageHeader,
    Row,
    Col,
    Card,
    Space,
    Input,
    Radio,
} from "antd";
import shopPaymentsSave from "../../requests/ShopPayments/ShopPaymentsSave";
import shopPaymentDatatable from "../../requests/ShopPayments/ShopPaymentsDatatable";
import paymentsActive from "../../requests/Payments/PaymentsActive";

const {Content} = Layout;

class ShopPayments extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            payments: {},
            activePayments: [],
            shop_id: props.shop_id
        };

        this.getActivePayments = this.getActivePayments.bind();

        this.getById(props.shop_id);
        this.getActivePayments();
    }

    getActivePayments = async () => {
        let data = await paymentsActive();
        data = data['data'];
        if (data['data'] != null) {
            this.setState({
                activePayments: data['data']
            });
        }
    }

    getById = async (id) => {
        let data = await shopPaymentDatatable(id);
        data = data['data'];
        if (data['data'] != null) {
            var paymentData = {};
            for (var i = 0; i < data['data'].length; i++) {
                paymentData[data['data'][i]['id_payment']] = {
                    "active": data['data'][i]['active'],
                    "payment_id": data['data'][i]['id_payment'],
                    "public_key": data['data'][i]['key_id'],
                    "private_key": data['data'][i]['secret_id'],
                };
            }

            this.setState({
                payments: paymentData
            });
        }
    }

    savePayment = async (id_shop, id_payment, active, key_id = "", secret_id = "") => {
        let data = await shopPaymentsSave(id_shop, id_payment, active, key_id, secret_id);
    }

    render() {
        return (
            <PageHeader className="site-page-header">
                <Content className="site-layout-background">
                    <Row gutter={20}>
                        {
                            this.state.activePayments.map((item) => {
                                return (<Col key={item.id} className="col col-md-6" style={{marginTop: '20px'}}>
                                    <Card title={item.language.name}>
                                        <h6 className="m-2">Active</h6>
                                        <Radio.Group
                                            onChange={(e) => {
                                                var paymentData = this.state.payments;
                                                if (paymentData[item.id] == null) {
                                                    paymentData[item.id] = {
                                                        "payment_id": item.id
                                                    };
                                                }

                                                paymentData[item.id]["active"] = e.target.value;

                                                this.setState({
                                                    payments: paymentData
                                                })
                                            }}
                                            value={this.state.payments[item.id] == null ? "" : this.state.payments[item.id]["active"]}
                                            className="m-2"
                                        >
                                            <Space direction="vertical">
                                                <Radio value={1}>Active</Radio>
                                                <Radio value={2}>Inactive</Radio>
                                            </Space>
                                        </Radio.Group>
                                        {
                                            item.type == 2 && (<>
                                                <h6 className="m-2">Published Key</h6>
                                                <Input
                                                    value={this.state.payments[item.id] == null ? "" : this.state.payments[item.id]["public_key"]}
                                                    onChange={(e) => {
                                                        var paymentData = this.state.payments;
                                                        if (paymentData[item.id] == null) {
                                                            paymentData[item.id] = {
                                                                "payment_id": item.id
                                                            };
                                                        }

                                                        paymentData[item.id]["public_key"] = e.target.value;

                                                        this.setState({
                                                            payments: paymentData
                                                        })
                                                    }}/>
                                                <h6 className="m-2">API Key</h6>
                                                <Input
                                                    value={this.state.payments[item.id] == null ? "" : this.state.payments[item.id]["private_key"]}
                                                    onChange={(e) => {
                                                        var paymentData = this.state.payments;
                                                        if (paymentData[item.id] == null) {
                                                            paymentData[item.id] = {
                                                                "payment_id": item.id
                                                            };
                                                        }

                                                        paymentData[item.id]["private_key"] = e.target.value;

                                                        this.setState({
                                                            payments: paymentData
                                                        })
                                                    }}/>
                                            </>)
                                        }
                                        <br/>
                                        {
                                            this.state.payments[item.id] != null && this.state.payments[item.id]['active'] != null && (
                                                <Button
                                                    size="large"
                                                    style={{marginTop: 10}}
                                                    type="primary"
                                                    onClick={() => this.savePayment(this.state.shop_id, this.state.payments[item.id]['payment_id'], this.state.payments[item.id]['active'], this.state.payments[item.id]['public_key'], this.state.payments[item.id]['private_key'])}
                                                >
                                                    Save
                                                </Button>)
                                        }

                                    </Card>
                                </Col>);
                            })
                        }
                        {/*<Col className="col col-md-6">*/}
                        {/*    <Card title="Cash">*/}
                        {/*        <h6 className="m-2">Cash</h6>*/}
                        {/*        <Radio.Group*/}
                        {/*            onChange={(e) => {*/}
                        {/*                this.setState({*/}
                        {/*                    cashActive: e.target.value*/}
                        {/*                })*/}
                        {/*            }}*/}
                        {/*            value={this.state.cashActive}*/}
                        {/*            className="m-2"*/}
                        {/*        >*/}
                        {/*            <Space direction="vertical">*/}
                        {/*                <Radio value={1}>Active</Radio>*/}
                        {/*                <Radio value={2}>Inactive</Radio>*/}
                        {/*            </Space>*/}
                        {/*        </Radio.Group>*/}
                        {/*        <br/>*/}
                        {/*        <Button*/}
                        {/*            size="large"*/}
                        {/*            style={{marginTop: 10}}*/}
                        {/*            type="primary"*/}
                        {/*            onClick={() => this.savePayment(this.state.shop_id, 1, this.state.cashActive)}*/}
                        {/*        >*/}
                        {/*            Save*/}
                        {/*        </Button>*/}
                        {/*    </Card>*/}
                        {/*</Col>*/}
                        {/*<Col className="col col-md-6">*/}
                        {/*    <Card title="Terminal">*/}
                        {/*        <h6 className="m-2">Terminal</h6>*/}
                        {/*        <Radio.Group*/}
                        {/*            onChange={(e) => {*/}
                        {/*                this.setState({*/}
                        {/*                    terminalActive: e.target.value*/}
                        {/*                })*/}
                        {/*            }}*/}
                        {/*            value={this.state.terminalActive}*/}
                        {/*            className="m-2"*/}
                        {/*        >*/}
                        {/*            <Space direction="vertical">*/}
                        {/*                <Radio value={1}>Active</Radio>*/}
                        {/*                <Radio value={2}>Inactive</Radio>*/}
                        {/*            </Space>*/}
                        {/*        </Radio.Group>*/}
                        {/*        <br/>*/}
                        {/*        <Button*/}
                        {/*            size="large"*/}
                        {/*            style={{marginTop: 10}}*/}
                        {/*            type="primary"*/}
                        {/*            onClick={() => this.savePayment(this.state.shop_id, 2, this.state.cashActive)}*/}
                        {/*        >*/}
                        {/*            Save*/}
                        {/*        </Button>*/}
                        {/*    </Card>*/}
                        {/*</Col>*/}

                        {/*<Col className="col col-md-6" style={{marginTop: '20px'}}>*/}
                        {/*    <Card title="Paystack">*/}
                        {/*        <h6 className="m-2">Paystack</h6>*/}
                        {/*        <Radio.Group*/}
                        {/*            onChange={(e) => {*/}
                        {/*                this.setState({*/}
                        {/*                    paystackActive: e.target.value*/}
                        {/*                })*/}
                        {/*            }}*/}
                        {/*            value={this.state.paystackActive}*/}
                        {/*            className="m-2"*/}
                        {/*        >*/}
                        {/*            <Space direction="vertical">*/}
                        {/*                <Radio value={1}>Active</Radio>*/}
                        {/*                <Radio value={2}>Inactive</Radio>*/}
                        {/*            </Space>*/}
                        {/*        </Radio.Group>*/}
                        {/*        <h6 className="m-2">Published Key</h6>*/}
                        {/*        <Input value={this.state.paystackPublicKey} onChange={(e) => {*/}
                        {/*            this.setState({*/}
                        {/*                paystackPublicKey: e.target.value*/}
                        {/*            })*/}
                        {/*        }}/>*/}
                        {/*        <h6 className="m-2">API Key</h6>*/}
                        {/*        <Input value={this.state.paystackPrivateKey} onChange={(e) => {*/}
                        {/*            this.setState({*/}
                        {/*                paystackPrivateKey: e.target.value*/}
                        {/*            })*/}
                        {/*        }}/>*/}
                        {/*        <Button*/}
                        {/*            size="large"*/}
                        {/*            style={{marginTop: 10}}*/}
                        {/*            type="primary"*/}
                        {/*            onClick={() => this.savePayment(this.state.shop_id, 4, this.state.paystackActive, this.state.paystackPublicKey, this.state.paystackPrivateKey)}*/}
                        {/*        >*/}
                        {/*            Save*/}
                        {/*        </Button>*/}
                        {/*    </Card>*/}
                        {/*</Col>*/}
                    </Row>
                </Content>
            </PageHeader>
        );
    }
}

export default ShopPayments;
