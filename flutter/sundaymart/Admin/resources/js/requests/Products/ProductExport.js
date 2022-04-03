import axios from "axios";

const productExport = async (type, start, end) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/product/export?type=" + type + "&start=" + start + "&end=" + end;

    const headers = {
        "Authorization": "Bearer " + token
    }

    const response = await axios({
        method: 'get',
        url: url,
        headers: headers
    });

    return response;
}

export default productExport;
