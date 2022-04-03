import React from "react";
import { Input, Menu, Dropdown, Button } from "antd";
import { DownOutlined, SearchOutlined } from "@ant-design/icons";
import { RiMapPinAddFill } from "react-icons/ri";
import { FaLocationArrow } from "react-icons/fa";

export default ({ addresses, address, setAddress, shippingAddressOpen }) => {
    const menu = (
        <Menu
            style={{
                background: "#FFFFFF",
                border: "1px solid #EFEFEF",
                boxShadow: "0px 4px 40px rgba(196, 196, 196, 0.4)",
                borderRadius: "12px",
                marginTop: 8,
                padding: 10,
            }}
        >
            <Menu.Item key="0" disabled>
                <div className="d-flex flex-row justify-content-between align-items-center">
                    <Input
                        style={{
                            background: "#F8F8F8",
                            padding: 8,
                            borderRadius: "10px",
                        }}
                        bordered={false}
                        placeholder="Search address..."
                        prefix={<SearchOutlined size={14} />}
                    />
                    <Button
                        className="d-flex flex-row justify-content-center align-items-center custom-success-btn"
                        onClick={() => shippingAddressOpen(true)}
                        style={{
                            width: "50px",
                            height: "40px",
                            borderRadius: 10,
                            marginLeft: 10,
                        }}
                        icon={<RiMapPinAddFill size={14} />}
                    />
                </div>
            </Menu.Item>
            {addresses.map((item, idx) => (
                <React.Fragment key={`${idx + 1}`}>
                    <Menu.Item
                        style={{
                            backgroundColor:
                                item.address === address?.address
                                    ? "#45A524"
                                    : null,
                            color:
                                item.address === address?.address
                                    ? "#fff"
                                    : "#000",
                        }}
                        key={`${idx + 1}`}
                        onClick={() => setAddress(item)}
                    >
                        {item.address}
                    </Menu.Item>
                    <Menu.Divider />
                </React.Fragment>
            ))}
        </Menu>
    );

    return (
        <Dropdown overlay={menu} trigger={["click"]}>
            <div
                className="d-flex flex-row justify-content-around align-items-center"
                style={{
                    // margin: 5,
                    height: "100%",
                    filter: "drop-shadow(0px 4px 40px rgba(196, 196, 196, 0.15))",
                    borderRadius: "12px",
                }}
            >
                <FaLocationArrow size={14} />
                <span>Shipping address</span>
                <DownOutlined size={14} />
            </div>
        </Dropdown>
    );
};
