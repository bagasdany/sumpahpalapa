import axios from "axios";

const shopDeliverySave = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/shop/deliveries/get/${id}`;

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "get",
        url: url,
        headers: headers,
    });

    return response;
};

export default shopDeliverySave;
