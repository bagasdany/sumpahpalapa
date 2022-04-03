import axios from "axios";

const shopTransportGet = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/shop/transports/get/${id}`;

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

export default shopTransportGet;
