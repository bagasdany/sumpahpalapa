import axios from "axios";

const shopDeliveryType = async (query) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/deliveries/datatable?${query}`;

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "get",
        url: url,
        data: {},
        headers: headers,
    });

    return response;
};

export default shopDeliveryType;
