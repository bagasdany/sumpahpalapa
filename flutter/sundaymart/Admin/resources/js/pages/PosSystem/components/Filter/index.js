import {
    DeleteOutlined,
    GlobalOutlined,
    PrinterOutlined,
    SearchOutlined,
} from "@ant-design/icons";
import { Button, Col, Divider, Dropdown, Input, Row, Select, Menu } from "antd";
import React from "react";
import { useTranslation } from "react-i18next";
import { FiBell } from "react-icons/fi";
import i18next from "i18next";
import { RiGlobalLine } from "react-icons/ri";
const { Option } = Select;

const Filter = ({
    brand,
    shop,
    setCart,
    setSearch,
    search,
    category,
    setCategory,
    setShop,
    setBrand,
    brandOptions = [],
    categoryOptions = [],
    shopOptions = [],
}) => {
    const { t } = useTranslation();
    const langs = [
        {
            code: "ru",
            name: "Русский",
            countryCode: "ru",
        },
        {
            code: "gb",
            name: "English",
            countryCode: "gb",
        },
    ];

    const langMenu = (
        <Menu>
            {langs.map(({ code, name, countryCode }) => (
                <Menu.Item
                    key={countryCode}
                    onClick={() => {
                        i18next.changeLanguage(code);
                        localStorage.setItem("i18nextLng", code);
                    }}
                >
                    {name}
                </Menu.Item>
            ))}
        </Menu>
    );

    return (
        <Row gutter={10}>
            <Col
                span={24}
                style={{
                    marginBottom: 5,
                }}
            >
                <div className="custom-card d-flex flex-row justify-content-between align-items-center">
                    <div className="d-flex flex-row align-items-center">
                        <Dropdown overlay={langMenu} trigger={["click"]}>
                            <Button shape="circle">
                                <RiGlobalLine size={16} />
                            </Button>
                        </Dropdown>
                        {
                            false && (<Button
                                className="d-flex flex-row justify-content-center align-items-center"
                                shape="circle"
                                style={{
                                    marginLeft: 15,
                                }}
                                icon={<PrinterOutlined size={16} />}
                            />)
                        }
                        {
                            false && (
                                <Button
                                    className="d-flex flex-row justify-content-center align-items-center custom-danger-btn"
                                    shape="round"
                                    onClick={setCart}
                                    style={{
                                        marginLeft: 15,
                                    }}
                                    icon={<DeleteOutlined size={16} />}
                                >
                                    {t("clear_cache")}
                                </Button>
                            )
                        }
                    </div>
                    {
                        false && (
                            <Button
                                className="d-flex flex-row justify-content-center align-items-center custom-success-btn"
                                shape="circle"
                                icon={<FiBell size={16} />}
                            />
                        )
                    }
                </div>
            </Col>
            <Col span={24}>
                <div className="custom-card ">
                    <Row>
                        <Col
                            span={6}
                            className="d-flex flex-row align-items-center"
                        >
                            <Input
                                bordered={false}
                                // size="large"
                                value={search}
                                onChange={(e) => setSearch(e.target.value)}
                                placeholder={t("search_product")}
                                prefix={<SearchOutlined />}
                            />
                        </Col>
                        <Col
                            span={6}
                            className="d-flex flex-row align-items-center"
                        >
                            <Divider type="vertical" />
                            <Select
                                bordered={false}
                                style={{
                                    width: "100%",
                                }}
                                placeholder={t("select_shop")}
                                value={shop}
                                onChange={(e) => setShop(e)}
                            >
                                {shopOptions.map((item) => (
                                    <Option value={item.id} key={item.id}>
                                        {item.name}
                                    </Option>
                                ))}
                            </Select>
                        </Col>
                        <Col
                            span={6}
                            className="d-flex flex-row align-items-center"
                        >
                            <Divider type="vertical" />
                            <Select
                                bordered={false}
                                placeholder={t("select_brand")}
                                size="large"
                                value={brand}
                                onChange={(e) => setBrand(e)}
                                style={{
                                    width: "100%",
                                }}
                            >
                                {brandOptions.map((item) => (
                                    <Option value={item.id} key={item.id}>
                                        {item.name}
                                    </Option>
                                ))}
                            </Select>
                        </Col>
                        <Col
                            span={6}
                            className="d-flex flex-row align-items-center"
                        >
                            <Divider type="vertical" />
                            <Select
                                bordered={false}
                                placeholder={t("select_category")}
                                size="large"
                                value={category}
                                onChange={(e) => setCategory(e)}
                                style={{
                                    width: "100%",
                                }}
                            >
                                {categoryOptions.map((item) => (
                                    <Option value={item.id} key={item.id}>
                                        {item.name}
                                    </Option>
                                ))}
                            </Select>
                        </Col>
                    </Row>
                </div>
            </Col>
        </Row>
    );
};
export default Filter;
