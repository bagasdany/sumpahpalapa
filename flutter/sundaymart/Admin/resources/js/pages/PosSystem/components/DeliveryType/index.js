import {CloseOutlined} from "@ant-design/icons";
import {Col, Row, Button} from "antd";
import React, {useState} from "react";
import {useTranslation} from "react-i18next";
import {AiFillCar} from "react-icons/ai";
import {FiTruck} from "react-icons/fi";
import {FaBicycle} from "react-icons/fa";
import {BsCheck} from "react-icons/bs";
import {RiShoppingBag3Line, RiEBike2Line} from "react-icons/ri";

export default ({
                    open,
                    close,
                    outSideClick,
                    handleSave,
                    shippings,
                    shippingBoxData,
                    deliveryTypeOptions,
                }) => {
    const {t} = useTranslation();
    const [active, setActive] = useState(1);
    const [type, setType] = useState("1");
    const [deliveryType, setDeliveryType] = useState(undefined);
    const [shipping, setShipping] = useState(shippings[0]?.id);
    const [shippingBox, setShippingBox] = useState(shippings[0]?.id);
    const [deliveryFee, setDeliveryFee] = useState(0);

    const checkType = (type) => {
        switch (type) {
            case 1:
                return "hours";

            case 2:
                return "days";

            case 3:
                return "range";

            default:
                return " ";
        }
    };

    const onFinish = () => {
        var delivery_fee = 0;

        if(type == '1') {
            var index = shippings.findIndex((item) => item.id == shipping);
            var price = index !== -1 ? shippings[index].amount * 1 : 0;
            var index2 = shippingBoxData.findIndex((element) => element.id == shippingBox);
            var price2 = index2 !== -1 ? shippingBoxData[index2].price * 1 : 0;
            var index3 = deliveryTypeOptions.findIndex((item) => item.id == deliveryType);
            var price3 = index3 !== -1 ? deliveryTypeOptions[index3].price * 1 : 0;

            delivery_fee = price + price2 + price3;
        }

        const data = {
            type: type,
            shipping_transport_id: type === "1" ? deliveryType : null,
            shipping_id: type === "1" ? shipping : null,
            delivery_fee: delivery_fee,
            shipping_box_id: type === "1" ? shippingBox : 0,
        };

        handleSave(data);
        setType("1");
        setDeliveryType(undefined);
        setShipping(undefined);
        setShippingBox(undefined);
        setActive(1);
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
                        zIndex: 1200,
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
                                onClick={outSideClick}
                                style={{
                                    width: "100%",
                                    height: "100%",
                                }}
                                span={16}
                            ></Col>
                            <Col
                                className="d-flex flex-column justify-content-between"
                                span={8}
                                style={{
                                    width: "100%",
                                    maxWidth: "450px",
                                    backgroundColor: "#fff",
                                    height: "100%",
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
                                                {t("delivery_type")}
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
                                            padding: "20px",
                                        }}
                                    >
                                        <Row>
                                            <Col
                                                className="d-flex felx-row"
                                                span={24}
                                                style={{
                                                    width: "100%",
                                                    background: "#F8F8F8",
                                                    borderRadius: "15px",
                                                    padding: "8px",
                                                    height: "70px",
                                                }}
                                            >
                                                <Button
                                                    onClick={() => {
                                                        setActive(1);
                                                        setType("1");
                                                    }}
                                                    icon={
                                                        <RiEBike2Line
                                                            style={{
                                                                marginRight: 10,
                                                            }}
                                                        />
                                                    }
                                                    style={{
                                                        width: "100%",
                                                        borderRadius: 15,
                                                        height: 50,
                                                        paddingLeft: 50,
                                                        border: "none",
                                                        outline: "none",
                                                        paddingRight: 50,
                                                        transition:
                                                            "300ms all ease-in",
                                                        backgroundColor:
                                                            active === 1
                                                                ? "#45A524"
                                                                : "#F8F8F8",
                                                        color:
                                                            active === 1
                                                                ? "#fff"
                                                                : "#000",
                                                    }}
                                                >
                                                    {t("delivery")}
                                                </Button>
                                                <Button
                                                    onClick={() => {
                                                        setActive(2);
                                                        setType("2");
                                                    }}
                                                    icon={
                                                        <RiShoppingBag3Line
                                                            style={{
                                                                marginRight: 10,
                                                            }}
                                                        />
                                                    }
                                                    style={{
                                                        width: "100%",
                                                        borderRadius: 15,
                                                        height: 50,
                                                        paddingLeft: 50,
                                                        paddingRight: 50,
                                                        outline: "none",
                                                        border: "none",
                                                        transition:
                                                            "300ms all ease-in",
                                                        backgroundColor:
                                                            active === 2
                                                                ? "#45A524"
                                                                : "#F8F8F8",
                                                        color:
                                                            active === 2
                                                                ? "#fff"
                                                                : "#000",
                                                    }}
                                                >
                                                    {t("pickup")}
                                                </Button>
                                            </Col>
                                        </Row>
                                    </div>
                                    {type === "1" && (
                                        <>
                                            <div
                                                style={{
                                                    padding: 20,
                                                }}
                                            >
                                                <Row>
                                                    {shippings.map(
                                                        (item, idx) => (
                                                            <Col
                                                                key={idx}
                                                                span={24}
                                                                style={{
                                                                    marginBottom: 30,
                                                                }}
                                                            >
                                                                <div className="d-flex flex-column">
                                                                    <div
                                                                        onClick={() => {
                                                                            setShipping(
                                                                                item.id
                                                                            );

                                                                        }}
                                                                        style={{
                                                                            cursor: "pointer",
                                                                        }}
                                                                        className="d-flex flex-row  align-items-center"
                                                                    >
                                                                        <Button
                                                                            className="d-flex flex-row  align-items-center justify-content-center"
                                                                            icon={
                                                                                <BsCheck color="#fff"/>
                                                                            }
                                                                            style={{
                                                                                width: "18px",
                                                                                height: "18px",
                                                                                borderRadius:
                                                                                    "9px",
                                                                                border:
                                                                                    shipping ===
                                                                                    item.id
                                                                                        ? "none"
                                                                                        : "2px solid #A0A09C",
                                                                                marginRight: 8,
                                                                                backgroundColor:
                                                                                    shipping ===
                                                                                    item.id
                                                                                        ? "#FFB800"
                                                                                        : "transparent",
                                                                                transition:
                                                                                    "200ms all ease-in",
                                                                            }}
                                                                        ></Button>
                                                                        <span>
                                                                            {
                                                                                item.name
                                                                            }
                                                                        </span>
                                                                    </div>
                                                                    <div
                                                                        style={{
                                                                            width: "100%",
                                                                        }}
                                                                        className="d-flex flex-row justify-content-between align-items-center"
                                                                    >
                                                                        <span
                                                                            style={{
                                                                                fontWeight:
                                                                                    "bold",
                                                                                fontSize: 16,
                                                                                marginLeft:
                                                                                    "25px",
                                                                            }}
                                                                        >
                                                                            {
                                                                                item.amount
                                                                            }
                                                                        </span>
                                                                        <span
                                                                            style={{
                                                                                fontSize: 16,
                                                                            }}
                                                                        >
                                                                            {
                                                                                item.start
                                                                            }{" "}
                                                                            to{" "}
                                                                            {
                                                                                item.end
                                                                            }{" "}
                                                                            {checkType(
                                                                                item.type
                                                                            )}
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </Col>
                                                        )
                                                    )}
                                                </Row>
                                            </div>
                                            <Row
                                                gutter={[10, 10]}
                                                style={{
                                                    padding: "5px 20px",
                                                }}
                                            >
                                                {deliveryTypeOptions.map(
                                                    (item, idx) => (
                                                        <Col
                                                            key={idx}
                                                            span={11}
                                                        >
                                                            <Button
                                                                onClick={() => {
                                                                    setDeliveryType(
                                                                        item.id
                                                                    );

                                                                }}
                                                                icon={
                                                                    <AiFillCar
                                                                        style={{
                                                                            marginRight: 10,
                                                                        }}
                                                                    />
                                                                }
                                                                style={{
                                                                    width: "100%",
                                                                    borderRadius: 15,
                                                                    height: 50,
                                                                    paddingLeft: 50,
                                                                    border: "none",
                                                                    paddingRight: 50,
                                                                    transition:
                                                                        "300ms all ease-in",
                                                                    backgroundColor:
                                                                        deliveryType ===
                                                                        item.id
                                                                            ? "#45A524"
                                                                            : "#F8F8F8",
                                                                    color:
                                                                        deliveryType ===
                                                                        item.id
                                                                            ? "#fff"
                                                                            : "#000",
                                                                }}
                                                            >
                                                                {item.name}
                                                            </Button>
                                                        </Col>
                                                    )
                                                )}
                                            </Row>
                                            <div
                                                style={{
                                                    padding: 20,
                                                    marginTop: 30
                                                }}
                                            >
                                                <Row>
                                                    {shippingBoxData.map(
                                                        (item, idx) => (
                                                            <Col
                                                                key={idx}
                                                                span={24}
                                                                style={{
                                                                    marginBottom: 30,
                                                                }}
                                                            >
                                                                <div className="d-flex flex-column">
                                                                    <div
                                                                        onClick={() => {
                                                                            setShippingBox(
                                                                                item.id
                                                                            );

                                                                        }}
                                                                        style={{
                                                                            cursor: "pointer",
                                                                        }}
                                                                        className="d-flex flex-row  align-items-center"
                                                                    >
                                                                        <Button
                                                                            className="d-flex flex-row  align-items-center justify-content-center"
                                                                            icon={
                                                                                <BsCheck color="#fff"/>
                                                                            }
                                                                            style={{
                                                                                width: "18px",
                                                                                height: "18px",
                                                                                borderRadius:
                                                                                    "9px",
                                                                                border:
                                                                                    shippingBox ===
                                                                                    item.id
                                                                                        ? "none"
                                                                                        : "2px solid #A0A09C",
                                                                                marginRight: 8,
                                                                                backgroundColor:
                                                                                    shippingBox ===
                                                                                    item.id
                                                                                        ? "#FFB800"
                                                                                        : "transparent",
                                                                                transition:
                                                                                    "200ms all ease-in",
                                                                            }}
                                                                        ></Button>
                                                                        <span>
                                                                            {
                                                                                item.name
                                                                            }
                                                                        </span>
                                                                    </div>
                                                                    <div
                                                                        style={{
                                                                            width: "100%",
                                                                        }}
                                                                        className="d-flex flex-row justify-content-between align-items-center"
                                                                    >
                                                                        <span
                                                                            style={{
                                                                                fontWeight:
                                                                                    "bold",
                                                                                fontSize: 16,
                                                                                marginLeft:
                                                                                    "25px",
                                                                            }}
                                                                        >
                                                                            {
                                                                                item.amount
                                                                            }
                                                                        </span>
                                                                        <span
                                                                            style={{
                                                                                fontSize: 16,
                                                                            }}
                                                                        >
                                                                            {
                                                                                item.start
                                                                            }{" "}
                                                                            to{" "}
                                                                            {
                                                                                item.end
                                                                            }{" "}
                                                                            {checkType(
                                                                                item.type
                                                                            )}
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </Col>
                                                        )
                                                    )}
                                                </Row>
                                            </div>
                                        </>
                                    )}
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
                                            {t("save")}
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
