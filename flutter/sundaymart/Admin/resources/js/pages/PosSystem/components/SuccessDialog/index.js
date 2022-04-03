import React from 'react';
import {Modal, Button} from 'antd';
import {useTranslation} from "react-i18next";

export default ({isOrderSuccess, setIsOrderSuccess, datas, orderId, delivery}) => {
    const {t} = useTranslation();

    const handleOk = () => {
        var prtContent = document.getElementById("printable_body");
        var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    };

    const handleCancel = () => {
        setIsOrderSuccess(false);
    };

    return (<>
        <Modal
            visible={isOrderSuccess}
            title={t("order_saved_success") + " #" + orderId}
            onOk={handleOk}
            onCancel={handleCancel}
            footer={[
                <Button key="back" onClick={handleCancel}>
                    {t("close")}
                </Button>,
                <Button key="check" type="primary" onClick={handleOk}>
                    {t("print_check")}
                </Button>
            ]}
        >
            <div id="printable_body">
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span style={{width: '150px'}}>{t("order_id")}</span>
                    <span className="font-weight-light">{"#" + orderId}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span style={{width: '150px'}}>{t("delivery_type")}</span>
                    <span className="font-weight-light">{delivery.type == 1 ? t("delivery") : t("pickup")}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span style={{width: '150px'}}>{t("client_name")}</span>
                    <span
                        className="font-weight-light">{datas.user != null ? (datas.user.name + " " + datas.user.surname) : ""}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span style={{width: '150px'}}>{t("client_address")}</span>
                    <span className="font-weight-light">{datas.address != null ? datas.address.address : ""}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span style={{width: '150px'}}>{t("delivery_date")}</span>
                    <span
                        className="font-weight-light">{datas.deliveryDate != null ? (datas.deliveryDate.getFullYear() + "-" + (datas.deliveryDate.getMonth() + 1) + "-" + datas.deliveryDate.getDay()) : ""}</span>
                </div>
                <hr/>
                <h5 className="font-weight-bold">{t('products')}</h5>
                <hr/>
                {datas && typeof datas.products != 'undefined' && datas.products.map((item, idx) => (
                    <h6 className="font-weight-light">{item.name} <span
                        className="text-danger">{item.extras != null ? (" + ( " + item.extras.map((item) => item.extras_name).toString() + " )") : ""}</span>
                        <br/>
                        <span
                            className="font-weight-bold">{(item.price * 1 - item.discount * 1).toFixed(2)} </span>x<span
                            className="font-weight-bold"> {item.qty}</span>
                    </h6>
                ))}
                <hr/>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span>{t("sub_total")}</span>
                    <span>   {(
                        datas.total * 1 + datas.discount * 1 -
                        datas.tax * 1 -
                        datas.delivery_fee * 1
                    ).toFixed(2)}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span>{t("discount")}</span>
                    <span>{datas.discount}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span>{t("tax")}</span>
                    <span>{(datas.tax * 1 + datas.shop_tax * 1).toFixed(2)}</span>
                </div>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span>{t("delivery")}</span>
                    <span>{datas.delivery_fee}</span>
                </div>
                <hr/>
                <div
                    style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontWeight: "bold",
                    }}
                >
                    <span>{t("total_amount")}</span>
                    <span>{(datas.total * 1 + datas.shop_tax * 1 + datas.delivery_fee * 1).toFixed(2)}</span>
                </div>
            </div>
        </Modal>
    </>);
}
