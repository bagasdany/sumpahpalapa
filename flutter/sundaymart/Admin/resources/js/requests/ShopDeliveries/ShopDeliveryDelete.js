import axios from "axios";

const shopDeliverySave = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/shop/deliveries/delete?id=${id}`;

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "post",
        url: url,
        headers: headers,
    });

    return response;
};

export default shopDeliverySave;
