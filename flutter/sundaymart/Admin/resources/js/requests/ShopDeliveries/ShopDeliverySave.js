import axios from "axios";

const shopDeliverySave = async (id, data) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/shop/deliveries/save${id ? "?id=" + id : ""}`;

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "post",
        url: url,
        data: data,
        headers: headers,
    });

    return response;
};

export default shopDeliverySave;
