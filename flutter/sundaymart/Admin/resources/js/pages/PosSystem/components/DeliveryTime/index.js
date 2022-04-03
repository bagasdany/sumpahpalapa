import { CloseOutlined } from "@ant-design/icons";
import { Col, Row } from "antd";
import React from "react";
import { useTranslation } from "react-i18next";
import { Calendar } from "react-date-range";
import "react-date-range/dist/styles.css"; // main style file
import "react-date-range/dist/theme/default.css";
import { format } from "date-fns";
export default ({
    open,
    close,
    outSideClick,
    timeUnit,
    setCart,
    cart,
    bagIndex,
}) => {
    const { t } = useTranslation();

    function customDayContent(day) {
        let extraDot = null;
        const now = new Date();
        if (now < day) {
            extraDot = (
                <div
                    style={{
                        height: "4px",
                        width: "4px",
                        borderRadius: "100%",
                        background: "#FFB800",
                        position: "absolute",
                        bottom: 4,
                        left: "50%",
                        transform: "translateX(-50%)",
                        // right: 2,
                    }}
                />
            );
        }
        return (
            <div>
                {extraDot}
                <span>{format(day, "d")}</span>
            </div>
        );
    }
    const handleChangeDeliveryData = (e) => {
        const newData = [...cart];
        newData[bagIndex].deliveryDate = e;
        setCart(newData);
    };
    const handleChangeDeliveryTime = (e) => {
        const newData = [...cart];
        newData[bagIndex].deliveryTime = e;
        setCart(newData);
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
                                    width: "100%",
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
                                                {t("delivery_time")}
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
                                        <Row>
                                            <Col
                                                span={24}
                                                className="d-flex flex-row justify-content-center"
                                            >
                                                <Calendar
                                                    date={
                                                        cart[bagIndex]
                                                            .deliveryDate
                                                    }
                                                    onChange={(e) =>
                                                        handleChangeDeliveryData(
                                                            e
                                                        )
                                                    }
                                                    dayContentRenderer={
                                                        customDayContent
                                                    }
                                                    showPreview={false}
                                                    showDateDisplay={false}
                                                    showMonthAndYearPickers={
                                                        false
                                                    }
                                                    ranges={[]}
                                                    rangeColors={["#fff"]}
                                                    weekStartsOn={1}
                                                    editableDateInputs={false}
                                                    color="#45A524"
                                                />
                                            </Col>
                                            {cart[bagIndex].deliveryDate &&
                                                timeUnit.map((item, idx) => (
                                                    <Col
                                                        onClick={() => {
                                                            handleChangeDeliveryTime(
                                                                item.id
                                                            );
                                                            close();
                                                        }}
                                                        key={idx}
                                                        span={24}
                                                        style={{
                                                            marginTop: 5,
                                                            cursor: "pointer",
                                                        }}
                                                    >
                                                        <div
                                                            className="d-flex flex-row justify-content-between align-items-center"
                                                            style={{
                                                                width: "100%",
                                                                background:
                                                                    "#F8F8F8",
                                                                borderRadius: 10,
                                                                padding: 10,
                                                                fontWeight:
                                                                    "bold",
                                                            }}
                                                        >
                                                            <div className="d-flex flex-row align-items-center">
                                                                <div
                                                                    style={{
                                                                        backgroundColor:
                                                                            "#45A524",
                                                                        width: 8,
                                                                        height: 8,
                                                                        borderRadius: 4,
                                                                        marginRight: 10,
                                                                    }}
                                                                />
                                                                <span>
                                                                    {/* {format(
                                                                        deliveryTime,
                                                                        "d"
                                                                    )}{" "} */}
                                                                    {format(
                                                                        cart[
                                                                            bagIndex
                                                                        ]
                                                                            .deliveryDate,
                                                                        "d MMMM"
                                                                    )}
                                                                </span>
                                                            </div>
                                                            <span>
                                                                {item.name}
                                                            </span>
                                                        </div>
                                                    </Col>
                                                ))}
                                        </Row>
                                    </div>
                                </div>
                            </Col>
                        </Row>
                    </div>
                </div>
            ) : null}
        </>
    );
};
