import axios from "axios";

const shopDeliveryTypeActive = async () => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/deliveries/active";

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

export default shopDeliveryTypeActive;
