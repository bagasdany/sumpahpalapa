import React, {useState} from 'react';
import {useTranslation, withTranslation} from "react-i18next";
import PageLayout from "../../../layouts/PageLayout";
import {Breadcrumb, Button, DatePicker, Form, InputNumber, PageHeader, Select} from "antd";
import {Content} from "antd/es/layout/layout";
import * as moment from "moment";
import productExport from "../../../requests/Products/ProductExport";
import {EXCEL_EXPORT_PATH} from "../../../global";
import {saveAs} from "file-saver";

const {Option} = Select;

const ProductExport = (props) => {
    var currentDate = new Date();
    var yesterdayDate = currentDate.setDate(currentDate.getDate() - 1);

    const {t} = useTranslation();
    const [type, setType] = useState(1);
    const [start, setStart] = useState(moment(currentDate).format("YYYY-MM-DD"));
    const [end, setEnd] = useState(moment(yesterdayDate).format("YYYY-MM-DD"));

    const onChangeStartDate = (value, dateString) => {
        setStart(moment(dateString).format("YYYY-MM-DD"));
    }
    const onChangeEndDate = (value, dateString) => {
        setEnd(moment(dateString).format("YYYY-MM-DD"));
    }

    const onFinish = async (values) => {
        let data = await productExport(type, type == 2 ? start : values.start, type == 2 ? end : values.end);
        if (data != null && data.data.success) {
            saveAs(
                EXCEL_EXPORT_PATH,
                "products.xlsx"
            );
        }
    }

    const onFinishFailed = () => {
    }

    const onChangeType = (e) => {
        setType(e);
    }

    return (
        <PageLayout>
            <Breadcrumb style={{margin: "16px 0"}}>
                <Breadcrumb.Item>{t("product_export")}</Breadcrumb.Item>
            </Breadcrumb>
            <PageHeader
                className="site-page-header"
                title={t("product_export")}
                subTitle={t("product_export_info")}
            >
                <Content
                    className="site-layout-background"
                    style={{overflow: "auto"}}
                >
                    <Form
                        name="basic"
                        initialValues={{
                            type: type,
                        }}
                        layout="vertical"
                        onFinish={onFinish}
                        onFinishFailed={onFinishFailed}
                    >
                        <div className="col-md-12 col-sm-12">
                            <div className="row">
                                <div className="col-md-3 col-sm-6">
                                    <Form.Item
                                        label={t("select_type")}
                                        name="type"
                                        rules={[
                                            {
                                                required: true,
                                                message:
                                                    t(
                                                        "missing_type"
                                                    ),
                                            },
                                        ]}
                                        tooltip={t(
                                            "select_type"
                                        )}
                                    >
                                        <Select
                                            placeholder={t(
                                                "select_type"
                                            )}
                                            onChange={onChangeType}
                                            value={type}
                                        >
                                            <Option
                                                value={1}
                                                key={1}
                                            >
                                                {
                                                    t("select_by_id")
                                                }
                                            </Option>
                                            <Option
                                                value={2}
                                                key={2}
                                            >
                                                {
                                                    t("select_by_date")
                                                }
                                            </Option>
                                        </Select>
                                    </Form.Item>
                                </div>
                                <div className="col-md-3 col-sm-6">
                                    {
                                        type == 2 ? (
                                            <Form.Item
                                                name="start"
                                                label={t(
                                                    "start_date"
                                                )}
                                                tooltip={t(
                                                    "enter_start_date"
                                                )}
                                                rules={[
                                                    {
                                                        required: true,
                                                        message:
                                                            t(
                                                                "missing_start_date"
                                                            ),
                                                    },
                                                ]}
                                            >
                                                <DatePicker
                                                    key={"start"}
                                                    value={start}
                                                    onChange={
                                                        onChangeStartDate
                                                    }
                                                />
                                            </Form.Item>
                                        ) : (<Form.Item
                                            label={t("start_id")}
                                            name="start"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t(
                                                            "missing_start_id"
                                                        ),
                                                },
                                            ]}
                                            tooltip={t(
                                                "enter_start_id"
                                            )}
                                        >
                                            <InputNumber
                                                value={1}
                                                placeholder={t(
                                                    "start_id"
                                                )}
                                            />
                                        </Form.Item>)
                                    }
                                </div>
                                <div className="col-md-3 col-sm-6">
                                    {
                                        type == 2 ? (<Form.Item
                                            name="end"
                                            label={t(
                                                "end_date"
                                            )}
                                            tooltip={t(
                                                "enter_end_date"
                                            )}
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t(
                                                            "missing_end_date"
                                                        ),
                                                },
                                            ]}
                                        >
                                            <DatePicker
                                                value={end}
                                                key={"end"}
                                                onChange={
                                                    onChangeEndDate
                                                }
                                            />
                                        </Form.Item>) : (
                                            <Form.Item
                                                label={t("end_id")}
                                                name="end"
                                                rules={[
                                                    {
                                                        required: true,
                                                        message:
                                                            t(
                                                                "missing_end_id"
                                                            ),
                                                    },
                                                ]}
                                                tooltip={t(
                                                    "enter_end_id"
                                                )}
                                            >
                                                <InputNumber
                                                    value={100}
                                                    placeholder={t(
                                                        "end_id"
                                                    )}
                                                />
                                            </Form.Item>
                                        )
                                    }
                                </div>
                                <div className="col-md-3 col-sm-6">
                                    <Button
                                        type="primary"
                                        className="btn-success"
                                        style={{
                                            marginTop:
                                                "30px",
                                        }}
                                        htmlType="submit"
                                    >
                                        {t("export")}
                                    </Button>
                                </div>
                            </div>
                        </div>
                    </Form>
                </Content>
            </PageHeader>
        </PageLayout>
    );
}

export default withTranslation()(ProductExport);
