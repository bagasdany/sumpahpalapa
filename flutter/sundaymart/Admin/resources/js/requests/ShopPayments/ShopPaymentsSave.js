import axios from "axios";

const shopPaymentsSave = async (id_shop, id_payment, active, key_id = "", secret_id = "") => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/shop-payment/save";
    const body = {
        id_shop: id_shop,
        id_payment: id_payment,
        active: active,
        key_id: key_id,
        secret_id: secret_id
    };

    const headers = {
        "Authorization": "Bearer " + token
    }

    const response = await axios({
        method: 'post',
        url: url,
        data: body,
        headers: headers
    });

    return response;
}

export default shopPaymentsSave;
