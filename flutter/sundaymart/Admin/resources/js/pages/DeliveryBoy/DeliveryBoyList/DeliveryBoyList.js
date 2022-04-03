import React, { useEffect, useState } from "react";
import PageLayout from "../../../layouts/PageLayout";
import { Breadcrumb, PageHeader, Layout, Table, Tag, Button } from "antd";
import getDeliveryBoyData from "../../../requests/DeliveryBoy/DeliveryBoyList";
import { Link } from "react-router-dom";
import { isAllowed } from "../../../helpers/IsAllowed";
import reqwest from "reqwest";
import { withTranslation } from "react-i18next";

const { Content } = Layout;

class DeliveryBoyList extends React.Component {
    columns = [
        {
            title: "ID",
            dataIndex: "id",
        },
        {
            title: "Name",
            dataIndex: "name",
        },
        {
            title: "Shop name",
            dataIndex: "shop_name",
        },
        {
            title: "Balance",
            dataIndex: "balance",
            render: (balance, row) => {
                return balance?.balance;
            },
        },
        {
            title: "Active",
            dataIndex: "active",
            render: (active, row) => {
                var status_colors = ["error", "success"];
                return (
                    <Tag color={status_colors[active]}>
                        {active ? "Active" : "Inactive"}
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
    state = {
        data: [],
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
            url: "/api/auth/admin/delivery-boys",
            method: "get",
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
                data: data.data.map((item) => ({
                    ...item,
                    options: {
                        edit: 1,
                    },
                })),
                pagination: {
                    current: params.pagination.current,
                    pageSize: 10,
                    total: data.total,
                },
            });
        });
    };
    render() {
        const { data, pagination, loading } = this.state;
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>{t("delivery_boy_list")}</Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    className="site-page-header"
                    title={t("delivery_boy_list")}
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
            </PageLayout>
        );
    }
}
export default withTranslation()(DeliveryBoyList);
