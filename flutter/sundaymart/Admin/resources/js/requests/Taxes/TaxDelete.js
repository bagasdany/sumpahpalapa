import axios from "axios";

const taxDelete = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/taxes/delete/${id}`;

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

export default taxDelete;
