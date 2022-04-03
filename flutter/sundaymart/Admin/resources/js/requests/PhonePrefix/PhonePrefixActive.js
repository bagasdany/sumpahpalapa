import axios from "axios";

const phonePrefixActive = async () => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/phone-prefix/active";
    const body = {};

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

export default phonePrefixActive;
