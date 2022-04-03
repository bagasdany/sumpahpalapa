import React from "react";
import { MessageOutlined } from "@ant-design/icons";
import { Link } from "react-router-dom";

const ChatButton = (props) => {
    return (
        <Link to="/chat" className="fixed-bottom chat-button">
            <MessageOutlined
                style={{
                    fontSize: "24px",
                    color: "#08c",
                    marginTop: "auto",
                    marginBottom: "auto",
                }}
            />
        </Link>
    );
};

export default ChatButton;
