import axios from "axios";

const taxSave = async (name, shop_id, description, price, active, isDefaultTax, id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/taxes/save";
    const body = {
        id: id,
        name: name,
        shop_id: shop_id,
        description: description,
        percent: price,
        default: isDefaultTax,
        active: active,
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

export default taxSave;
