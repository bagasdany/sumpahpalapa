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
    Card,
    Select,
} from "antd";
import {Link} from "react-router-dom";

const {Content} = Layout;
const {Option} = Select;
import reqwest from "reqwest";
import {CheckCircleOutlined, CloseCircleOutlined} from "@ant-design/icons";
import shippingBoxDelete from "../../requests/ShippingBox/ShippingBoxDelete";
import {isAllowed} from "../../helpers/IsAllowed";
import {withTranslation} from "react-i18next";
import {IS_DEMO} from "../../global";

class ShippingBox extends React.Component {
    columns = [
        {
            title: "Name",
            dataIndex: "name",
        },
        {
            title: "Description",
            dataIndex: "description",
        },

        {
            title: "Active",
            dataIndex: "active",
            render: (active) => {
                if (active == 1)
                    return (
                        <Tag icon={<CheckCircleOutlined/>} color="success">
                            Active
                        </Tag>
                    );
                else
                    return (
                        <Tag icon={<CloseCircleOutlined/>} color="error">
                            Inactive
                        </Tag>
                    );
            },
        },
        {
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                const {t} = this.props;
                return (
                    <div>
                        {options.edit && isAllowed("/shipping-box/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/shipping-box/edit",
                                        state: {id: row.id, edit: true},
                                    }}
                                    className="nav-text"
                                >
                                    {t("edit")}
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                        row.default != 1 &&
                        isAllowed("/shipping-box/delete") && (
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
                                    {t("delete")}
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
        const {pagination} = this.state;
        this.fetch({pagination});
    }

    handleOk = async (id) => {
        if (IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            confirmLoading: true,
        });

        let data = await shippingBoxDelete(id);

        if (data.data.success == 1) {
            this.setState({
                confirmLoading: false,
                visibleConfirm: false,
            });
        }

        const {pagination} = this.state;
        this.fetch({pagination});
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

        this.setState({pagination});
    };

    fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({loading: true});
        reqwest({
            url: "/api/auth/shipping-box/datatable",
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
                    name: item.language != null ? item.language.name : "",
                    description: item.language != null ? item.language.description : "",
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
        const {data, pagination, loading} = this.state;
        const {t} = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{margin: "16px 0"}}>
                    <Breadcrumb.Item>{t("shipping_box")}</Breadcrumb.Item>
                </Breadcrumb>
                <Card bordered={false}>
                    <PageHeader
                        className="site-page-header"
                        title={t("shipping_box")}
                        subTitle={t("create_remove_and_edit_shipping_box")}
                        extra={
                            isAllowed("/shipping-box/add") && [
                                <Link
                                    to="/shipping-box/add"
                                    key="add"
                                    className="btn btn-success"
                                >
                                    {t("add_shipping_box")}
                                </Link>,
                            ]
                        }
                    >
                        <Content
                            className="site-layout-background"
                            style={{overflow: "auto"}}
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

export default withTranslation()(ShippingBox);
