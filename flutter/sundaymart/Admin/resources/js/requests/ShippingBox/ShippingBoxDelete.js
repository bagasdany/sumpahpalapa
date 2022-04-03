import axios from "axios";

const shippingBoxDelete = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/shipping-box/delete/${id}`;
    const headers = {
        Authorization: "Bearer " + token,
    };
    const response = await axios({
        method: "delete",
        url: url,
        headers: headers,
    });
    return response;
};

export default shippingBoxDelete;
