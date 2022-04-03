import React from "react";
import PageLayout from "../../../layouts/PageLayout";
import {
    Breadcrumb,
    Button,
    Layout,
    Table,
    Space,
    PageHeader,
    Image,
    Checkbox,
    Tag,
    Popconfirm,
    message,
    Card,
    Select,
    DatePicker,
} from "antd";
import { Link } from "react-router-dom";

const { Content } = Layout;
const { Option } = Select;
import reqwest from "reqwest";
import orderDelete from "../../../requests/Orders/OrderDelete";
import { isAllowed } from "../../../helpers/IsAllowed";
import orderStatusActive from "../../../requests/OrderStatusActive";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../../global";

class Order extends React.Component {
    columns = [
        {
            title: "ID",
            dataIndex: "id",
        },
        {
            title: "Name",
            dataIndex: "user",
        },
        {
            title: "Shop",
            dataIndex: "shop",
        },
        {
            title: "Amount",
            dataIndex: "amount",
        },
        {
            title: "Order status",
            dataIndex: "order_status",
            render: (order_status, row) => {
                var order_status_colors = [
                    "default",
                    "processing",
                    "warning",
                    "success",
                    "error",
                ];
                return (
                    <Tag color={order_status_colors[row.order_status_id - 1]}>
                        {order_status}
                    </Tag>
                );
            },
        },
        {
            title: "Payment status",
            dataIndex: "payment_status",
            render: (payment_status, row) => {
                var payment_status_colors = ["success", "error"];
                return (
                    <Tag
                        color={payment_status_colors[row.payment_status_id - 1]}
                    >
                        {payment_status}
                    </Tag>
                );
            },
        },
        {
            title: "Payment methods",
            dataIndex: "payment_method",
            render: (payment_method, row) => {
                var payment_method_colors = [
                    "success",
                    "processing",
                    "warning",
                ];
                return (
                    <Tag
                        color={payment_method_colors[row.payment_method_id - 1]}
                    >
                        {payment_method}
                    </Tag>
                );
            },
        },
        {
            title: "Order date",
            dataIndex: "order_date",
        },
        {
            title: "Delivery date",
            dataIndex: "delivery_date",
        },
        {
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                return (
                    <div>
                        {options.edit && isAllowed("/orders/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/orders/edit",
                                        state: { id: row.id, edit: true },
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                            isAllowed("/orders/delete") &&
                            row.default != 1 && (
                                <Popconfirm
                                    title="Do you want to delete ?"
                                    visible={this.state.visible}
                                    onConfirm={() => this.handleOk(row.id)}
                                    okButtonProps={{
                                        loading: this.state.confirmLoading,
                                    }}
                                    onCancel={this.handleCancel}
                                >
                                    <Button
                                        type="link"
                                        className="text-danger"
                                        onClick={this.showPopconfirm}
                                    >
                                        Delete
                                    </Button>
                                </Popconfirm>
                            )}
                    </div>
                );
            },
        },
    ];

    state = {
        data: [],
        orderStatuses: [],
        shops: [],
        shop_id: undefined,
        order_date_from: undefined,
        order_date_to: undefined,
        date_from: undefined,
        date_to: undefined,
        status: undefined,
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
        this.fetchShops();
        this.fetchOrderStatus();
    }

    handleOk = async (id) => {
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            confirmLoading: true,
        });

        let data = await orderDelete(id);

        if (data.data.success == 1) {
            this.setState({
                confirmLoading: false,
                visibleConfirm: false,
            });
        }

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

    handleTableChange = (pagination, filters, sorter) => {
        this.fetch({
            sortField: sorter.field,
            sortOrder: sorter.order,
            pagination,
            ...filters,
        });

        this.setState({ pagination });
    };

    fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({ loading: true });
        reqwest({
            url:
                "/api/auth/order/datatable" +
                `?${
                    params.order_date_from
                        ? `&order_date_from=${params.order_date_from}`
                        : ""
                }${
                    params.order_date_to
                        ? `&order_date_to=${params.order_date_to}`
                        : ""
                }${params.status ? `&status=${params.status}` : ""}${
                    params.shop_id ? `&shop_id=${params.shop_id}` : ""
                }`,
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
    fetchOrderStatus = async () => {
        let data = await orderStatusActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                orderStatuses: data.data.data,
            });
        }
    };
    fetchShops = () => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/shop/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            this.setState({
                shops: data.data,
            });
        });
    };
    onChangeShop = (e) => {
        this.setState({
            shop_id: e,
        });
    };
    onChangeOrderStatus = (e) => {
        this.setState({
            status: e,
        });
    };
    onChangeFrom = (date, dateString) => {
        this.setState({
            date_from: date,
            order_date_from: dateString,
        });
    };
    onChangeTo = (date, dateString) => {
        this.setState({
            date_to: date,
            order_date_to: dateString,
        });
    };
    setFilter = (filter) => {
        this.fetch(filter);
    };
    clearFilter = (pagination) => {
        this.setState({
            shop_id: undefined,
            status: undefined,
            order_date_from: undefined,
            order_date_to: undefined,
            date_from: undefined,
            date_to: undefined,
        });
        this.fetch({ pagination });
    };
    render() {
        const {
            data,
            pagination,
            loading,
            orderStatuses,
            shops,
            status,
            shop_id,
            order_date_from,
            order_date_to,
            date_from,
            date_to,
        } = this.state;
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>{t("orders")}</Breadcrumb.Item>
                </Breadcrumb>
                <Card bordered={false}>
                    <div className="row">
                        <div className="col-md-2 col-sm-12 mb-2">
                            <Select
                                placeholder={t("select_shop")}
                                style={{ width: "100%" }}
                                onChange={this.onChangeShop}
                                value={shop_id}
                            >
                                {shops.map((item) => {
                                    return (
                                        <Option value={item.id} key={item.id}>
                                            {item.name}
                                        </Option>
                                    );
                                })}
                            </Select>
                        </div>
                        <div className="col-md-2 col-sm-12 mb-2">
                            <Select
                                placeholder={t("select_order_status")}
                                style={{ width: "100%" }}
                                onChange={this.onChangeOrderStatus}
                                value={status}
                            >
                                {orderStatuses.map((item) => {
                                    return (
                                        <Option value={item.id} key={item.id}>
                                            {item.name}
                                        </Option>
                                    );
                                })}
                            </Select>
                        </div>
                        <div className="col-md-2 col-sm-12 mb-2">
                            <DatePicker
                                style={{ width: "100%" }}
                                onChange={this.onChangeFrom}
                                placeholder={t("from")}
                                value={date_from}
                            />
                        </div>
                        <div className="col-md-2 col-sm-12 mb-2">
                            <DatePicker
                                style={{ width: "100%" }}
                                onChange={this.onChangeTo}
                                placeholder={t("to")}
                                value={date_to}
                            />
                        </div>
                        <div className="col-md-2 offset-md-2 col-sm-12 d-flex flex-row justify-content-end">
                            <Button
                                type="primary"
                                style={{ paddingLeft: 10, paddingRight: 10 }}
                                onClick={() =>
                                    this.setFilter({
                                        status,
                                        order_date_from,
                                        order_date_to,
                                        shop_id,
                                        pagination,
                                    })
                                }
                            >
                                {t("filter")}
                            </Button>
                            <Button
                                type="primary"
                                danger
                                style={{
                                    marginLeft: 10,
                                }}
                                onClick={() => this.clearFilter(pagination)}
                            >
                                {t("clear_filter")}
                            </Button>
                        </div>
                    </div>

                    <PageHeader
                        className="site-page-header"
                        title={t("orders")}
                        subTitle={t("create_remove_and_edit_orders")}
                        extra={
                            isAllowed("/orders/add") && [
                                <Link
                                    to="/orders/add"
                                    key="add_order"
                                    className="btn btn-success"
                                >
                                    {t("add_order")}
                                </Link>,
                            ]
                        }
                    >
                        <Content
                            className="site-layout-background"
                            style={{ overflow: "auto" }}
                        >
                            <Table
                                columns={this.columns}
                                rowKey={(record) => record.id}
                                dataSource={data}
                                pagination={pagination}
                                loading={loading}
                                onChange={this.handleTableChange}
                            />
                        </Content>
                    </PageHeader>
                </Card>
            </PageLayout>
        );
    }
}

export default withTranslation()(Order);
