import axios from "axios";

const shopBoxSave = async ({
    shop_id,
    shipping_box_id,
    start,
    end,
    price,
    active,
    id,
}) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/shop/shipping-box/save";
    const body = {
        id: id,
        shop_id: shop_id,
        shipping_box_id: shipping_box_id,
        start: start,
        end: end,
        active: active,
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

export default shopBoxSave;
