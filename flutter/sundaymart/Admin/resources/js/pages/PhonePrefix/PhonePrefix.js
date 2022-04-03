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
    message,
} from "antd";
import { Link } from "react-router-dom";

const { Content } = Layout;
import reqwest from "reqwest";
import { CheckCircleOutlined, CloseCircleOutlined } from "@ant-design/icons";
import { isAllowed } from "../../helpers/IsAllowed";
import phonePrefixDelete from "../../requests/PhonePrefix/PhonePrefixDelete";
import { withTranslation } from "react-i18next";

class PhonePrefix extends React.Component {
    columns = [
        {
            title: "Phone prefix",
            dataIndex: "phone_prefix",
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
                        {options.edit && isAllowed("/phone-prefix/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/phone-prefix/edit",
                                        state: { id: row.id, edit: true },
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                            isAllowed("/phone-prefix/delete") &&
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

        let data = await phonePrefixDelete(id);

        if (data.data.success == 1) {
            this.setState({
                confirmLoading: false,
                visibleConfirm: false
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
            url: "/api/auth/phone-prefix/datatable",
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
                    <Breadcrumb.Item>{t("phone_prefix")}</Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    className="site-page-header"
                    title={t("phone_prefix")}
                    subTitle={t("create_remove_and_edit_phone_prefix")}
                    extra={
                        isAllowed("/phone-prefix/add") && [
                            <Link
                                to="/phone-prefix/add"
                                key="add"
                                className="btn btn-success"
                            >
                                {t("add_phone_prefix")}
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
            </PageLayout>
        );
    }
}

export default withTranslation()(PhonePrefix);
