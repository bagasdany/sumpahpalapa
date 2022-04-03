import React from "react";
import PageLayout from "../../layouts/PageLayout";
import {
    Breadcrumb,
    Button,
    Layout,
    Table,
    Tag,
    PageHeader,
    Image,
    Checkbox,
    Popconfirm,
    message,
} from "antd";
import { Link } from "react-router-dom";

const { CheckableTag } = Tag;
const { Content } = Layout;
import reqwest from "reqwest";
import shopsCurrencyDelete from "../../requests/ShopCurrencies/ShopsCurrencyDelete";
import shopsCurrencyDefaultChange from "../../requests/ShopCurrencies/ShopsCurrencyDefaultChange";
import { isAllowed } from "../../helpers/IsAllowed";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";

class ShopCurrency extends React.Component {
    columns = [
        {
            title: "Shop",
            dataIndex: "shop_name",
        },
        {
            title: "Currency",
            dataIndex: "currency_name",
        },
        {
            title: "Value",
            dataIndex: "value",
        },
        {
            title: "Default",
            dataIndex: "default",
            render: (value, row) => {
                return (
                    <CheckableTag
                        key={row.id + "" + value}
                        checked={value == 1}
                        onChange={(checked) =>
                            this.handleChange(row.id_shop, row.id)
                        }
                    >
                        {value == 1 ? "Default" : "Not default"}
                    </CheckableTag>
                );
            },
        },
        {
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                return (
                    <div>
                        {options.edit && isAllowed("/shops-currencies/edit") && (
                            <Button type="link">
                                <Link
                                    to={{
                                        pathname: "/shops-currencies/edit",
                                        state: { id: row.id, edit: true },
                                    }}
                                    className="nav-text"
                                >
                                    Edit
                                </Link>
                            </Button>
                        )}
                        {options.delete &&
                            isAllowed("/shops-currencies/delete") &&
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

    handleChange = async (id_shop, id_shop_currency) => {
        var data = await shopsCurrencyDefaultChange(id_shop, id_shop_currency);

        if (data.data.success == 1) {
            const { pagination } = this.state;
            this.fetch({ pagination });
        }
    };

    handleOk = async (id) => {
        if(IS_DEMO) {
            message.warn("You cannot delete in demo mode");
            return;
        }

        this.setState({
            confirmLoading: true,
        });

        let data = await shopsCurrencyDelete(id);

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
            url: "/api/auth/shops-currency/datatable",
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
                    <Breadcrumb.Item>{t("shop_currencies")}</Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    className="site-page-header"
                    title={t("shop_currencies")}
                    subTitle={t("create_remove_and_edit_shop_currencies")}
                    extra={[
                        isAllowed("/shops-currencies/add") && (
                            <Link
                                to="/shops-currencies/add"
                                key="add"
                                className="btn btn-success"
                            >
                                {t("add_shop_currency")}
                            </Link>
                        ),
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
                        />
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(ShopCurrency);
