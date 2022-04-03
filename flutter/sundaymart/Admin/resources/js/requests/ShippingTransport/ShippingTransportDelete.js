import axios from "axios";

const shippingTransportDelete = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/deliveries/transports/delete/${id}`;

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

export default shippingTransportDelete;
