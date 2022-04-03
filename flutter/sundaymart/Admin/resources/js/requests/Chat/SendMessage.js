import axios from "axios";

const sendMessage = async (dialog_id, text, user_id) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/chat/send";
    const body = {
        user_id: user_id,
        dialog_id: dialog_id,
        text: text
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

export default sendMessage;
