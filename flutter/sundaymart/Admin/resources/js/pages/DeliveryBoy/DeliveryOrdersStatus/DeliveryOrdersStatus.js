import React, { useEffect, useState } from "react";
import PageLayout from "../../../layouts/PageLayout";
import {
    Breadcrumb,
    PageHeader,
    Layout,
    Table,
    Button,
    Card,
    Select,
    DatePicker,
    Tag,
} from "antd";
import getDeliveryBoyData from "../../../requests/DeliveryBoy/DeliveryBoyList";
import { Link } from "react-router-dom";
import { isAllowed } from "../../../helpers/IsAllowed";
import reqwest from "reqwest";
import orderStatusActive from "../../../requests/OrderStatusActive";
import { withTranslation } from "react-i18next";

const { Content } = Layout;
const { Option } = Select;

class DeliveryOrdersStatus extends React.Component {
    orderColumns = [
        {
            title: "ID",
            dataIndex: "id",
        },
        {
            title: "Delivery Boy",
            dataIndex: "delivery_boy",
        },
        {
            title: "Amount",
            dataIndex: "amount",
        },
        {
            title: "Delivery Date",
            dataIndex: "delivery_date",
        },
        {
            title: "Order Status",
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
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                return (
                    <div>
                        {row.options?.edit && isAllowed("/orders/edit") && (
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
                    </div>
                );
            },
        },
    ];
    deliveryBoyColumns = [
        {
            title: "Deliveryboy",
            dataIndex: "name",
        },
        {
            title: "Accepted",
            dataIndex: "accepted",
            render: (accepted, row) => {
                return accepted ? accepted : 0;
            },
        },
        {
            title: "Ready to Delivery",
            dataIndex: "ready_to_delvery",
            render: (ready_to_delvery, row) => {
                return ready_to_delvery ? ready_to_delvery : 0;
            },
        },
        {
            title: "In a Way",
            dataIndex: "in_a_way",
            render: (in_a_way, row) => {
                return in_a_way ? in_a_way : 0;
            },
        },
        {
            title: "Delivered",
            dataIndex: "delivered",
            render: (delivered, row) => {
                return delivered ? delivered : 0;
            },
        },
        {
            title: "Canceled",
            dataIndex: "canceled",
            render: (canceled, row) => {
                return canceled ? canceled : 0;
            },
        },
        {
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                return (
                    <div>
                        {row.options?.edit && isAllowed("/admins/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/admins/edit",
                                        state: { id: row.id, edit: true },
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                    </div>
                );
            },
        },
    ];

    constructor(props) {
        super(props);

        this.state = {
            orderData: [],
            deliveryBoyData: [],
            orderStatuses: [],
            deliveryBoys: [],
            id_delivery_boy: undefined,
            order_date_from: undefined,
            order_date_to: undefined,
            date_from: undefined,
            date_to: undefined,
            status: undefined,
            orderPagination: {
                current: 1,
                pageSize: 10,
            },
            deliveryPagination: {
                current: 1,
                pageSize: 10,
            },
            loading: false,
            visibleConfirm: false,
            confirmLoading: false,
        };

        this.onChangeTo = this.onChangeTo.bind(this);
        this.onChangeFrom = this.onChangeFrom.bind(this);
        this.onChangeDeliveryBoy = this.onChangeDeliveryBoy.bind(this);
        this.onChangeOrderStatus = this.onChangeOrderStatus.bind(this);
        this.setFilter = this.setFilter.bind(this);
        this.clearFilter = this.clearFilter.bind(this);
    }
    componentDidMount() {
        const { orderPagination, deliveryPagination } = this.state;
        this.fetch({ orderPagination });
        this.fetchDeliveryBoyList({ deliveryPagination });
        this.fetchOrderStatus();
        this.fetchDeliveryBoys();
    }

    handleTableChange = (pagination, filters, sorter) => {
        this.fetch({
            sortField: sorter.field,
            sortOrder: sorter.order,
            orderPagination: pagination,
            ...filters,
        });
        this.setState({ orderPagination: pagination });
    };
    handleDeliveryBoyTableChange = (pagination, filters, sorter) => {
        this.fetchDeliveryBoyList({
            sortField: sorter.field,
            sortOrder: sorter.order,
            deliveryPagination: pagination,
            ...filters,
        });

        this.setState({ deliveryPagination: pagination });
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
                    params.id_delivery_boy
                        ? `&id_delivery_boy=${params.id_delivery_boy}`
                        : ""
                }`,
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                length: params.orderPagination.pageSize,
                start:
                    (params.orderPagination.current - 1) *
                    params.orderPagination.pageSize,
            },
        }).then((data) => {
            this.setState({
                loading: false,
                orderData: data.data,
                orderPagination: {
                    current: params.orderPagination.current,
                    pageSize: 10,
                    total: data.total,
                },
            });
        });
    };
    fetchDeliveryBoyList = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({ loading: true });
        reqwest({
            url:
                "/api/auth/admin/delivery-boys" +
                `?${
                    params.order_date_from
                        ? `&order_date_from=${params.order_date_from}`
                        : ""
                }${
                    params.order_date_to
                        ? `&order_date_to=${params.order_date_to}`
                        : ""
                }${params.status ? `&status=${params.status}` : ""}${
                    params.id_delivery_boy
                        ? `&id_delivery_boy=${params.id_delivery_boy}`
                        : ""
                }`,
            method: "get",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                length: params.deliveryPagination.pageSize,
                start:
                    (params.deliveryPagination.current - 1) *
                    params.deliveryPagination.pageSize,
            },
        }).then((data) => {
            this.setState({
                loading: false,
                deliveryBoyData: data.data.map((item) => ({
                    ...item,
                    accepted: item.orders_count?.accepted,
                    delivered: item.orders_count?.delivered,
                    in_a_way: item.orders_count?.in_a_way,
                    ready_to_delivery: item.orders_count?.ready_to_delivery,
                    canceled: item.orders_count?.canceled,
                    options: { edit: 1 },
                })),
                deliveryPagination: {
                    current: params.deliveryPagination.current,
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
    fetchDeliveryBoys = () => {
        const token = localStorage.getItem("jwt_token");
        this.setState({ loading: true });
        reqwest({
            url: "/api/auth/admin/delivery-boys",
            method: "get",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            this.setState({
                loading: false,
                deliveryBoys: data.data,
            });
        });
    };
    onChangeDeliveryBoy = (e) => {
        this.setState({
            id_delivery_boy: e,
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
        this.fetchDeliveryBoyList(filter);
    };
    clearFilter = (orderPagination, deliveryPagination) => {
        this.setState({
            id_delivery_boy: undefined,
            status: undefined,
            order_date_from: undefined,
            order_date_to: undefined,
            date_from: undefined,
            date_to: undefined,
        });
        this.fetch({ orderPagination });
        this.fetchDeliveryBoyList({ deliveryPagination });
    };
    render() {
        const {
            orderData,
            orderPagination,
            deliveryPagination,
            loading,
            orderStatuses,
            deliveryBoys,
            status,
            id_delivery_boy,
            order_date_from,
            order_date_to,
            date_from,
            date_to,
            deliveryBoyData,
        } = this.state;
        const { t } = this.props;
        return (
            <>
                <PageLayout>
                    <Breadcrumb style={{ margin: "16px 0" }}>
                        <Breadcrumb.Item>{t("orders")}</Breadcrumb.Item>
                    </Breadcrumb>
                    <Card bordered={false}>
                        <div className="row">
                            <div className="col-md-2 col-sm-12 mb-2">
                                <Select
                                    placeholder={t("select_delivery_boy")}
                                    style={{ width: "100%" }}
                                    onChange={this.onChangeDeliveryBoy}
                                    value={id_delivery_boy}
                                >
                                    {deliveryBoys.map((item) => {
                                        return (
                                            <Option
                                                value={item.id}
                                                key={item.id}
                                            >
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
                                            <Option
                                                value={item.id}
                                                key={item.id}
                                            >
                                                {item.name}
                                            </Option>
                                        );
                                    })}
                                </Select>
                            </div>
                            <div className="col-md-2 col-sm-12 mb-2">
                                <DatePicker
                                    onChange={this.onChangeFrom}
                                    placeholder={t("from")}
                                    value={date_from}
                                />
                            </div>
                            <div className="col-md-2 col-sm-12 mb-2">
                                <DatePicker
                                    onChange={this.onChangeTo}
                                    placeholder={t("to")}
                                    value={date_to}
                                />
                            </div>
                            <div className="col-md-2 offset-md-2 col-sm-12 d-flex flex-row justify-content-end">
                                <Button
                                    type="primary"
                                    onClick={() =>
                                        this.setFilter({
                                            status,
                                            order_date_from,
                                            order_date_to,
                                            id_delivery_boy,
                                            orderPagination,
                                            deliveryPagination,
                                        })
                                    }
                                >
                                    {t("filter")}
                                </Button>
                                <Button
                                    type="primary"
                                    danger
                                    style={{ marginLeft: 10 }}
                                    onClick={() =>
                                        this.clearFilter(
                                            orderPagination,
                                            deliveryPagination
                                        )
                                    }
                                >
                                    {t("clear_filter")}
                                </Button>
                            </div>
                        </div>
                        <PageHeader
                            className="site-page-header"
                            title={t("orders")}
                        >
                            <Content
                                className="site-layout-background"
                                style={{ overflow: "auto" }}
                            >
                                <Table
                                    columns={this.orderColumns}
                                    rowKey={(record) => record.id}
                                    dataSource={orderData}
                                    pagination={orderPagination}
                                    loading={loading}
                                    onChange={this.handleTableChange}
                                />
                            </Content>
                        </PageHeader>
                    </Card>
                    <Breadcrumb style={{ margin: "16px 0" }}>
                        <Breadcrumb.Item>
                            {t("delivery_boy_statuses")}
                        </Breadcrumb.Item>
                    </Breadcrumb>
                    <PageHeader
                        className="site-page-header"
                        title={t("delivery_boy_statuses")}
                    >
                        <Content
                            className="site-layout-background"
                            style={{ overflow: "auto" }}
                        >
                            <Table
                                columns={this.deliveryBoyColumns}
                                rowKey={(record) => record.id}
                                dataSource={deliveryBoyData}
                                pagination={deliveryPagination}
                                loading={loading}
                                onChange={this.handleDeliveryBoyTableChange}
                            />
                        </Content>
                    </PageHeader>
                </PageLayout>
            </>
        );
    }
}
export default withTranslation()(DeliveryOrdersStatus);
