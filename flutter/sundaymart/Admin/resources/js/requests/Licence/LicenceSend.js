import axios from "axios";

const licenceSend = async (public_key) => {
    const url = "/api/auth/shop/activate";
    const body = {
        public_key: public_key,
    };

    const headers = {
    }

    const response = await axios({
        method: 'post',
        url: url,
        data: body,
        headers: headers
    });

    return response;
}

export default licenceSend;
