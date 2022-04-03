import React from "react";
import PageLayout from "../../../layouts/PageLayout";
import {
    Breadcrumb,
    Layout,
    PageHeader,
    Form,
    Input,
    Button,
    Select,
    message,
} from "antd";
import { Link } from "react-router-dom";
import {
    ShopOutlined,
} from "@ant-design/icons";
import GoogleMapReact from "google-map-react";
import clientActive from "../../../requests/Clients/ClientActive";
import addressSave from "../../../requests/Address/AddressSave";
import { withTranslation } from "react-i18next";
import {IS_DEMO, GOOGLE_MAP_API_KEY} from "../../../global";

const { Option } = Select;
const { Content } = Layout;

const AnyReactComponent = ({ lat, lng, text }) => (
    <div>
        <ShopOutlined style={{ fontSize: "32px", color: "red" }} />
    </div>
);

class AddressAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            latitude: 59.95,
            longitude: 30.33,
            clients: [],
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
            client_id: props.location.state
                ? props.location.state.client_id
                : -1,
        };

        this.onClickMap = this.onClickMap.bind(this);
        this.getActiveClient = this.getActiveClient.bind(this);
        this.onFinish = this.onFinish.bind(this);

        this.getActiveClient();

        if (this.state.edit) this.getInfoById(this.state.id);
    }

    getInfoById = async (id) => {};

    getActiveClient = async () => {
        let data = await clientActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                clients: data.data.data,
            });

            this.formRef.current.setFieldsValue({
                client: this.state.client_id,
            });
        }
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        var params = {
            address: values.address,
            latitude: this.state.latitude,
            longitude: this.state.longitude,
            client_id: values.client,
            id: this.state.id,
        };
        //
        let data = await addressSave(params);
        if (data.data.success == 1) this.props.history.goBack();
    };

    onFinishFailed = (errorInfo) => {};

    onClickMap = (position) => {
        this.setState({
            latitude: position.lat,
            longitude: position.lng,
        });
    };

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/client-addresses" className="nav-text">
                            {t("addresses")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => this.props.history.goBack()}
                    className="site-page-header"
                    title={
                        this.state.edit
                            ? t("addresses_edit")
                            : t("addresses_add")
                    }
                >
                    <Content className="site-layout-background padding-20">
                        <Form
                            ref={this.formRef}
                            name="basic"
                            initialValues={{
                                prefix_mobile: "+1",
                                prefix_phone: "+1",
                                feature_type: "1",
                                delivery_type: "1",
                            }}
                            layout="vertical"
                            onFinish={this.onFinish}
                            onFinishFailed={this.onFinishFailed}
                        >
                            <div className="row">
                                <div className="col-md-6 col-sm-12">
                                    <Form.Item
                                        label={t("address")}
                                        name="address"
                                        rules={[
                                            {
                                                required: true,
                                                message: t(
                                                    "missing_client_address"
                                                ),
                                            },
                                        ]}
                                        tooltip={t("enter_client_address")}
                                    >
                                        <Input placeholder={t("address")} />
                                    </Form.Item>
                                </div>
                                <div className="col-md-6 col-sm-12">
                                    <Form.Item
                                        label={t("clients")}
                                        name="client"
                                        rules={[
                                            {
                                                required: true,
                                                message: t("missing_client"),
                                            },
                                        ]}
                                        tooltip={t("select_client")}
                                    >
                                        <Select
                                            placeholder={t("select_client")}
                                        >
                                            {this.state.clients.map((item) => {
                                                return (
                                                    <Option
                                                        value={item.id}
                                                        key={item.id}
                                                    >
                                                        {item.name}
                                                    </Option>
                                                );
                                            })}
                                        </Select>
                                    </Form.Item>
                                </div>
                                <div
                                    className="col-md-12 col-sm-12 mb-3"
                                    style={{ height: "500px" }}
                                >
                                    <label className="defaultLabel">
                                        {t("select_client_address")}
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
                                            lat={this.state.latitude}
                                            lng={this.state.longitude}
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
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(AddressAdd);
