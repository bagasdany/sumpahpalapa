import React from "react";
import PageLayout from "../../layouts/PageLayout";
import {
    Breadcrumb,
    PageHeader,
    message,
    Row,
    Col,
    Card,
    Select,
    Button,
    Divider,
    Input,
    Layout,
    Menu,
    Dropdown,
    Avatar,
} from "antd";
const { Footer, Content } = Layout;
const { Option } = Select;
const { Item } = Menu;
import reqwest from "reqwest";
import {
    BellOutlined,
    CarOutlined,
    CloseOutlined,
    DeleteOutlined,
    GlobalOutlined,
    LogoutOutlined,
    MinusOutlined,
    PlusOutlined,
    PrinterOutlined,
    SearchOutlined,
} from "@ant-design/icons";
import image from "./image/image.png";
import Sidebar from "../../layouts/Sidebar";
import ChatButton from "../../layouts/ChatButton";
import { FiBell } from "react-icons/fi";
import { withTranslation } from "react-i18next";

class PosSystem extends React.Component {
    state = {
        data: [],
        isOpen: false,
        staticData: [],
        pagination: {
            current: 1,
            pageSize: 10,
        },
        loading: false,
        visibleConfirm: false,
        confirmLoading: false,
    };

    componentDidMount() {
        const { pagination } = this.state;
        this.fetch({ pagination });
    }

    handleOk = async (id) => {
        this.setState({
            confirmLoading: true,
        });

        // let data = await shopDelete(id);
        //
        // if (data.data.success == 1) {
        //     this.setState({
        //         confirmLoading: false,
        //         visibleConfirm: false
        //     });
        // }
        message.warn("You cannot delete in demo mode");

        const { pagination } = this.state;
        this.fetch({ pagination });
    };

    handleCancel = () => {
        this.setState({
            visibleConfirm: false,
        });
    };

    showPopconfirm = () => {
        this.setState({
            visibleConfirm: true,
        });
    };

    fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({ loading: true });
        reqwest({
            url: "/api/auth/shop/datatable",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                length: params.pagination.pageSize,
                start:
                    (params.pagination.current - 1) *
                    params.pagination.pageSize,
            },
        }).then((data) => {
            this.setState({
                loading: false,
                data: data.data,
                pagination: {
                    current: params.pagination.current,
                    pageSize: 10,
                    total: data.total,
                },
            });
        });
    };
    addProduct = () => {
        let newData = this.state.staticData;
        let newProd = { name: "Product name", qty: 1, price: 53.54 };
        if (newData.includes(newProd)) {
            message.warn("This product already exist!");
        } else {
            newData.push(newProd);
        }
        this.setState({
            staticData: newData,
        });
    };
    deleteProduct = (idx) => {
        let newData = this.state.staticData;
        newData = newData.filter((item, index) => index !== idx);
        this.setState({
            staticData: newData,
        });
    };
    increaseQuantity = (idx) => {
        const newData = [...this.state.staticData];
        newData[idx].qty += 1;
        this.setState({
            staticData: newData,
        });
    };
    decreaseQuantity = (idx) => {
        const newData = [...this.state.staticData];
        if (newData[idx].qty > 1) {
            newData[idx].qty -= 1;
        }
        this.setState({
            staticData: newData,
        });
    };
    clearCart = () => {
        this.setState({
            staticData: [],
        });
    };
    openConfirmOrder = () => {
        this.setState({
            isOpen: true,
        });
    };
    closeConfirmOrder = () => {
        this.setState({
            isOpen: false,
        });
        console.log("Close");
    };
    render() {
        const { data, pagination, loading, staticData, isOpen } = this.state;
        const { t } = this.props;
        return (
            <>
                <Layout
                    style={{
                        minHeight: "100vh",
                    }}
                >
                    <Sidebar />
                    <Layout
                        className="site-layout"
                        style={{
                            position: "relative",
                        }}
                    >
                        <Row
                            style={{
                                marginTop: 10,
                                marginLeft: 10,
                                marginRight: 10,
                                overflow: "hidden",
                            }}
                            gutter={10}
                        >
                            <Col span={15}>
                                <div className="custom-card">
                                    <Row>
                                        <Col span={8}>
                                            <Input
                                                bordered={false}
                                                size="large"
                                                placeholder={t(
                                                    "search_product"
                                                )}
                                                prefix={<SearchOutlined />}
                                            />
                                        </Col>
                                        <Col
                                            span={8}
                                            className="d-flex flex-row align-items-center"
                                        >
                                            <Divider type="vertical" />
                                            <Select
                                                bordered={false}
                                                placeholder={t(
                                                    "all_categories"
                                                )}
                                                size="large"
                                                onChange={() => {}}
                                                style={{
                                                    width: "100%",
                                                }}
                                            >
                                                <Option>Option 1</Option>
                                                <Option>Option 2</Option>
                                            </Select>
                                        </Col>
                                        <Col
                                            span={8}
                                            className="d-flex flex-row align-items-center"
                                        >
                                            <Divider type="vertical" />
                                            <Select
                                                bordered={false}
                                                placeholder={t("all_brands")}
                                                size="large"
                                                // onChange={() => {}}
                                                style={{
                                                    width: "100%",
                                                }}
                                            >
                                                <Option>Option 1</Option>
                                                <Option>Option 2</Option>
                                            </Select>
                                        </Col>
                                    </Row>
                                </div>
                            </Col>
                            <Col span={15}>
                                <div className="custom-card">
                                    <Row>
                                        <Col
                                            span={12}
                                            className="d-flex flex-row justify-content-around align-items-center"
                                        >
                                            <Button
                                                className="d-flex flex-row justify-content-center align-items-center"
                                                shape="circle"
                                                icon={
                                                    <GlobalOutlined size={16} />
                                                }
                                            />
                                            <Button
                                                className="d-flex flex-row justify-content-center align-items-center"
                                                shape="circle"
                                                icon={
                                                    <PrinterOutlined
                                                        size={16}
                                                    />
                                                }
                                            />
                                            <Button
                                                className="d-flex flex-row justify-content-center align-items-center custom-danger-btn"
                                                shape="round"
                                                icon={
                                                    <DeleteOutlined size={16} />
                                                }
                                            >
                                                {t("clear_cache")}
                                            </Button>
                                        </Col>
                                        <Col
                                            span={12}
                                            className="d-flex flex-row justify-content-end align-items-center"
                                        >
                                            <Button
                                                className="d-flex flex-row justify-content-center align-items-center custom-success-btn"
                                                shape="circle"
                                                icon={<FiBell size={16} />}
                                            />
                                            <div
                                                style={{
                                                    marginLeft: 10,
                                                    marginRight: 10,
                                                }}
                                            >
                                                <Dropdown
                                                    overlay={
                                                        <Menu>
                                                            <Item
                                                                key="4"
                                                                icon={
                                                                    <LogoutOutlined />
                                                                }
                                                            >
                                                                {t("logout")}
                                                            </Item>
                                                        </Menu>
                                                    }
                                                    trigger={["click"]}
                                                >
                                                    <Avatar src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png" />
                                                </Dropdown>
                                            </div>
                                            <div className="d-flex flex-column">
                                                <span
                                                    style={{
                                                        fontWeight: "bold",
                                                    }}
                                                >
                                                    Muhammad J.
                                                </span>
                                                <span
                                                    style={{
                                                        fontSize: "10px",
                                                    }}
                                                >
                                                    Admin
                                                </span>
                                            </div>
                                        </Col>
                                    </Row>
                                </div>
                            </Col>
                        </Row>
                        <Content style={{ margin: "16px" }}>
                            <Row gutter={10}>
                                <Col span={16}>
                                    <PageHeader
                                        title="All Products"
                                        style={{
                                            backgroundColor:
                                                "#ECEFF3!important",
                                        }}
                                    >
                                        <Row gutter={[10, 10]}>
                                            {Array.from({ length: 20 }).map(
                                                (_, idx) => (
                                                    <Col key={idx}>
                                                        <div
                                                            className="custom-card"
                                                            style={{
                                                                minWidth:
                                                                    "227px",
                                                                minHeight:
                                                                    "246px",
                                                            }}
                                                        >
                                                            <div className="stock-count">
                                                                {t("instock")} -
                                                                500
                                                            </div>
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
                                                                        minHeight:
                                                                            "130px",
                                                                    }}
                                                                >
                                                                    <img
                                                                        src={
                                                                            image
                                                                        }
                                                                        height="131px"
                                                                        alt=""
                                                                    />
                                                                </div>
                                                                <div
                                                                    style={{
                                                                        marginTop: 15,
                                                                        marginBottom: 8,
                                                                    }}
                                                                >
                                                                    Product name
                                                                </div>
                                                                <div className="d-flex flex-row">
                                                                    <span
                                                                        style={{
                                                                            color: "#C0C2CC",
                                                                        }}
                                                                    >
                                                                        $7.99
                                                                    </span>
                                                                    <span
                                                                        style={{
                                                                            fontWeight:
                                                                                "bold",
                                                                            marginLeft: 10,
                                                                        }}
                                                                    >
                                                                        $6.28
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div
                                                                className="plus-button"
                                                                onClick={() =>
                                                                    this.addProduct()
                                                                }
                                                            >
                                                                <PlusOutlined
                                                                    style={{
                                                                        color: "#fff",
                                                                        fontSize:
                                                                            "35px",
                                                                        fontWeight:
                                                                            "bold",
                                                                    }}
                                                                />
                                                            </div>
                                                        </div>
                                                    </Col>
                                                )
                                            )}
                                        </Row>
                                    </PageHeader>
                                </Col>
                                <Col span={8}>
                                    <Row
                                        gutter={5}
                                        style={{
                                            marginBottom: 10,
                                        }}
                                    >
                                        <Col span={19}>
                                            <div className="custom-card">
                                                <Select
                                                    bordered={false}
                                                    placeholder={t(
                                                        "walk_in_customer"
                                                    )}
                                                    size="large"
                                                    onChange={() => {}}
                                                    style={{ width: "100%" }}
                                                >
                                                    <Option>Option 1</Option>
                                                    <Option>Option 2</Option>
                                                </Select>
                                            </div>
                                        </Col>
                                        <Col span={5}>
                                            <div className="custom-card">
                                                <Button
                                                    className="d-flex flex-row justify-content-center align-items-center"
                                                    style={{
                                                        width: "100%",
                                                        border: "none",
                                                        // borderRadius: 8,
                                                    }}
                                                    icon={
                                                        <CarOutlined
                                                            style={{
                                                                fontSize:
                                                                    "24px",
                                                            }}
                                                        />
                                                    }
                                                    size="large"
                                                />
                                            </div>
                                        </Col>
                                    </Row>

                                    <Card
                                        title={`${staticData.length}  products`}
                                        headStyle={{ fontWeight: "bold" }}
                                        style={{
                                            // minWidth: 400,
                                            height: 600,
                                            overflow: "auto",
                                        }}
                                        extra={
                                            <Button
                                                danger
                                                type="primary"
                                                onClick={() => this.clearCart()}
                                                style={{
                                                    borderRadius: 20,
                                                    fontSize: 10,
                                                    backgroundColor: "#DE1F36",
                                                }}
                                            >
                                                {t("clear_all")}
                                            </Button>
                                        }
                                    >
                                        {staticData.map((item, idx) => (
                                            <Row
                                                key={idx}
                                                gutter={8}
                                                className="d-flex flex-row align-items-center"
                                                style={{
                                                    backgroundColor: "#FAFAFA",
                                                    borderRadius: 10,
                                                    padding: 10,
                                                    minHeight: 124,
                                                    marginBottom: 10,
                                                }}
                                            >
                                                <Col span={8}>
                                                    <div className="custom-card d-flex flex-row justify-content-center align-items-center">
                                                        <img
                                                            src={image}
                                                            width="90px"
                                                            height="90px"
                                                        />
                                                    </div>
                                                </Col>
                                                <Col span={16}>
                                                    <div className="d-flex flex-column justify-content-between ">
                                                        <h5>{item.name}</h5>
                                                        <div
                                                            className="row"
                                                            className=" d-flex flex-row"
                                                        >
                                                            <div className="col-3 d-flex flex-row align-items-center p-0">
                                                                <span
                                                                    style={{
                                                                        fontWeight:
                                                                            "bold",
                                                                    }}
                                                                >
                                                                    $
                                                                    {(
                                                                        item.price *
                                                                        item.qty
                                                                    ).toFixed(
                                                                        2
                                                                    )}
                                                                </span>
                                                            </div>
                                                            <div className="col-6 d-flex flex-row justify-content-between align-items-center">
                                                                <Button
                                                                    className="d-flex flex-row justify-content-center align-items-center"
                                                                    shape="circle"
                                                                    disabled={
                                                                        item.qty ===
                                                                        1
                                                                    }
                                                                    onClick={() =>
                                                                        this.decreaseQuantity(
                                                                            idx
                                                                        )
                                                                    }
                                                                    icon={
                                                                        <MinusOutlined
                                                                            size={
                                                                                16
                                                                            }
                                                                        />
                                                                    }
                                                                />
                                                                {item.qty}
                                                                <Button
                                                                    className="d-flex flex-row justify-content-center align-items-center"
                                                                    onClick={() =>
                                                                        this.increaseQuantity(
                                                                            idx
                                                                        )
                                                                    }
                                                                    shape="circle"
                                                                    icon={
                                                                        <PlusOutlined
                                                                            size={
                                                                                16
                                                                            }
                                                                        />
                                                                    }
                                                                />
                                                            </div>
                                                            <div
                                                                className="col-3 d-flex flex-row align-items-center p-0"
                                                                style={{
                                                                    marginLeft: 8,
                                                                }}
                                                            >
                                                                <Button
                                                                    className="d-flex flex-row justify-content-center align-items-center"
                                                                    onClick={() =>
                                                                        this.deleteProduct(
                                                                            idx
                                                                        )
                                                                    }
                                                                    danger
                                                                    type="primary"
                                                                    shape="circle"
                                                                    icon={
                                                                        <DeleteOutlined
                                                                            size={
                                                                                16
                                                                            }
                                                                        />
                                                                    }
                                                                />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </Col>
                                            </Row>
                                        ))}

                                        <Divider />
                                        <Row>
                                            <Col
                                                span={24}
                                                className="d-flex flex-row justify-content-between"
                                            >
                                                <h5>{t("sub_total")}</h5>
                                                <span>$36.20</span>
                                            </Col>
                                        </Row>
                                        <Divider />
                                        <Row>
                                            <Col
                                                span={24}
                                                className="d-flex flex-row justify-content-between"
                                            >
                                                <h5>{t("discount")}</h5>
                                                <span>$0</span>
                                            </Col>
                                            <Col
                                                span={24}
                                                className="d-flex flex-row justify-content-between"
                                            >
                                                <h5>{t("delivery")}</h5>
                                                <span>$0</span>
                                            </Col>
                                        </Row>
                                        <Divider />
                                        <Row>
                                            <Col
                                                span={24}
                                                className="d-flex flex-row justify-content-between"
                                            >
                                                <h5>{t("total_amount")}</h5>
                                                <span>$36.20</span>
                                            </Col>
                                        </Row>
                                    </Card>
                                    <Card
                                        style={{
                                            marginTop: 10,
                                        }}
                                    >
                                        <Row
                                            gutter={10}
                                            className="d-flex flex-row justify-content-between align-items-center"
                                        >
                                            <Col span={7}>
                                                <div className="custom-select-component">
                                                    <Select
                                                        bordered={false}
                                                        placeholder={t(
                                                            "shipping"
                                                        )}
                                                        size="large"
                                                        onChange={() => {}}
                                                        style={{
                                                            width: "100%",
                                                        }}
                                                    >
                                                        <Option>
                                                            Option 1
                                                        </Option>
                                                        <Option>
                                                            Option 2
                                                        </Option>
                                                    </Select>
                                                </div>
                                            </Col>
                                            <Col span={7}>
                                                <div className="custom-select-component">
                                                    <Select
                                                        bordered={false}
                                                        placeholder={t(
                                                            "discount"
                                                        )}
                                                        size="large"
                                                        onChange={() => {}}
                                                        style={{
                                                            width: "100%",
                                                        }}
                                                    >
                                                        <Option>
                                                            Option 1
                                                        </Option>
                                                        <Option>
                                                            Option 2
                                                        </Option>
                                                    </Select>
                                                </div>
                                            </Col>
                                            <Col
                                                span={10}
                                                className="d-flex flex-row justify-content-end"
                                            >
                                                <button
                                                    className="custom-primary-btn"
                                                    onClick={() =>
                                                        this.openConfirmOrder()
                                                    }
                                                >
                                                    {t("place_order")}
                                                </button>
                                            </Col>
                                        </Row>
                                    </Card>
                                </Col>
                            </Row>
                            {isOpen ? (
                                <div className="order-container">
                                    <Row>
                                        <Col span={16}></Col>
                                        <Col
                                            span={8}
                                            style={{
                                                height: "100%",
                                                backgroundColor: "#fff",
                                                minHeight: "100vh",
                                                padding: 30,
                                            }}
                                        >
                                            <Row>
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
                                                        onClick={() =>
                                                            this.closeConfirmOrder()
                                                        }
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
                                                    minHeight: 500,
                                                }}
                                            >
                                                {Array.from({ length: 3 }).map(
                                                    (_, idx) => (
                                                        <Row
                                                            key={idx}
                                                            gutter={8}
                                                            className="d-flex flex-row align-items-center"
                                                            style={{
                                                                borderRadius: 10,
                                                                padding: 10,
                                                                marginBottom: 10,
                                                                border: "1px solid #EFEFEF",
                                                            }}
                                                        >
                                                            <Col span={8}>
                                                                <div className="d-flex flex-row justify-content-center align-items-center custom-card">
                                                                    <img
                                                                        src={
                                                                            image
                                                                        }
                                                                        width="90px"
                                                                        height="90px"
                                                                    />
                                                                </div>
                                                            </Col>
                                                            <Col span={16}>
                                                                <div className="d-flex flex-column justify-content-between ">
                                                                    <h5>
                                                                        {t(
                                                                            "product_name"
                                                                        )}
                                                                    </h5>
                                                                    <div
                                                                        className="row"
                                                                        className=" d-flex flex-row"
                                                                    >
                                                                        <div className="p-0">
                                                                            <span
                                                                                style={{
                                                                                    fontWeight:
                                                                                        "bold",
                                                                                }}
                                                                            >
                                                                                $
                                                                                120.56
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
                                                                            4
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </Col>
                                                        </Row>
                                                    )
                                                )}
                                            </div>
                                            <Divider />
                                            <Row>
                                                <Col
                                                    span={24}
                                                    className="d-flex flex-row justify-content-between align-items-center"
                                                >
                                                    <h4>
                                                        {t(
                                                            "total_product_price"
                                                        )}
                                                    </h4>
                                                    <span
                                                        style={{
                                                            fontWeight: "bold",
                                                        }}
                                                    >
                                                        $36.10
                                                    </span>
                                                </Col>
                                            </Row>
                                            <Divider />
                                            <Row>
                                                <Col span={24}>
                                                    <div
                                                        className="d-flex flex-row justify-content-between align-items-center"
                                                        style={{
                                                            padding: "9px",
                                                        }}
                                                    >
                                                        <h4>{t("discount")}</h4>
                                                        <span
                                                            style={{
                                                                fontWeight:
                                                                    "bold",
                                                            }}
                                                        >
                                                            $36.10
                                                        </span>
                                                    </div>
                                                    <div
                                                        className="d-flex flex-row justify-content-between align-items-center"
                                                        style={{
                                                            padding: "9px",
                                                        }}
                                                    >
                                                        <h4>{t("delivery")}</h4>
                                                        <span
                                                            style={{
                                                                fontWeight:
                                                                    "bold",
                                                            }}
                                                        >
                                                            $36.10
                                                        </span>
                                                    </div>
                                                    <div
                                                        className="d-flex flex-row justify-content-between align-items-center"
                                                        style={{
                                                            padding: "9px",
                                                        }}
                                                    >
                                                        <h4>
                                                            {t("tax_price")}
                                                        </h4>
                                                        <span
                                                            style={{
                                                                fontWeight:
                                                                    "bold",
                                                            }}
                                                        >
                                                            $36.10
                                                        </span>
                                                    </div>
                                                    <div
                                                        className="d-flex flex-row justify-content-between align-items-center"
                                                        style={{
                                                            padding: "9px",
                                                        }}
                                                    >
                                                        <h4>{t("coupon")}</h4>
                                                        <span
                                                            style={{
                                                                fontWeight:
                                                                    "bold",
                                                            }}
                                                        >
                                                            $36.10
                                                        </span>
                                                    </div>
                                                </Col>
                                            </Row>
                                            <Divider />
                                            <Row>
                                                <Col
                                                    span={24}
                                                    className="d-flex flex-row justify-content-between align-items-center"
                                                >
                                                    <h4>{t("total_amount")}</h4>
                                                    <span
                                                        style={{
                                                            fontWeight: "bold",
                                                            fontSize: "24px",
                                                        }}
                                                    >
                                                        $36.10
                                                    </span>
                                                </Col>
                                            </Row>
                                            <Row
                                                style={{
                                                    marginTop: 30,
                                                }}
                                            >
                                                <Col
                                                    span={24}
                                                    className="d-flex flex-row justify-content-around align-items-center"
                                                >
                                                    <button
                                                        className="custom-secondary-btn"
                                                        style={{
                                                            padding:
                                                                "15px 50px",
                                                        }}
                                                    >
                                                        {t("cancel")}
                                                    </button>
                                                    <button
                                                        className="custom-primary-btn"
                                                        style={{
                                                            padding:
                                                                "15px 40px",
                                                        }}
                                                    >
                                                        {t("order_now")}
                                                    </button>
                                                </Col>
                                            </Row>
                                        </Col>
                                    </Row>
                                </div>
                            ) : null}
                        </Content>
                        <ChatButton />
                        <Footer style={{ textAlign: "center" }}>
                            Gmarket 2021
                        </Footer>
                    </Layout>
                </Layout>
            </>
        );
    }
}

export default withTranslation()(PosSystem);
