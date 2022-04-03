import React from "react";
import { Button, Table, PageHeader, Tag, Popconfirm, message } from "antd";

import { CheckCircleOutlined, CloseCircleOutlined } from "@ant-design/icons";
import reqwest from "reqwest";
import shopTransportDelete from "../../requests/ShopTransport/ShopTransportDelete";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";

class ShopTransport extends React.Component {
    columns = [
        {
            title: "Shop name",
            dataIndex: "shop",
        },
        {
            title: "Delivery transport",
            dataIndex: "name",
        },
        {
            title: "Price",
            dataIndex: "price",
        },

        {
            title: "Default",
            dataIndex: "default",
            render: (value) => {
                if (value == 1)
                    return (
                        <Tag icon={<CheckCircleOutlined />} color="success">
                            Default
                        </Tag>
                    );
                else
                    return (
                        <Tag icon={<CloseCircleOutlined />} color="error">
                            No default
                        </Tag>
                    );
            },
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
                        {options.edit && (
                            <Button
                                type="link"
                                onClick={() => this.props.onEdit(row.id)}
                            >
                                Edit
                            </Button>
                        )}
                        {options.delete && row.default != 1 && (
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

    constructor(props) {
        super(props);

        this.state = {
            data: [],
            pagination: {
                current: 1,
                pageSize: 10,
            },
            loading: false,
            visibleConfirm: false,
            confirmLoading: false,
            shop_id: props.shop_id,
        };
    }

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

        let data = await shopTransportDelete(id);

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
            url: `/api/auth/shop/transports/active?shop_id=${this.state.shop_id}`,
            method: "get",
            type: "json",

            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            this.setState({
                loading: false,
                data: data.data.map((item) => ({
                    ...item,
                    name: item.delivery_transport?.name,
                    options: {
                        delete: 1,
                        edit: 1,
                    },
                })),
            });
        });
    };

    render() {
        const { data, pagination, loading } = this.state;
        const { t } = this.props;
        return (
            <PageHeader
                className="site-page-header"
                title={t("shop_transports")}
                extra={[
                    <Button
                        type="primary"
                        key="add"
                        onClick={() => this.props.onEdit(0)}
                        className="btn-success"
                    >
                        {t("add_shop_transport")}
                    </Button>,
                ]}
            >
                <Table
                    columns={this.columns}
                    rowKey={(record) => record.id}
                    dataSource={data}
                    pagination={pagination}
                    loading={loading}
                    onChange={this.handleTableChange}
                />
            </PageHeader>
        );
    }
}

export default withTranslation()(ShopTransport);
