import axios from "axios";

const termsSave = async (id_shop, about, id) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/terms/save";
    const body = {
        terms_content: about,
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

export default termsSave;
