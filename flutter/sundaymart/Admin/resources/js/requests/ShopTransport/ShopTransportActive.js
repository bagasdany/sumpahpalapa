import axios from "axios";

const shopTransportActive = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/deliveries/transports/active";

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

export default shopTransportActive;
