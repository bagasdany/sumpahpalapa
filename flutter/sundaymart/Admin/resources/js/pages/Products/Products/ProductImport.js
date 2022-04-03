import React, {useState} from 'react';
import {useTranslation, withTranslation} from "react-i18next";
import PageLayout from "../../../layouts/PageLayout";
import {Breadcrumb, Button, Form, message, PageHeader, Table, Upload} from "antd";
import {Content} from "antd/es/layout/layout";
import {UploadOutlined} from "@ant-design/icons";
import {EXCEL_IMPORT_PATH, IMAGE_PATH} from "../../../global";

const ProductImport = (props) => {
    const {t} = useTranslation();
    const [fileList, setFileList] = useState([]);

    const importProps = {
        onRemove: file => {
            const index = fileList.indexOf(file);
            const newFileList = fileList.slice();
            newFileList.splice(index, 1);
            setFileList(newFileList);
        },
        beforeUpload: file => {
            setFileList([...fileList, file],);
            return false;
        },
        fileList,
    };

    const onFinish = async (values) => {
        const formData = new FormData();
        fileList.forEach(file => {
            formData.append('file', file);
        });

        fetch("/api/auth/product/import/", {
            method: 'POST',
            body: formData,
        })
            .then(res => res.json())
            .then(() => {
                setFileList([]);
                message.success('upload successfully.');
            })
            .catch(() => {
                message.error('upload failed.');
            })
            .finally(() => {

            });
    }

    const onFinishFailed = () => {
    }

    const normFile = (e) => {
        if (Array.isArray(e)) {
            return e;
        }

        return e && e.fileList;
    };

    const downloadFormat = () => {
        saveAs(
            EXCEL_IMPORT_PATH,
            "products.xlsx"
        );
    }

    return (
        <PageLayout>
            <Breadcrumb style={{margin: "16px 0"}}>
                <Breadcrumb.Item>{t("product_import")}</Breadcrumb.Item>
            </Breadcrumb>
            <PageHeader
                className="site-page-header"
                title={t("product_import")}
                subTitle={t("product_import_info")}
                extra={
                    [
                        <div
                            key="download"
                            onClick={downloadFormat}
                            className="btn btn-success"
                        >
                            {t("download_sample")}
                        </div>,
                    ]
                }
            >
                <Content
                    className="site-layout-background"
                    style={{overflow: "auto"}}
                >
                    <Form
                        name="basic"
                        initialValues={{}}
                        layout="vertical"
                        onFinish={onFinish}
                        onFinishFailed={onFinishFailed}
                    >
                        <div className="col-md-12 col-sm-12">
                            <div className="row">
                                <div className="col-md-3 col-sm-6">
                                    <Form.Item
                                        name="upload"
                                        label={t("upload")}
                                        valuePropName="fileList"
                                        getValueFromEvent={normFile}
                                    >
                                        <Upload {...importProps}>
                                            <Button icon={<UploadOutlined />}>Click to upload</Button>
                                        </Upload>
                                    </Form.Item>
                                </div>
                                <div className="col-md-3 col-sm-6">
                                    <Button
                                        type="primary"
                                        className="btn-success"
                                        disabled={fileList.length === 0}
                                        style={{
                                            marginTop:
                                                "30px",
                                        }}
                                        htmlType="submit"
                                    >
                                        {t("import")}
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

export default withTranslation()(ProductImport);
