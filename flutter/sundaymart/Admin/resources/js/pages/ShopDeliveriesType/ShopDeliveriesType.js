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
import shopDeliveryTypeDelete from "../../requests/ShopDeliveryType/ShopDeliveryTypeDelete";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";
class ShopDeliveriesType extends React.Component {
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
            dataIndex: "status",
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
                        {options.edit &&
                            isAllowed("/shops-delivery-type/edit") && (
                                <Button type="link">
                                    <Link
                                        to={{
                                            pathname:
                                                "/shops-delivery-type/edit",
                                            state: { id: row.id, edit: true },
                                        }}
                                        className="nav-text"
                                    >
                                        Edit
                                    </Link>
                                </Button>
                            )}
                        {options.delete &&
                            isAllowed("/shops-delivery-type/delete") &&
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
        options: {},
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
            confirmLoading: true,
        });
        let data = await shopDeliveryTypeDelete(id);

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
            pagination,
            ...filters,
        });

        this.setState({ pagination });
    };

    fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({ loading: true });
        reqwest({
            url: "/api/auth/deliveries/datatable",
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
            const newData = data.data.map((item) => ({
                ...item,
                name: item.languages[0]?.name,
                description: item.languages[0]?.description,
            }));
            this.setState({
                loading: false,
                data: newData,
                pagination: {
                    current: params.pagination.current,
                    pageSize: 10,
                    total: data.total,
                },
            });
        });
    };

    render() {
        const { t } = this.props;
        const { data, pagination, loading } = this.state;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        {t("shop_delivery_type_list")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    className="site-page-header"
                    title={t("shop_delivery_type_list")}
                    subTitle={t("create_remove_and_edit_shop_delivery_type")}
                    extra={
                        isAllowed("/shops-delivery-type/add") && [
                            <Link
                                to="/shops-delivery-type/add"
                                key="add"
                                className="btn btn-success"
                            >
                                {t("add_shop_delivery_type")}
                            </Link>,
                        ]
                    }
                >
                    <Content className="site-layout-background">
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

export default withTranslation()(ShopDeliveriesType);
