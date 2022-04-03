import axios from "axios";

const shippingTransportSave = async (name, description, active, id) => {
    const token = localStorage.getItem("jwt_token");
    const url = "/api/auth/deliveries/transports/save";
    const body = {
        id: id,
        name: name,
        description: description,
        active: active,
    };

    const headers = {
        Authorization: "Bearer " + token,
    };

    const response = await axios({
        method: "post",
        url: url,
        data: body,
        headers: headers,
    });

    return response;
};

export default shippingTransportSave;
