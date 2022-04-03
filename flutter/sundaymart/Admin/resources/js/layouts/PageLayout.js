import React from "react";
import HeaderMenu from "../layouts/HeaderMenu";
import Sidebar from "../layouts/Sidebar";
import { Layout } from "antd";
import ChatButton from "./ChatButton";
import {APP_NAME} from "../global";

const { Content, Footer } = Layout;

const PageLayout = ({ children }) => {
    return (
        <Layout style={{ minHeight: "100vh" }}>
            <Sidebar />
            <Layout className="site-layout">
                <HeaderMenu />
                <Content style={{ margin: "0 16px" }}>{children}</Content>
                <ChatButton />
                <Footer style={{ textAlign: "center" }}>{APP_NAME} 2021</Footer>
            </Layout>
        </Layout>
    );
};

export default PageLayout;
