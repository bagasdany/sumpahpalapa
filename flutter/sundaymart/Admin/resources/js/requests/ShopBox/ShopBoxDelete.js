import axios from "axios";

const shopBoxDelete = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/shop/shipping-box/delete/${id}`;
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

export default shopBoxDelete;
