import React, {useState} from 'react';
import {Card, Form, Layout, Input, message} from "antd";
import {APP_NAME} from "../global";
import {useTranslation} from "react-i18next";
import licenceGet from "../requests/Licence/LicenceGet";
import licenceSend from "../requests/Licence/LicenceSend";
import {Redirect} from "react-router-dom";

const { Search } = Input;

const Licence = (props) => {
    const {t} = useTranslation();
    const [publicKey, setPublicKey] = useState("");
    var [redirect, setRedirect] = useState(false);

    const onPressEnter = async (values) => {
        let data = await licenceSend(publicKey);
        if(data['data']['success'] == true) {
            setRedirect(true);
        }
    }

    const sendRequest = async (e) => {
        e.preventDefault();
        let data = await licenceGet();
        if(data['data']['status'] == true) {
            message.success("Licence key was generated successfully. Please, Contact with Support center to get licence key.");
        } else {
            message.error("Licence key was not generated. Please, Contact with Support center.");
        }

    }

    const onChange = (e) => {
        setPublicKey(e.target.value);
    }

    if (redirect) return <Redirect to="/"/>;

    return (
        <Layout
            className="site-layout-background login justify-content-center"
            style={{minHeight: "100vh"}}
        >
            <div className="container">
                <div className="row justify-content-center">
                    <div className="col-xl-5 col-lg-6 col-md-5">
                        <Card className="my-5 border-0 overflow-hidden">
                                <h1 className="h4 text-gray-900 mb-4 text-center">
                                    {t("welcome_to")}{" "}
                                    <b className="text-success">{APP_NAME}</b>
                                </h1>
                                <h4 className="h5 text-center">{t("please_send_licence_request")} <a href="#" onClick={sendRequest}>{t("send_request")}</a></h4>
                                <h4 className="h5 text-center mb-1">{t("and_contact_with_support_center_and_get_licence_and_enter")}</h4>
                                <Search
                                    placeholder="Enter licence key"
                                    enterButton="Submit"
                                    size="large"
                                    onChange={onChange}
                                    onSearch={onPressEnter}
                                />
                        </Card>
                    </div>
                </div>
            </div>
        </Layout>
    );
}

export default Licence;
