import { CloseOutlined } from "@ant-design/icons";
import { Col, Row, Divider, Button, Input, message, Select } from "antd";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import clientSave from "../../../../requests/Clients/ClientSave";
const { Option } = Select;

export default ({ open, close, outSideClick }) => {
    const { t } = useTranslation();
    const [name, setName] = useState("");
    const [surname, setSurname] = useState("");
    const [phone, setPhone] = useState("");
    const [password, setPassword] = useState("");

    const onFinish = async () => {
        if (password != confirmPassword) {
            message.error("Password and confirm password mismatch");
            return false;
        }

        let data = await clientSave(
            name,
            surname,
            "",
            phone,
            password,
            "",
            true,
            0
        );
        if (data.data.success == 1) close();
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
                                                {t("add_user")}
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
                                                style={{
                                                    borderBottom:
                                                        "1px solid #cccccc",
                                                    marginBottom: 30,
                                                }}
                                            >
                                                <span
                                                    style={{
                                                        paddingLeft: 10,
                                                        fontSize: 14,
                                                        color: "#ccc",
                                                    }}
                                                >
                                                    {t("name")}
                                                </span>
                                                <Input
                                                    name="name"
                                                    style={{
                                                        fontSize: 18,
                                                    }}
                                                    value={name}
                                                    placeholder={t("name")}
                                                    onChange={(e) =>
                                                        setName(e.target.value)
                                                    }
                                                    bordered={false}
                                                />
                                            </Col>
                                            <Col
                                                span={24}
                                                style={{
                                                    borderBottom:
                                                        "1px solid #cccccc",
                                                    marginBottom: 30,
                                                }}
                                            >
                                                <span
                                                    style={{
                                                        paddingLeft: 10,
                                                        fontSize: 14,
                                                        color: "#ccc",
                                                    }}
                                                >
                                                    {t("surname")}
                                                </span>
                                                <Input
                                                    name="surname"
                                                    style={{
                                                        fontSize: 18,
                                                    }}
                                                    value={surname}
                                                    placeholder={t("surname")}
                                                    onChange={(e) =>
                                                        setSurname(
                                                            e.target.value
                                                        )
                                                    }
                                                    bordered={false}
                                                />
                                            </Col>

                                            <Col
                                                span={24}
                                                style={{
                                                    borderBottom:
                                                        "1px solid #cccccc",
                                                    marginBottom: 30,
                                                }}
                                            >
                                                <span
                                                    style={{
                                                        paddingLeft: 10,
                                                        fontSize: 14,
                                                        color: "#ccc",
                                                    }}
                                                >
                                                    {t("phone")}
                                                </span>
                                                <Input
                                                    name="phone"
                                                    style={{
                                                        fontSize: 18,
                                                    }}
                                                    value={phone}
                                                    placeholder={t("phone")}
                                                    onChange={(e) =>
                                                        setPhone(e.target.value)
                                                    }
                                                    bordered={false}
                                                />
                                            </Col>
                                            <Col
                                                span={24}
                                                style={{
                                                    borderBottom:
                                                        "1px solid #cccccc",
                                                    marginBottom: 30,
                                                }}
                                            >
                                                <span
                                                    style={{
                                                        paddingLeft: 10,
                                                        fontSize: 14,
                                                        color: "#ccc",
                                                    }}
                                                >
                                                    {t("password")}
                                                </span>
                                                <Input
                                                    name="password"
                                                    style={{
                                                        fontSize: 18,
                                                    }}
                                                    type="password"
                                                    value={password}
                                                    placeholder={t("password")}
                                                    onChange={(e) =>
                                                        setPassword(
                                                            e.target.value
                                                        )
                                                    }
                                                    bordered={false}
                                                />
                                            </Col>
                                        </Row>
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
