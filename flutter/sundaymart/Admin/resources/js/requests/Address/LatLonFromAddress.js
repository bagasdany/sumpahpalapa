import axios from "axios";
import {GOOGLE_MAP_API_KEY} from "../../global";

const latLonFromAddress = async (text) => {
    const url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=' + text + '&inputtype=textquery&fields=formatted_address%2Cgeometry&key=' + GOOGLE_MAP_API_KEY;

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

export default addressDelete;
