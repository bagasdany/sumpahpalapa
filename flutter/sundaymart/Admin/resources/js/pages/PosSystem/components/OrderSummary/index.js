import {CloseOutlined} from "@ant-design/icons";
import {Col, Row, Divider, Button, Image} from "antd";
import React from "react";
import {useTranslation} from "react-i18next";

export default ({
                    open,
                    close,
                    outSideClick,
                    onFinish,
                    disable,
                    cart,
                    bagIndex,
                }) => {
    const {t} = useTranslation();
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
                                span={8}
                                style={{
                                    backgroundColor: "#fff",
                                    height: "100%",
                                    maxWidth: "450px",
                                    // padding: 30,
                                }}
                            >
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
                                            {t("order_summary")}
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
                                        minHeight: "50vh",
                                    }}
                                >
                                    {cart[bagIndex].products.map(
                                        (item, idx) => (
                                            <Row
                                                key={idx}
                                                gutter={8}
                                                className="d-flex flex-row align-items-center"
                                                style={{
                                                    borderRadius: 10,
                                                    padding: 5,
                                                    marginBottom: 10,
                                                    border: "1px solid #EFEFEF",
                                                }}
                                            >
                                                <Col span={8}>
                                                    <div
                                                        className="d-flex flex-row justify-content-center align-items-center custom-card"
                                                        style={{
                                                            filter: "drop-shadow(0px 4px 40px rgba(196, 196, 196, 0.22))",
                                                        }}
                                                    >
                                                        <Image
                                                            height={70}
                                                            src={item.image_url}
                                                            fallback="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAYAAADQvc6UAAABRWlDQ1BJQ0MgUHJvZmlsZQAAKJFjYGASSSwoyGFhYGDIzSspCnJ3UoiIjFJgf8LAwSDCIMogwMCcmFxc4BgQ4ANUwgCjUcG3awyMIPqyLsis7PPOq3QdDFcvjV3jOD1boQVTPQrgSkktTgbSf4A4LbmgqISBgTEFyFYuLykAsTuAbJEioKOA7DkgdjqEvQHEToKwj4DVhAQ5A9k3gGyB5IxEoBmML4BsnSQk8XQkNtReEOBxcfXxUQg1Mjc0dyHgXNJBSWpFCYh2zi+oLMpMzyhRcASGUqqCZ16yno6CkYGRAQMDKMwhqj/fAIcloxgHQqxAjIHBEugw5sUIsSQpBobtQPdLciLEVJYzMPBHMDBsayhILEqEO4DxG0txmrERhM29nYGBddr//5/DGRjYNRkY/l7////39v///y4Dmn+LgeHANwDrkl1AuO+pmgAAADhlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAAqACAAQAAAABAAAAwqADAAQAAAABAAAAwwAAAAD9b/HnAAAHlklEQVR4Ae3dP3PTWBSGcbGzM6GCKqlIBRV0dHRJFarQ0eUT8LH4BnRU0NHR0UEFVdIlFRV7TzRksomPY8uykTk/zewQfKw/9znv4yvJynLv4uLiV2dBoDiBf4qP3/ARuCRABEFAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghggQAQZQKAnYEaQBAQaASKIAQJEkAEEegJmBElAoBEgghgg0Aj8i0JO4OzsrPv69Wv+hi2qPHr0qNvf39+iI97soRIh4f3z58/u7du3SXX7Xt7Z2enevHmzfQe+oSN2apSAPj09TSrb+XKI/f379+08+A0cNRE2ANkupk+ACNPvkSPcAAEibACyXUyfABGm3yNHuAECRNgAZLuYPgEirKlHu7u7XdyytGwHAd8jjNyng4OD7vnz51dbPT8/7z58+NB9+/bt6jU/TI+AGWHEnrx48eJ/EsSmHzx40L18+fLyzxF3ZVMjEyDCiEDjMYZZS5wiPXnyZFbJaxMhQIQRGzHvWR7XCyOCXsOmiDAi1HmPMMQjDpbpEiDCiL358eNHurW/5SnWdIBbXiDCiA38/Pnzrce2YyZ4//59F3ePLNMl4PbpiL2J0L979+7yDtHDhw8vtzzvdGnEXdvUigSIsCLAWavHp/+qM0BcXMd/q25n1vF57TYBp0a3mUzilePj4+7k5KSLb6gt6ydAhPUzXnoPR0dHl79WGTNCfBnn1uvSCJdegQhLI1vvCk+fPu2ePXt2tZOYEV6/fn31dz+shwAR1sP1cqvLntbEN9MxA9xcYjsxS1jWR4AIa2Ibzx0tc44fYX/16lV6NDFLXH+YL32jwiACRBiEbf5KcXoTIsQSpzXx4N28Ja4BQoK7rgXiydbHjx/P25TaQAJEGAguWy0+2Q8PD6/Ki4R8EVl+bzBOnZY95fq9rj9zAkTI2SxdidBHqG9+skdw43borCXO/ZcJdraPWdv22uIEiLA4q7nvvCug8WTqzQveOH26fodo7g6uFe/a17W3+nFBAkRYENRdb1vkkz1CH9cPsVy/jrhr27PqMYvENYNlHAIesRiBYwRy0V+8iXP8+/fvX11Mr7L7ECueb/r48eMqm7FuI2BGWDEG8cm+7G3NEOfmdcTQw4h9/55lhm7DekRYKQPZF2ArbXTAyu4kDYB2YxUzwg0gi/41ztHnfQG26HbGel/crVrm7tNY+/1btkOEAZ2M05r4FB7r9GbAIdxaZYrHdOsgJ/wCEQY0J74TmOKnbxxT9n3FgGGWWsVdowHtjt9Nnvf7yQM2aZU/TIAIAxrw6dOnAWtZZcoEnBpNuTuObWMEiLAx1HY0ZQJEmHJ3HNvGCBBhY6jtaMoEiJB0Z29vL6ls58vxPcO8/zfrdo5qvKO+d3Fx8Wu8zf1dW4p/cPzLly/dtv9Ts/EbcvGAHhHyfBIhZ6NSiIBTo0LNNtScABFyNiqFCBChULMNNSdAhJyNSiECRCjUbEPNCRAhZ6NSiAARCjXbUHMCRMjZqBQiQIRCzTbUnAARcjYqhQgQoVCzDTUnQIScjUohAkQo1GxDzQkQIWejUogAEQo121BzAkTI2agUIkCEQs021JwAEXI2KoUIEKFQsw01J0CEnI1KIQJEKNRsQ80JECFno1KIABEKNdtQcwJEyNmoFCJAhELNNtScABFyNiqFCBChULMNNSdAhJyNSiECRCjUbEPNCRAhZ6NSiAARCjXbUHMCRMjZqBQiQIRCzTbUnAARcjYqhQgQoVCzDTUnQIScjUohAkQo1GxDzQkQIWejUogAEQo121BzAkTI2agUIkCEQs021JwAEXI2KoUIEKFQsw01J0CEnI1KIQJEKNRsQ80JECFno1KIABEKNdtQcwJEyNmoFCJAhELNNtScABFyNiqFCBChULMNNSdAhJyNSiECRCjUbEPNCRAhZ6NSiAARCjXbUHMCRMjZqBQiQIRCzTbUnAARcjYqhQgQoVCzDTUnQIScjUohAkQo1GxDzQkQIWejUogAEQo121BzAkTI2agUIkCEQs021JwAEXI2KoUIEKFQsw01J0CEnI1KIQJEKNRsQ80JECFno1KIABEKNdtQcwJEyNmoFCJAhELNNtScABFyNiqFCBChULMNNSdAhJyNSiEC/wGgKKC4YMA4TAAAAABJRU5ErkJggg=="
                                                        />
                                                    </div>
                                                </Col>
                                                <Col span={16}>
                                                    <div className="d-flex flex-column justify-content-between ">
                                                        <h6>{item.name.length < 50 ? item.name : (item.name.substring(0, 50) + "...")}
                                                            <span
                                                                className="text-danger">{item.extras != null ? (" + ( " + item.extras.map((item) => item.extras_name).toString() + " )") : ""}</span>
                                                        </h6>
                                                        <div
                                                            className=" d-flex flex-row"
                                                        >
                                                            <div className="p-0">
                                                                <span
                                                                    style={{
                                                                        fontWeight:
                                                                            "bold",
                                                                    }}
                                                                >
                                                                    {" "}
                                                                    {item.price}
                                                                </span>
                                                            </div>
                                                            <div
                                                                className="d-flex flex-row  align-items-center"
                                                                style={{
                                                                    marginLeft: 15,
                                                                }}
                                                            >
                                                                <span
                                                                    style={{
                                                                        marginRight: 5,
                                                                    }}
                                                                >
                                                                    x
                                                                </span>{" "}
                                                                {item.qty}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </Col>
                                            </Row>
                                        )
                                    )}
                                </div>
                                <Row
                                    style={{
                                        padding: "10px 20px",
                                        borderTop: "1px solid #f2f2f2",
                                        borderBottom: "1px solid #f2f2f2",
                                    }}
                                >
                                    <Col
                                        span={24}
                                        className="d-flex flex-row justify-content-between align-items-center"
                                    >
                                        <span
                                            style={{
                                                fontWeight: "bold",
                                                fontSize: 14,
                                            }}
                                        >
                                            {t("total_product_price")}
                                        </span>
                                        <span
                                            style={{
                                                fontWeight: "bold",
                                                fontSize: 16,
                                            }}
                                        >

                                            {(
                                                cart[bagIndex].total * 1 + cart[bagIndex].discount * 1 -
                                                cart[bagIndex].tax * 1 -
                                                cart[bagIndex].delivery_fee * 1
                                            ).toFixed(2)}
                                        </span>
                                    </Col>
                                </Row>
                                <Row
                                    style={{
                                        padding: "10px 20px",
                                        borderBottom: "1px solid #f2f2f2",
                                        marginBottom: 10,
                                    }}
                                >
                                    <Col span={24}>
                                        <div className="d-flex flex-row justify-content-between align-items-center">
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 14,
                                                }}
                                            >
                                                {t("discount")}
                                            </span>
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 16,
                                                }}
                                            >
                                                {cart[bagIndex].discount}
                                            </span>
                                        </div>
                                        <div className="d-flex flex-row justify-content-between align-items-center">
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 14,
                                                }}
                                            >
                                                {t("delivery")}
                                            </span>
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 16,
                                                }}
                                            >
                                                {cart[bagIndex].delivery_fee}
                                            </span>
                                        </div>
                                        <div className="d-flex flex-row justify-content-between align-items-center">
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 14,
                                                }}
                                            >
                                                {t("tax_price")}
                                            </span>
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 16,
                                                }}
                                            >
                                                {(cart[bagIndex].tax * 1 + cart[bagIndex].shop_tax * 1).toFixed(2)}
                                            </span>
                                        </div>
                                        <div className="d-flex flex-row justify-content-between align-items-center">
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 14,
                                                }}
                                            >
                                                {t("coupon")}
                                            </span>
                                            <span
                                                style={{
                                                    fontWeight: "bold",
                                                    fontSize: 16,
                                                }}
                                            >
                                                0
                                            </span>
                                        </div>
                                    </Col>
                                </Row>

                                <Row
                                    style={{
                                        padding: "10px 20px",
                                        borderTop: "1px solid #f2f2f2",
                                    }}
                                >
                                    <Col
                                        span={24}
                                        className="d-flex flex-row justify-content-between align-items-center"
                                    >
                                        <span
                                            style={{
                                                fontWeight: "bold",
                                                fontSize: 14,
                                            }}
                                        >
                                            {t("total_amount")}
                                        </span>
                                        <span
                                            style={{
                                                fontWeight: "bold",
                                                fontSize: 18,
                                            }}
                                        >
                                            {(cart[bagIndex].total * 1 + cart[bagIndex].shop_tax * 1 + cart[bagIndex].delivery_fee * 1).toFixed(2)}
                                        </span>
                                    </Col>
                                </Row>
                                <Row
                                    style={{
                                        margin: 40,
                                    }}
                                >
                                    <Col
                                        span={24}
                                        className="d-flex flex-row justify-content-around"
                                    >
                                        <Button
                                            onClick={onFinish}
                                            disabled={disable}
                                            style={{
                                                borderRadius: 15,
                                                height: 50,
                                                paddingLeft: 50,
                                                paddingRight: 50,
                                                backgroundColor: "#16AA16",
                                                color: "#fff",
                                            }}
                                        >
                                            {t("confirm_order")}
                                        </Button>
                                        <Button
                                            onClick={close}
                                            style={{
                                                borderRadius: 15,
                                                height: 50,
                                                paddingLeft: 40,
                                                paddingRight: 40,
                                                backgroundColor: "#fff",
                                                color: "#161616",
                                                border: "2px solid #2E3456",
                                            }}
                                        >
                                            {t("cancel")}
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
