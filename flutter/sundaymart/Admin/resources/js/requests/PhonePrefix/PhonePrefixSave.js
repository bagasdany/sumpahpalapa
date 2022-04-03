import axios from "axios";

const phonePrefixSave = async (phone_prefix, active, id) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/phone-prefix/save";
    const body = {
        phone_prefix: phone_prefix,
        active: active,
        id: id
    };

    const headers = {
        "Authorization": "Bearer " + token
    }

    const response = await axios({
        method: 'post',
        url: url,
        data: body,
        headers: headers
    });

    return response;
}

export default phonePrefixSave;
