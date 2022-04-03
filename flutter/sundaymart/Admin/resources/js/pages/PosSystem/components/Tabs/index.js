import {PlusOutlined, StepBackwardOutlined} from "@ant-design/icons";
import {Button, Col, Row, Select} from "antd";
import React, {useState} from "react";
import CustomSelect from "../Dropdown";
import ShippingSelect from "../DropdownShipping";
import {useTranslation} from "react-i18next";
import {RiCloseLine, RiShoppingBag3Fill} from "react-icons/ri";
import {MdLocalShipping} from "react-icons/md";
import {FiBell, FiClock} from "react-icons/fi";
import "./style.css";

const {Option} = Select;

export default ({
                    addresses,
                    onChangeUser,
                    setUserOpen,
                    userOptions,
                    shippingAddress,
                    setDeliveryOpen,
                    disable,
                    bagIndex,
                    cart,
                    setDeliveryTypeOpen,
                    setBagIndex,
                    setCart,
                    bags,
                    setBags,
                    handleChangeBadge,
                }) => {
    const {t} = useTranslation();

    const addBag = () => {
        if (bags.length < 4) {
            setBags((prev) => [...prev, prev.length + 1]);
            setCart((prev) => [
                ...prev,
                {
                    products: [],
                    total: 0,
                    tax: 0,
                    delivery_fee: 0,
                    user: undefined,
                    deliveryTime: undefined,
                    address: undefined,
                    deliveryDate: undefined,
                    shippingId: undefined,
                    shopId: undefined,
                },
            ]);
            setBagIndex(bagIndex + 1);
        }
    };

    const handleChangeAddress = (e) => {
        const newData = [...cart];
        newData[bagIndex].address = e;
        setCart(newData);
    };

    return (
        <div
            style={{
                borderRadius: 12,
                minWidth: "350px",
                width: "95%",
            }}
        >
            <div
                style={{
                    backgroundColor: "#f0f5f2",
                }}
                className="d-flex flex-row justify-content-between align-items-center"
            >
                <ul
                    className="tabs"
                    style={{
                        minWidth: "200px",
                        listStyle: "none",
                    }}
                >
                    {bags.map((item, idx) =>
                        idx === bagIndex ? (
                            <li
                                key={idx}
                                className="active"
                                onClick={() => handleChangeBadge(idx)}
                            >
                                <span className="d-flex flex-row align-items-center">
                                    <RiShoppingBag3Fill
                                        style={{
                                            marginRight: "10px",
                                        }}
                                    />
                                    Bag-{item}
                                    {/*<div className="closeTab" onClick={() => remove(idx)}>*/}
                                    {/*    <RiCloseLine/>*/}
                                    {/*</div>*/}
                                </span>
                            </li>
                        ) : (
                            <li
                                key={idx}
                                onClick={() => handleChangeBadge(idx)}
                            >
                                <span className="d-flex flex-row align-items-center">
                                    Bag-{item}
                                </span>
                            </li>
                        )
                    )}
                </ul>
                <Button
                    onClick={addBag}
                    className="d-flex flex-row justify-content-center align-items-center custom-success-btn"
                    shape="circle"
                    style={{
                        marginRight: 10,
                    }}
                    icon={<PlusOutlined/>}
                />
            </div>
            <div className="custom-tabs-content">
                <div
                    style={{
                        padding: 15,
                    }}
                >
                    <Row
                        gutter={[10, 20]}
                        style={{
                            marginBottom: 15,
                        }}
                    >
                        <Col
                            span={11}
                            style={{
                                minHeight: 40,
                                borderRadius: 12,
                                border: "1px solid #EFEFEF",
                                filter: "drop-shadow(0px 4px 40px rgba(196, 196, 196, 0.15))",
                            }}
                        >
                            <CustomSelect
                                userOptions={userOptions}
                                user={cart[bagIndex].user}
                                onChangeUser={onChangeUser}
                                setUserOpen={setUserOpen}
                            />
                        </Col>
                        <Col
                            offset={1}
                            span={11}
                            style={{
                                minHeight: 40,
                                borderRadius: 12,
                                border: "1px solid #EFEFEF",
                                filter: "drop-shadow(0px 4px 40px rgba(196, 196, 196, 0.15))",
                            }}
                        >
                            <ShippingSelect
                                addresses={addresses}
                                cart={cart}
                                address={cart[bagIndex].address}
                                setAddress={handleChangeAddress}
                                shippingAddressOpen={shippingAddress}
                            />
                        </Col>

                        <Col
                            className="p-0"
                            span={11}
                            style={{
                                minHeight: 40,
                            }}
                        >
                            <Button
                                disabled={disable}
                                className=" d-flex flex-row justify-content-center align-items-center"
                                style={{
                                    width: "100%",
                                    backgroundColor: "#F8F8F8",
                                    borderRadius: 12,
                                    border: "none",
                                    minHeight: 40,
                                    color: "#161616",
                                }}
                                onClick={() => setDeliveryTypeOpen(true)}
                                type="primary"
                                icon={
                                    <MdLocalShipping
                                        size={14}
                                        style={{
                                            marginRight: 10,
                                        }}
                                    />
                                }
                            >
                                {t("shipping_type")}
                            </Button>
                        </Col>
                        <Col
                            offset={1}
                            span={11}
                            style={{
                                minHeight: 40,
                            }}
                            className="p-0"
                        >
                            <Button
                                disabled={disable}
                                className=" d-flex flex-row justify-content-center align-items-center"
                                style={{
                                    width: "100%",
                                    backgroundColor: "#F8F8F8",
                                    borderRadius: 12,
                                    border: "none",
                                    minHeight: 40,
                                    color: "#161616",
                                }}
                                onClick={() => setDeliveryOpen(true)}
                                type="primary"
                                icon={
                                    <FiClock
                                        size={14}
                                        style={{
                                            marginRight: 10,
                                        }}
                                    />
                                }
                            >
                                {t("add_delivery_time")}
                            </Button>
                        </Col>
                    </Row>
                </div>
            </div>
        </div>
    );
};
