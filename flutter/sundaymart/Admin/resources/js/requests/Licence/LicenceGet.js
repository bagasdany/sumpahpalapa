import axios from "axios";

const licenceGet = async () => {
    const url = "/api/auth/shop/licensee";

    const headers = {}
    const body = {}

    const response = await axios({
        method: 'get',
        url: url,
        data: body,
        headers: headers
    });

    return response;
}

export default licenceGet;
