import axios from "axios";
import {GOOGLE_MAP_API_KEY} from "../../global";

const addressFromLatLon = async (lat, lon) => {
    const url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + lat + "," + lon + "&sensor=false&key=" + GOOGLE_MAP_API_KEY;

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
