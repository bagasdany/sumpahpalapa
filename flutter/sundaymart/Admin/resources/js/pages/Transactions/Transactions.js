import React, {useState, useEffect} from 'react';
import {useTranslation, withTranslation} from "react-i18next";
import PageLayout from "../../layouts/PageLayout";
import {Breadcrumb, Button, PageHeader, Popconfirm, Table, Tag} from "antd";
import {Content} from "antd/es/layout/layout";
import reqwest from "reqwest";

const Transactions = (props) => {
    const {t} = useTranslation();
    const columns = [
        {
            title: "ID",
            dataIndex: "id",
        },
        {
            title: "Shop",
            dataIndex: "shop",
        },
        {
            title: "Order ID",
            dataIndex: "order_id",
        },
        {
            title: "Note",
            dataIndex: "note",
        },
        {
            title: "Payment",
            dataIndex: "payment",
        },
        {
            title: "Currency",
            dataIndex: "currency",
        },
        {
            title: "Status",
            dataIndex: "status_description",
        },
        {
            title: "Created time",
            dataIndex: "perform_time",
        },
    ];

    const [pagination, setPagination] = useState({
        current: 1,
        pageSize: 10,
    });
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        fetch({pagination});
    }, []);

    const handleTableChange = (pagination, filters, sorter) => {
        fetch({
            sortField: sorter.field,
            sortOrder: sorter.order,
            pagination,
            ...filters,
        });

        setPagination(pagination);
    };

    const fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        setLoading(true);
        reqwest({
            url: "/api/auth/transactions/datatable",
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
            setLoading(false);
            setData(data.data);
            setPagination({
                current: params.pagination.current,
                pageSize: 10,
                total: data.total,
            });
        });
    };

    return (
        <PageLayout>
            <Breadcrumb style={{margin: "16px 0"}}>
                <Breadcrumb.Item>{t("transactions")}</Breadcrumb.Item>
            </Breadcrumb>
            <PageHeader
                className="site-page-header"
                title={t("transactions")}
                subTitle={t("transactions_info")}
            >
                <Content
                    className="site-layout-background"
                    style={{overflow: "auto"}}
                >
                    <Table
                        columns={columns}
                        rowKey={(record) => record.id}
                        dataSource={data}
                        pagination={pagination}
                        loading={loading}
                        onChange={handleTableChange}
                    />
                </Content>
            </PageHeader>
        </PageLayout>);
}

export default withTranslation()(Transactions);
