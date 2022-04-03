import axios from "axios";

const orderSave = async (params, state, id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/order/save";

    const body = {
        id: id,
        total_amount: (state.total * 1 + state.shop_tax * 1).toFixed(2),
        delivery_time_id: params.delivery_time,
        delivery_date: state.delivery_date,
        id_user: params.client,
        id_delivery_address: params.address,
        id_shop: params.shop,
        id_shipping: params.shipping_id,
        id_shipping_transport: state.shipping_transport_id,
        id_shipping_box: state.shipping_box_id,
        product_details: state.product_details,
        order_status: params.order_status,
        type: params.delivery_type,
        payment_status: params.payment_status,
        comment: params.order_comment,
        //payment_method: params.payment_method,
        total_discount: state.total_discount,
        delivery_boy_comment: params.delivery_boy_comment,
        delivery_boy: params.delivery_boy,
        tax: (state.tax * 1 + state.shop_tax * 1).toFixed(2),
        delivery_fee: state.delivery_fee ?? 0,
        coupon: state.coupon_amount
    };
    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "post",
        url: url,
        data: body,
        headers: headers,
    });

    return response;
};

export default orderSave;
