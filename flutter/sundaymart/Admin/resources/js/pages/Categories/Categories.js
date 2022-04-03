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
import { Link } from "react-router-dom";

const { Content } = Layout;
const { Option } = Select;
import reqwest from "reqwest";
import { CheckCircleOutlined, CloseCircleOutlined } from "@ant-design/icons";
import categoryDelete from "../../requests/Categories/CategoryDelete";
import { isAllowed } from "../../helpers/IsAllowed";
import { withTranslation } from "react-i18next";
import {IMAGE_PATH, IS_DEMO} from "../../global";

class Categories extends React.Component {
    columns = [
        {
            title: "Name",
            dataIndex: "name",
        },
        {
            title: "Shop name",
            dataIndex: "shop",
        },
        {
            title: "Parent category",
            dataIndex: "parent",
        },
        {
            title: "Logo",
            dataIndex: "image_url",
            render: (image_url) => {
                return (
                    <Image
                        width={50}
                        height={50}
                        src={IMAGE_PATH + image_url}
                        fallback="data:image/png;base64,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"
                    />
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
                        {options.edit && isAllowed("/categories/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/categories/edit",
                                        state: { id: row.id, edit: true },
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                            isAllowed("/categories/delete") &&
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
        shop_id: undefined,
        shops: [],
        pagination: {
            current: 1,
            pageSize: 10,
        },
        loading: false,
        visibleConfirm: false,
        confirmLoading: false,
        selectedRowKeys: [],
    };

    componentDidMount() {
        const { pagination } = this.state;
        this.fetch({ pagination });
        this.fetchShops();
    }

    handleOk = async (id) => {
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            confirmLoading: true,
        });

        let data = await categoryDelete(id);

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
                "/api/auth/category/datatable" +
                `?${params.shop_id ? `&shop_id=${params.shop_id}` : ""}`,
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
                    pageSize: params.pagination.pageSize,
                    total: data.total,
                },
            });
        });
    };

    onSelectChange = (selectedRowKeys) => {
        this.setState({ selectedRowKeys });
    };

    deleteSelected = async () => {
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        await categoryDelete(this.state.selectedRowKeys);

        this.setState({selectedRowKeys: []});

        const { pagination } = this.state;
        this.fetch({ pagination });
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
    setFilter = (filter) => {
        this.fetch(filter);
    };
    clearFilter = (pagination) => {
        this.setState({
            shop_id: undefined,
        });
        this.fetch({ pagination });
    };
    render() {
        const { data, pagination, loading, selectedRowKeys, shop_id, shops } =
            this.state;

        const rowSelection = {
            selectedRowKeys,
            onChange: this.onSelectChange,
        };

        const hasSelected = selectedRowKeys.length > 0;
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>{t("categories")}</Breadcrumb.Item>
                </Breadcrumb>
                <Card bordered={false}>
                    <div className="row d-flex flex-row justify-content-between align-items-center">
                        <div className="col-md-4 col-sm-12 mb-2">
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

                        <div className="col-md-4 col-sm-12 d-flex flex-row justify-content-end">
                            <Button
                                type="primary"
                                onClick={() =>
                                    this.setFilter({
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
                                style={{ marginLeft: "10px" }}
                                onClick={() => this.clearFilter(pagination)}
                            >
                                {t("clear_filter")}
                            </Button>
                        </div>
                    </div>
                    <PageHeader
                        className="site-page-header"
                        title={t("categories")}
                        subTitle={t("create_remove_and_edit_categories")}
                        extra={
                            isAllowed("/categories/add") && [
                                <Link
                                    to="/categories/add"
                                    key="add"
                                    className="btn btn-success"
                                >
                                    {t("add_category")}
                                </Link>,
                                hasSelected && (
                                    <Button
                                        onClick={this.deleteSelected}
                                        key="delete"
                                        className="btn btn-danger"
                                    >
                                        {t("delete_products")}
                                    </Button>
                                ),
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
                                rowSelection={rowSelection}
                            />
                        </Content>
                    </PageHeader>
                </Card>
            </PageLayout>
        );
    }
}

export default withTranslation()(Categories);
