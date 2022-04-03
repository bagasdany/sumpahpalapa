import i18n from "i18next";
import HttpApi from "i18next-http-backend";
import { initReactI18next } from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";
import {ASSET_PATH} from "./global";

i18n.use(initReactI18next)
    .use(HttpApi)
    .use(LanguageDetector)
    .init({
        supportedLngs: ["ru", "en"],
        fallbackLng: "en",
        lng: "en",
        detection: {
            order: [
                "querystring",
                "cookie",
                "localStorage",
                "sessionStorage",
                "navigator",
                "htmlTag",
                "path",
                "subdomain",
            ],
            caches: ["cookie", "localStorage"],
        },
        backend: {
            loadPath: ASSET_PATH + "locals/{{lng}}/translation.json",
        },
        react: { useSuspense: false },
        interpolation: {
            escapeValue: false,
        },
    });
