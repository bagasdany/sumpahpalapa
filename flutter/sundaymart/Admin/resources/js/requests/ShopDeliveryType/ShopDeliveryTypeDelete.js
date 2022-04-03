import axios from "axios";

const shopsCategoryDelete = async (id) => {
    const token = localStorage.getItem("jwt_token");
    const url = `/api/auth/deliveries/delete/${id}`;

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "post",
        url: url,
        headers: headers,
    });

    return response;
};

export default shopsCategoryDelete;
