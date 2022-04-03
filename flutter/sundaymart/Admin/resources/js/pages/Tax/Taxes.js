import React from "react";
import PageLayout from "../../layouts/PageLayout";
import {
    Breadcrumb,
    Button,
    Layout,
    Table,
    PageHeader,
    Tag,
    Popconfirm,
    message,
    Card,
} from "antd";
import { Link } from "react-router-dom";

const { Content } = Layout;
import reqwest from "reqwest";
import { CheckCircleOutlined, CloseCircleOutlined } from "@ant-design/icons";
import { isAllowed } from "../../helpers/IsAllowed";
import { withTranslation } from "react-i18next";
import taxDelete from "../../requests/Taxes/TaxDelete";
import {IS_DEMO} from "../../global";

class Taxes extends React.Component {
    columns = [
        {
            title: "Name",
            dataIndex: "name",
        },

        {
            title: "Shop name",
            dataIndex: "shop_name",
        },
        {
            title: "Description",
            dataIndex: "description",
        },

        {
            title: "Type",
            dataIndex: "default",
            render: (defaulttax) => {
                if(defaulttax == 1) {
                     return <div className="text-info">Shop's default tax</div>;
                } else {
                    return <div className="text-danger">Can add to Category</div>;
                }
            }
        },

        {
            title: "Active",
            dataIndex: "active",
            render: (active) => {
                if (active == 1)
                    return (
                        <Tag icon={<CheckCircleOutlined />} color="success">
                            Active
                        </Tag>
                    );
                else
                    return (
                        <Tag icon={<CloseCircleOutlined />} color="error">
                            Inactive
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
                        {options.edit && isAllowed("/taxes/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/taxes/edit",
                                        state: { id: row.id, edit: true },
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                            // row.default != 1 &&
                            isAllowed("/taxes/delete") && (
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
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            loading: true,
            confirmLoading: true,
        });

        let data = await taxDelete(id);

        if (data.data.success == 1) {
            this.setState({
                loading: false,
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
        this.setState({ loading: false });
        reqwest({
            url: "/api/auth/taxes/datatable",
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
                    <Breadcrumb.Item>{t("taxes")}</Breadcrumb.Item>
                </Breadcrumb>
                <Card bordered={false}>
                    <PageHeader
                        className="site-page-header"
                        title={t("taxes")}
                        subTitle={t("create_remove_and_edit_taxes")}
                        extra={
                            isAllowed("/taxes/add") && [
                                <Link
                                    to="/taxes/add"
                                    key="add"
                                    className="btn btn-success"
                                >
                                    {t("add_tax")}
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

export default withTranslation()(Taxes);
