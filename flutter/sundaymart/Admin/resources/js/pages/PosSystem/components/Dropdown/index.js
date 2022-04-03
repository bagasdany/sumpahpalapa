import React from "react";
import { Select, Input, Menu, Dropdown, Button } from "antd";
import { DownOutlined, SearchOutlined } from "@ant-design/icons";
import { RiUserAddFill, RiUser6Fill } from "react-icons/ri";
const { Option } = Select;

export default ({ user, setUserOpen, userOptions, onChangeUser }) => {
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
                        placeholder="Search user..."
                        prefix={<SearchOutlined />}
                    />
                    <Button
                        className="d-flex flex-row justify-content-center align-items-center custom-success-btn"
                        onClick={() => setUserOpen(true)}
                        style={{
                            width: "50px",
                            height: "40px",
                            borderRadius: 10,
                            marginLeft: 10,
                        }}
                        icon={<RiUserAddFill />}
                    />
                </div>
            </Menu.Item>
            {userOptions.map((item, idx) => (
                <React.Fragment key={`${idx + 1}`}>
                    <Menu.Item
                        
                        key={`${idx + 1}`}
                        onClick={() => onChangeUser(item)}
                    >
                        {item.name}
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
                    height: "100%",
                    filter: "drop-shadow(0px 4px 40px rgba(196, 196, 196, 0.15))",
                    borderRadius: "12px",
                }}
            >
                <RiUser6Fill />
                <span>{user ? user.name : "Select user"}</span>
                <DownOutlined />
            </div>
        </Dropdown>
    );
};
