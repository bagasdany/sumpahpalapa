import React, {useEffect, useState} from 'react';
import {useTranslation, withTranslation} from "react-i18next";
import PageLayout from "../../layouts/PageLayout";
import {Breadcrumb, Button, Card, Form, message, PageHeader, Table, Upload} from "antd";
import {Content} from "antd/es/layout/layout";
import {UploadOutlined} from "@ant-design/icons";

const ServerUpdate = (props) => {
    const {t} = useTranslation();
    const [fileList, setFileList] = useState([]);

    const onFinish = async (values) => {

    }

    const onFinishFailed = () => {
    }

    const normFile = (e) => {
        if (Array.isArray(e)) {
            return e;
        }

        return e && e.fileList;
    };

    return (<PageLayout>
        <Breadcrumb style={{margin: "16px 0"}}>
            <Breadcrumb.Item>{t("server_update")}</Breadcrumb.Item>
        </Breadcrumb>
        <Card bordered={false}>
            <Content
                className="site-layout-background"
                style={{overflow: "auto"}}
            >
                <h6 className="text-danger">
                    1. Unzip downloaded folder<br/>
                    2. Open unzipped folder and zip Admin folder<br/>
                    3. Upload Admin.zip folder<br/>
                    4. Press Update button<br/><br/>
                </h6>
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
                                    <Upload method="POST" action="/project-upload">
                                        <Button icon={<UploadOutlined/>}>Click to upload</Button>
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
                                    {t("update")}
                                </Button>
                            </div>
                        </div>
                    </div>
                </Form>
            </Content>
        </Card>
    </PageLayout>);
}

export default withTranslation()(ServerUpdate);
