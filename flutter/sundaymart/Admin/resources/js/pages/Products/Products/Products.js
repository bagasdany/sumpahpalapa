import React from "react";
import PageLayout from "../../../layouts/PageLayout";
import {
    Breadcrumb,
    Button,
    Layout,
    Table,
    PageHeader,
    Image,
    Tag,
    Popconfirm,
    message,
    Card,
    Select,
    Input,
} from "antd";
import {Link} from "react-router-dom";
import "../../../../css/app.css";

const {Content} = Layout;
const {Option} = Select;
import reqwest from "reqwest";
import {
    CheckCircleOutlined,
    CloseCircleOutlined,
    CloseOutlined,
    SearchOutlined,
} from "@ant-design/icons";

import productDelete from "../../../requests/Products/ProductDelete";
import {isAllowed} from "../../../helpers/IsAllowed";
import {withTranslation} from "react-i18next";
import {IS_DEMO, IMAGE_PATH} from "../../../global";

class Products extends React.Component {
    columns = [
        {
            title: "Name",
            dataIndex: "name",
            render: (name) => {
                return name.substring(0, 50) + (name.length > 50 ? "..." : "")
            }
        },
        {
            title: "Shop",
            dataIndex: "shop",
        },
        {
            title: "Image",
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
            title: "Category",
            dataIndex: "category",
        },
        {
            title: "Brand",
            dataIndex: "brand",
        },
        {
            title: "Quantity",
            dataIndex: "amount",
        },
        {
            title: "Price with commission",
            dataIndex: "price",
        },
        {
            title: "Price",
            dataIndex: "origin_price",
        },
        {
            title: "Show type",
            dataIndex: "show_type",
            render: (show_type) => {
                if (show_type == 1)
                    return <Tag color="processing">Default</Tag>;
                else if (show_type == 2) return <Tag color="success">New</Tag>;
                else return <Tag color="warning">Recommended</Tag>;
            },
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
                return (
                    <div>
                        {options.edit && isAllowed("/products/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/products/edit",
                                        state: {id: row.id, edit: true},
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                        isAllowed("/products/delete") &&
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
        show: true,
        search: undefined,
        id_shop: undefined,
        id_category: undefined,
        id_brand: undefined,
        shops: [],
        time: null,
        categories: [],
        brands: [],
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
        const {pagination} = this.state;
        this.fetch({pagination});
        this.fetchShops();
    }

    handleOk = async (id) => {
        if (IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            confirmLoading: true,
        });

        let data = await productDelete(id);

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

    fetchCategories = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/category/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                shop_id: id,
            },
        }).then((data) => {
            this.setState({
                categories: data.data,
            });
        });
    };

    fetchBrands = (id) => {
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/auth/brand/active",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                shop_id: id,
            },
        }).then((data) => {
            this.setState({
                brands: data.data,
            });
        });
    };

    fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({loading: true});
        reqwest({
            url:
                "/api/auth/product/datatable" +
                `?${params.search ? `&search=${params.search}` : ""}${
                    params.id_shop ? `&shop_id=${params.id_shop}` : ""
                }${
                    params.id_category
                        ? `&category_id=${params.id_category}`
                        : ""
                }${params.id_brand ? `&brand_id=${params.id_brand}` : ""}`,
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
        this.setState({selectedRowKeys});
    };

    deleteSelected = async () => {
        if (IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        await productDelete(this.state.selectedRowKeys);

        this.setState({selectedRowKeys: []});

        const {pagination} = this.state;
        this.fetch({pagination});
    };
    onChangeShop = (e) => {
        this.setState({
            id_shop: e,
        });
        this.fetchCategories(e);
        this.fetchBrands(e);
    };
    onChangeCategory = (e) => {
        this.setState({
            id_category: e,
        });
    };
    onChangeBrand = (e) => {
        this.setState({
            id_brand: e,
        });
    };
    setFilter = (filter) => {
        this.fetch(filter);
    };
    clearFilter = (pagination) => {
        this.setState({
            id_shop: undefined,
            id_category: undefined,
            id_brand: undefined,
        });
        this.fetch({pagination});
    };
    changeFilter = () => {
        if (this.state.search) {
            this.fetch({pagination: this.state.pagination});
        }
        this.setState({
            show: !this.state.show,
            search: undefined,
        });
    };
    handleSearch = (event) => {
        var text = event.target.value;
        const pagination = this.state.pagination;
        if (this.state.time) clearTimeout(this.state.time);
        this.state.time = setTimeout(() => {
            //search function
            this.setState({
                search: text,
            });
            this.fetch({pagination, search: this.state.search});
        }, 500);
    };

    render() {
        const {
            data,
            pagination,
            loading,
            selectedRowKeys,
            shops,
            brands,
            categories,
            id_brand,
            id_category,
            id_shop,
        } = this.state;

        const rowSelection = {
            selectedRowKeys,
            onChange: this.onSelectChange,
        };

        const hasSelected = selectedRowKeys.length > 0;
        const {t} = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{margin: "16px 0"}}>
                    <Breadcrumb.Item>{t("products")}</Breadcrumb.Item>
                </Breadcrumb>
                <Card bordered={false}>
                    <div className="d-flex flex-row">
                        <div
                            style={{
                                width: "95%",
                            }}
                        >
                            {this.state.show ? (
                                <div className="row">
                                    <div className="col-md col-sm-12 mb-2">
                                        <Select
                                            placeholder={t("select_shop")}
                                            style={{width: "100%"}}
                                            onChange={this.onChangeShop}
                                            value={id_shop}
                                        >
                                            {shops.map((item) => {
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

                                    <div className="col-md col-sm-12 mb-2">
                                        <Select
                                            placeholder={t("select_category")}
                                            style={{width: "100%"}}
                                            onChange={this.onChangeCategory}
                                            value={id_category}
                                        >
                                            {categories.map((item) => {
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

                                    <div className="col-md col-sm-12 mb-2">
                                        <Select
                                            placeholder={t("select_brand")}
                                            style={{width: "100%"}}
                                            onChange={this.onChangeBrand}
                                            value={id_brand}
                                        >
                                            {brands.map((item) => {
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

                                    <div className="col-md col-sm-12 d-flex flex-row justify-content-end">
                                        <Button
                                            type="primary"
                                            style={{
                                                padding: "0 10px",
                                            }}
                                            onClick={() =>
                                                this.setFilter({
                                                    pagination,
                                                    id_brand,
                                                    id_category,
                                                    id_shop,
                                                })
                                            }
                                        >
                                            {t("filter")}
                                        </Button>
                                        <Button
                                            type="primary"
                                            danger
                                            style={{
                                                marginLeft: 10,
                                            }}
                                            onClick={() =>
                                                this.clearFilter(pagination)
                                            }
                                        >
                                            {t("clear_filter")}
                                        </Button>
                                    </div>
                                </div>
                            ) : (
                                <Input
                                    className="p-1"
                                    style={{
                                        width: "100%",
                                        paddingLeft: "10px",
                                    }}
                                    onChange={this.handleSearch}
                                    size="large"
                                    placeholder={t("search_product_name")}
                                    prefix={
                                        <SearchOutlined
                                            style={{
                                                marginRight: 10,
                                            }}
                                        />
                                    }
                                />
                            )}
                        </div>
                        <div style={{marginLeft: 10}}>
                            {!this.state.show ? (
                                <Button
                                    className="d-flex flex-row justify-content-center align-items-center"
                                    type="primary"
                                    onClick={this.changeFilter}
                                    danger
                                    icon={
                                        <CloseOutlined
                                            style={{
                                                position: "absolute",
                                                top: 8,
                                                left: 3,
                                            }}
                                        />
                                    }
                                >
                                    {t("close")}
                                </Button>
                            ) : (
                                <Button
                                    type="primary"
                                    className="btn btn-success d-flex flex-row justify-content-center align-items-center"
                                    onClick={this.changeFilter}
                                    icon={
                                        <SearchOutlined
                                            style={{
                                                position: "absolute",
                                                top: 8,
                                                left: 3,
                                            }}
                                        />
                                    }
                                >
                                    {t("search")}
                                </Button>
                            )}
                        </div>
                    </div>
                </Card>
                <PageHeader
                    className="site-page-header"
                    title={t("products")}
                    subTitle={t("create_remove_and_edit_products")}
                    extra={[
                        isAllowed("/products/add") && (
                            <Link
                                to="/products/add"
                                key="add"
                                className="btn btn-success"
                            >
                                {t("add_product")}
                            </Link>
                        ),
                        hasSelected && (
                            <Button
                                onClick={this.deleteSelected}
                                key="delete"
                                className="btn btn-danger"
                            >
                                {t("delete_products")}
                            </Button>
                        ),
                    ]}
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
                            rowSelection={rowSelection}
                            rowClassName={(record, index) => ((record.amount < 10 && record.amount > 5) ? "table-row-warning" : (record.amount <= 5 ? "table-row-danger" : ""))}
                        />
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(Products);
