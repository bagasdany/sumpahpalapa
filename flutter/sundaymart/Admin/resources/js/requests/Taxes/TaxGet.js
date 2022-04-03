import axios from "axios";

const taxGet = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/taxes/get/${id}`;

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

export default taxGet;
