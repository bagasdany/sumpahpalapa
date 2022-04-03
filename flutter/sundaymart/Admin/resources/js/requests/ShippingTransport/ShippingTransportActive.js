import axios from "axios";

const shippingTransportActive = async (shop_id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/shop/transports/datatable?shop_id=" + shop_id;

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "get",
        url: url,
        headers: headers
    });

    return response;
};

export default shippingTransportActive;
