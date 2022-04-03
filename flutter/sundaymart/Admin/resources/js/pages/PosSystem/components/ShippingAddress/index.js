import { CloseOutlined, ShopOutlined } from "@ant-design/icons";
import {Col, Row, Button, Input, Form, Select, message} from "antd";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import GoogleMapReact from "google-map-react";
import addressSave from "../../../../requests/Address/AddressSave";
import {IS_DEMO, GOOGLE_MAP_API_KEY} from "../../../../global";

const { Option } = Select;

const AnyReactComponent = ({ lat, lng, text }) => (
    <div>
        <ShopOutlined style={{ fontSize: "32px", color: "red" }} />
    </div>
);

export default ({ open, close, outSideClick, clients }) => {
    const { t } = useTranslation();

    const formRef = React.createRef();
    const [client, setClient] = useState(undefined);
    const [address, setAddress] = useState("");
    const [location, setLocation] = useState({
        latitude: 59.95,
        longitude: 30.33,
    });

    const onFinish = async () => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        const params = {
            address: address,
            latitude: location.latitude,
            longitude: location.longitude,
            client_id: client,
        };
        //
        let data = await addressSave(params);
        if (data.data.success == 1) close();
    };

    const onClickMap = (position) => {
        const loc = {
            latitude: position.lat,
            longitude: position.lng,
        };
        setLocation(loc);
    };
    return (
        <>
            {open ? (
                <div
                    style={{
                        width: "100%",
                        height: "100%",
                        position: "absolute",
                        right: 0,
                        zIndex: 1050,
                        backgroundColor: "rgba(0, 0, 0, 0.5)",
                    }}
                >
                    <div
                        style={{
                            height: "100%",
                        }}
                    >
                        <Row
                            className="d-flex flex-row justify-content-between align-items-end"
                            style={{
                                height: "100%",
                            }}
                        >
                            <Col
                                span={16}
                                onClick={outSideClick}
                                style={{
                                    width: "100%",
                                    height: "100%",
                                }}
                            ></Col>

                            <Col
                                className="d-flex flex-column justify-content-between"
                                span={8}
                                style={{
                                    backgroundColor: "#fff",
                                    height: "100%",
                                    maxWidth: "450px",
                                    // padding: 30,
                                }}
                            >
                                <div>
                                    <Row
                                        style={{
                                            padding: "20px",
                                        }}
                                    >
                                        <Col
                                            span={24}
                                            className="d-flex flex-row justify-content-between align-items-center"
                                        >
                                            <h2
                                                style={{
                                                    fontWeight: "bold",
                                                }}
                                            >
                                                {t("create_shipping_addres")}
                                            </h2>
                                            <CloseOutlined
                                                onClick={close}
                                                size={24}
                                                style={{
                                                    fontWeight: "bold",
                                                    cursor: "pointer",
                                                }}
                                            />
                                        </Col>
                                    </Row>
                                    <div
                                        style={{
                                            padding: 20,
                                        }}
                                    >
                                        <Form name="basic" layout="vertical">
                                            <div className="row">
                                                <div className="col-md-12 col-sm-12">
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
                                                        tooltip={t(
                                                            "enter_client_address"
                                                        )}
                                                    >
                                                        <Input
                                                            onChange={(e) =>
                                                                setAddress(
                                                                    e.target
                                                                        .value
                                                                )
                                                            }
                                                            value={address}
                                                            placeholder={t(
                                                                "address"
                                                            )}
                                                        />
                                                    </Form.Item>
                                                </div>
                                                <div className="col-md-12 col-sm-12">
                                                    <Form.Item
                                                        label={t("clients")}
                                                        name="client"
                                                        rules={[
                                                            {
                                                                required: true,
                                                                message:
                                                                    t(
                                                                        "missing_client"
                                                                    ),
                                                            },
                                                        ]}
                                                        tooltip={t(
                                                            "select_client"
                                                        )}
                                                    >
                                                        <Select
                                                            onChange={(e) =>
                                                                setClient(e)
                                                            }
                                                            value={client}
                                                            placeholder={t(
                                                                "select_client"
                                                            )}
                                                        >
                                                            {clients.map(
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
                                                <div
                                                    className="col-md-12 col-sm-12 mb-3"
                                                    style={{
                                                        height: "500px",
                                                    }}
                                                >
                                                    <label className="defaultLabel">
                                                        {t(
                                                            "select_client_address"
                                                        )}
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
                                                        onClick={onClickMap}
                                                    >
                                                        <AnyReactComponent
                                                            lat={
                                                                location.latitude
                                                            }
                                                            lng={
                                                                location.longitude
                                                            }
                                                            text={t(
                                                                "new_location"
                                                            )}
                                                        />
                                                    </GoogleMapReact>
                                                </div>
                                            </div>
                                        </Form>
                                    </div>
                                </div>
                                <Row
                                    style={{
                                        margin: 40,
                                    }}
                                >
                                    <Col span={24}>
                                        <Button
                                            onClick={onFinish}
                                            style={{
                                                borderRadius: 15,
                                                height: 50,
                                                paddingLeft: 50,
                                                paddingRight: 50,
                                                backgroundColor: "#16AA16",
                                                color: "#fff",
                                            }}
                                        >
                                            {t("order_now")}
                                        </Button>
                                    </Col>
                                </Row>
                            </Col>
                        </Row>
                    </div>
                </div>
            ) : null}
        </>
    );
};
