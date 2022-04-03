import axios from "axios";

const privacySave = async (id_shop, privacy, id) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/privacy/save";
    const body = {
        privacy_content: privacy,
        id_shop: id_shop,
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

export default privacySave;
