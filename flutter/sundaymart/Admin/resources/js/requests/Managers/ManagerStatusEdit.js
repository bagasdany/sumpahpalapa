import axios from "axios";

const managerStatusEdit = async (id, status) => {
    const token = localStorage.getItem('jwt_token');
    const url = "/api/auth/manager/edit";
    const body = {
        id: id,
        status: status,
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

export default managerStatusEdit;
