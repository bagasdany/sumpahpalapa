import React, {useEffect, useState} from 'react';
import {useTranslation, withTranslation} from "react-i18next";
import PageLayout from "../../layouts/PageLayout";
import {Breadcrumb, Card, PageHeader, Table} from "antd";
import serverInfoGet from "../../requests/ServerInfo/ServerInfoGet";

const ServerInfo = (props) => {
    const {t} = useTranslation();
    const [data, setData] = useState({});

    useEffect(() => {
        getServerData();
    }, []);

    const getServerData = async () => {
        let data = await serverInfoGet();
        console.log(data.data.data);
        if (data.data.success)
            setData(data.data.data);
    }

    return (<PageLayout>
        <Breadcrumb style={{margin: "16px 0"}}>
            <Breadcrumb.Item>{t("server_info")}</Breadcrumb.Item>
        </Breadcrumb>
        <Card bordered={false}>
            <table className="table table-striped">
                <tbody>
                {
                    Object.keys(data).map((key) => {
                        return (
                            <tr key={key}>
                                <td>{key}</td>
                                <td>{data[key]}</td>
                            </tr>);
                    })
                }
                </tbody>
            </table>
        </Card>
    </PageLayout>);
}

export default withTranslation()(ServerInfo);
