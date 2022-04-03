import React from "react";
import PageLayout from "../../layouts/PageLayout";
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
} from "antd";
import { Link } from "react-router-dom";

const { Content } = Layout;
import reqwest from "reqwest";
import brandDelete from "../../requests/Brands/BrandDelete";
import { isAllowed } from "../../helpers/IsAllowed";
import { withTranslation } from "react-i18next";

class Terms extends React.Component {
    columns = [
        {
            title: "Shop name",
            dataIndex: "shop",
        },
        {
            title: "About context",
            dataIndex: "context",
        },
        {
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                return (
                    <div>
                        {options.edit && isAllowed("/terms/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/terms/edit",
                                        state: { id: row.id_shop, edit: true },
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

    handleOk = async (id) => {
        this.setState({
            confirmLoading: true,
        });

        let data = await brandDelete(id);

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
            url: "/api/auth/terms/datatable",
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

    render() {
        const { data, pagination, loading } = this.state;
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>{t("terms")}</Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    className="site-page-header"
                    title={t("terms")}
                    subTitle={t("edit_terms")}
                >
                    <Content
                        className="site-layout-background"
                        style={{ overflow: "auto" }}
                    >
                        <Table
                            columns={this.columns}
                            rowKey={(record) => record.id_shop}
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

export default withTranslation()(Terms);
