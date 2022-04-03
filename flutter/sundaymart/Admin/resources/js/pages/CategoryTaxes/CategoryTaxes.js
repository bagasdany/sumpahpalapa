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
import {IS_DEMO} from "../../global";

class Categories extends React.Component {
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
            title: "Percent",
            dataIndex: "percent",
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
                        {options.edit && isAllowed("/category-taxes/edit") && (
                            <Button
                                type="link"
                                onClick={() => this.props.onEdit(row.id)}
                            >
                                Edit
                            </Button>
                        )}
                        {options.delete &&
                            isAllowed("/category-taxes/delete") &&
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
        category_id: this.props.category_id,
        loading: false,
        visibleConfirm: false,
        confirmLoading: false,
        selectedRowKeys: [],
    };

    componentDidMount() {
        this.fetch(this.props.category_id);
    }

    handleOk = async (id) => {
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            confirmLoading: true,
        });

        // let data = await categoryDelete(id);
        //
        // if (data.data.success == 1) {
        //     this.setState({
        //         confirmLoading: false,
        //         visibleConfirm: false
        //     });
        // }

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

    fetch = (id) => {
        const token = localStorage.getItem("jwt_token");
        this.setState({ loading: true });
        reqwest({
            url: `/api/auth/category/get?id=${id}`,
            method: "post",
            headers: {
                Authorization: "Bearer " + token,
            },
        }).then((data) => {
            const newData = data.data.taxes.map((item) => ({
                ...item,
                options: {
                    edit: 1,
                    delete: 1,
                },
            }));
            this.setState({
                loading: false,
                data: newData,
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
            <PageHeader
                className="site-page-header"
                title={t("category_taxes")}
                extra={[
                    <Button
                        type="primary"
                        key="add"
                        onClick={() => this.props.onEdit(0)}
                        className="btn-success"
                    >
                        {t("add_category_taxes")}
                    </Button>,
                ]}
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
        );
    }
}

export default withTranslation()(Categories);
