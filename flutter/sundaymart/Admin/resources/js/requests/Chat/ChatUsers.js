import axios from "axios";

const chatUsers = async (user_id) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/chat/users";
    const body = {
        id: user_id,
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

export default chatUsers;
