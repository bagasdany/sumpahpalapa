import axios from "axios";

const chatMessages = async (dialog_id) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/chat/message";
    const body = {
        dialog_id: dialog_id,
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

export default chatMessages;
