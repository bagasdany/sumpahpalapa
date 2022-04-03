import axios from "axios";

const shopTransportSave = async ({
    shop_id,
    delivery_transport_id,
    active,
    defaultValue,
    price,
    id,
}) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/shop/transports/save";
    const body = {
        id: id,
        shop_id: shop_id,
        delivery_transport_id: delivery_transport_id,
        active: active,
        default: defaultValue,
        price: price,
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

export default shopTransportSave;
