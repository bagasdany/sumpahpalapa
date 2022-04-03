import axios from "axios";

const deliveryBoyList = async (shop_id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/admin/delivery-boys";

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

export default deliveryBoyList;
