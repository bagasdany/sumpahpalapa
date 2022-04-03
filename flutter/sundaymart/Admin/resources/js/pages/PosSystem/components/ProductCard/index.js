import React from "react";
import {Button, Image, Pagination} from "antd";
import {useTranslation} from "react-i18next";
import {AppstoreAddOutlined, PlusOutlined} from "@ant-design/icons";

export default ({handleOpen, products, addProduct, showMore}) => {
    const {t} = useTranslation();

    const getDiscountPrice = (actual_discount, price) => {
        var discount = actual_discount == null ? 0 : actual_discount.discount_type === 0
            ? 0
            : actual_discount.discount_type === 1
                ? (actual_discount.discount_amount * price) / 100
                : actual_discount.discount_amount;

        return (price * 1 - discount * 1).toFixed(2);
    }

    return (
        <div className="d-flex flex-column align-items-start justify-content-start">
            <div
                className="d-flex flex-row custom-container"
                style={{
                    height: "80vh",
                    marginTop: 20,
                    flexWrap: "wrap",
                    overflow: "hidden scroll",
                    alignContent: "baseline",
                }}
            >
                {products.map((item, idx) => (
                    <div
                        key={idx}
                        style={{
                            margin: 5,
                        }}
                    >
                        <div
                            className="custom-card"
                            style={{
                                width: "200px",
                                height: "226px",
                            }}
                        >
                            <div
                                style={{
                                    width: "100%",
                                    height: "100%",
                                    paddingRight: 10,
                                    paddingLeft: 10,
                                }}
                            >
                                <div
                                    className="d-flex flex-row justify-content-center"
                                    style={{
                                        minHeight: "120px",
                                    }}
                                >
                                    <Image
                                        height={120}
                                        src={item.image_url}
                                        fallback="data:image/png;base64,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"
                                    />
                                </div>
                                <div
                                    className="d-flex flex-column"
                                    style={{
                                        marginTop: 10,
                                        marginBottom: 8,
                                    }}
                                >
                                    <span
                                        style={{
                                            fontWeight: "bold",
                                            fontSize: 14,
                                        }}
                                    >
                                        {item.name.length > 15
                                            ? item.name.substring(0, 15) + "..."
                                            : item.name}
                                    </span>
                                    <span
                                        style={{
                                            color: "#16AA16",
                                            fontSize: 12,
                                            fontWeight: "bold",
                                        }}
                                    >
                                        {t("instock")} - {item.amount}
                                    </span>
                                </div>
                                <div className="d-flex flex-row">
                                    <span
                                        style={{
                                            fontWeight: "bold",
                                        }}
                                    >
                                        {getDiscountPrice(item.actual_discount, item.price)}
                                    </span>
                                    {
                                        item.actual_discount != null && (
                                            <span
                                                style={{
                                                    color: "#C0C2CC",
                                                    marginLeft: 10,
                                                    textDecoration: "line-through"
                                                }}
                                            >
                                                {item.price}
                                    </span>)
                                    }

                                </div>
                            </div>
                            <div className="plus-button">
                                <div className="d-flex flex-row">
                                    <Button
                                        className="d-flex flex-row justify-content-center align-items-center"
                                        shape="circle"
                                        onClick={() => handleOpen(item)}
                                        style={{
                                            border: "none",
                                            backgroundColor: "#F8F8F8",
                                            marginRight: 15,
                                        }}
                                        icon={
                                            <AppstoreAddOutlined
                                                style={{
                                                    fontWeight: "bold",
                                                }}
                                            />
                                        }
                                    />
                                    <Button
                                        className="d-flex flex-row justify-content-center align-items-center"
                                        shape="circle"
                                        onClick={() => addProduct(item)}
                                        style={{
                                            border: "none",
                                            backgroundColor: "#F8F8F8",
                                        }}
                                        icon={
                                            <PlusOutlined
                                                style={{
                                                    fontWeight: "bold",
                                                }}
                                            />
                                        }
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            <div
                style={{
                    width: "100%",
                    padding: 20,
                }}
            >
                <Button
                    onClick={showMore}
                    style={{
                        width: "100%",
                        border: "1px solid rgba(0, 0, 0, 0.17)",
                        height: "50px",
                        textAlign: "center",
                        backgroundColor: "transparent",
                        borderRadius: "10px",
                        fontSize: "16px",
                        fontWeight: 500,
                    }}
                >
                    View more
                </Button>
            </div>
        </div>
    );
};
