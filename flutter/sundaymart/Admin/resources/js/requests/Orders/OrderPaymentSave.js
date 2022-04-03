import axios from "axios";

const orderPaymentSave = async (id, shop_id, payment_id) => {
    const url = "/api/m/payment-system/payment";
    const body = {
        id: id,
        shop_id: shop_id,
        type: 'order',
        payment_id: payment_id
    };

    const headers = {}

    const response = await axios({
        method: 'post',
        url: url,
        data: body,
        headers: headers
    });

    return response;
}

export default orderPaymentSave;
