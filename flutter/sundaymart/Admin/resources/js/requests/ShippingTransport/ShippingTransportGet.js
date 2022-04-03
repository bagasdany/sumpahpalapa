import axios from "axios";

const shippingTransportGet = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/deliveries/transports/get/${id}`;

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

export default shippingTransportGet;
