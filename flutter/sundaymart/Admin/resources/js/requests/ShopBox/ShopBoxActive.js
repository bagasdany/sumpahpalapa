import axios from "axios";

const shopBoxActive = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/shipping-box/active";

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

export default shopBoxActive;
