import React, {useContext, useState} from "react";
import {Layout, Form, Input, Checkbox, Button, Card, message} from "antd";
import LoginRequest from "../requests/LoginRequest";
import {AuthContext} from "../helpers/AuthProvider";
import {Redirect, Link} from "react-router-dom";
import {useTranslation} from "react-i18next";
import {DEV_MODE, APP_NAME} from "../global";

const Login = (props) => {
    const {t} = useTranslation();
    const {signin, isAuthenticated} = useContext(AuthContext);
    const [error, setError] = useState("");
    const [url, setUrl] = useState("/");
    var [redirect, setRedirect] = useState(false);

    const onFinish = async (values) => {
        const data = await LoginRequest(values.email, values.password);
        if (data.data.success == 1 && data.data.permissions.length > 0) {
            signin(true, data.data.token);
            await localStorage.setItem("user", JSON.stringify(data.data.data));
            await localStorage.setItem(
                "permission",
                JSON.stringify(data.data.permissions)
            );

            setUrl(data.data.permissions[0].url);

            setRedirect(true);
        } else if(!data.data.success && data.data.license == false) {
            setUrl("/licence");
            setRedirect(true);
        } else {
            if (
                data.data != null &&
                data.data.permissions != null &&
                data.data.permissions.length == 0
            ) {
                message.warn("Please, enable admin permissions first");
            } else {
                setError(data.data.msg);
                //remove error after 5 seconds
                setTimeout(() => {
                    setError("");
                }, 5000);
            }
        }
    };

    const onFinishFailed = (errorInfo) => {
        console.log("Failed:", errorInfo);
    };

    if (redirect) return <Redirect to={url}/>;

    return (
        <Layout
            className="site-layout-background login justify-content-center"
            style={{minHeight: "100vh"}}
        >
            <div className="container">
                <div className="row justify-content-center">
                    <div className="col-xl-5 col-lg-6 col-md-5">
                        <Card className="shadow-lg my-5 border-0 overflow-hidden">
                            <Form
                                name="basic"
                                initialValues={{
                                    remember: true,
                                }}
                                onFinish={onFinish}
                                onFinishFailed={onFinishFailed}
                            >
                                <h1 className="h4 text-gray-900 mb-4 text-center">
                                    {t("welcome_to")}{" "}
                                    <b className="text-success">{APP_NAME}</b>
                                </h1>
                                <Form.Item
                                    name="email"
                                    rules={[
                                        {
                                            required: true,
                                            message: t(
                                                "please_input_your_email"
                                            ),
                                        },
                                    ]}
                                >
                                    <Input placeholder={t("email")}/>
                                </Form.Item>

                                <Form.Item
                                    name="password"
                                    rules={[
                                        {
                                            required: true,
                                            message: t(
                                                "please_input_your_password"
                                            ),
                                        },
                                    ]}
                                >
                                    <Input.Password
                                        placeholder={t("password")}
                                    />
                                </Form.Item>

                                <Form.Item
                                    name="remember"
                                    valuePropName="checked"
                                >
                                    <Checkbox>{t("remember_me")}</Checkbox>
                                </Form.Item>

                                <Form.Item>
                                    <Button type="primary" htmlType="submit">
                                        {t("submit")}
                                    </Button>
                                </Form.Item>

                                <Form.Item style={{textAlign: "center"}}>
                                    {t("dou_you_have_shop")} ?{" "}
                                    <Link to="sign-up">{t("join_us")}</Link>
                                </Form.Item>

                                {error.length > 0 && (
                                    <div className="text-center">
                                        <span className="text-danger">
                                            {error}
                                        </span>
                                    </div>
                                )}
                                {
                                    !DEV_MODE && (
                                        <div className="text-center">
                                            <h5>Super admin</h5>
                                            <h6>
                                                Login: <code>admin@gmail.com</code>
                                            </h6>
                                            <h6>
                                                Password: <code>admin1234</code>
                                            </h6>
                                            <h5>Managers</h5>
                                            <h6>
                                                Login: <code>grocery@githubit.com</code>
                                            </h6>
                                            <h6>
                                                Password: <code>admin1234</code>
                                            </h6>

                                            <h6>
                                                Login: <code>sport@githubit.com</code>
                                            </h6>
                                            <h6>
                                                Password: <code>admin1234</code>
                                            </h6>

                                            <h6>
                                                Login: <code>auto@githubit.com</code>
                                            </h6>
                                            <h6>
                                                Password: <code>admin1234</code>
                                            </h6>

                                            <h6>
                                                Login: <code>baby@githubit.com</code>
                                            </h6>
                                            <h6>
                                                Password: <code>admin1234</code>
                                            </h6>
                                        </div>
                                    )
                                }
                            </Form>
                        </Card>
                    </div>
                </div>
            </div>
        </Layout>
    );
};

export default Login;
