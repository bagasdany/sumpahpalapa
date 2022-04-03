import React from 'react';
import PageLayout from "../../layouts/PageLayout";
import {Breadcrumb, Layout, PageHeader} from "antd";
import socketIOClient from "socket.io-client";
import styles from "@chatscope/chat-ui-kit-styles/dist/default/styles.min.css";

const {Content} = Layout;
import {
    Sidebar,
    MainContainer,
    ChatContainer,
    MessageList,
    Message,
    MessageInput,
    Avatar,
    ConversationList,
    Conversation,
    ConversationHeader
} from "@chatscope/chat-ui-kit-react";
import chatUsers from "../../requests/Chat/ChatUsers";
import chatMessages from "../../requests/Chat/ChatMessage";
import sendMessage from "../../requests/Chat/SendMessage";
import {CHAT_CLIENT} from "../../global";

class Chat extends React.Component {
    state = {
        users: [],
        user: false,
        messages: [],
        admin: false,
        message: ""
    };
    socket;

    constructor(props) {
        super(props);

        this.getChatUsers = this.getChatUsers.bind(this);
        this.getUserMessage = this.getUserMessage.bind(this);

        this.socket = socketIOClient(CHAT_CLIENT, {
            query: {EIO: 4}
        });
    }

    componentDidMount() {
        this.getChatUsers();
        this.socket.on("message", (data) => {
            let message = JSON.parse(data);
            this.setState({
                messages: [...this.state.messages, message]
            })
        });

        this.socket.on("error", (data) => {
            let message = JSON.parse(data);
            console.log(message);
        });
    }

    componentWillUnmount() {
        this.socket.off("message");
    }

    getChatUsers = async () => {
        let userJson = await localStorage.getItem('user');
        let user = JSON.parse(userJson);
        let data = await chatUsers(user['id']);
        console.log(data);
        if (data.data.success && data.data.data.length > 0) {
            this.setState({
                users: data.data.data,
                user: data.data.data[0],
                admin: user
            });

            this.getUserMessage(data.data.data[0]['dialog_id']);
        }
    }

    getUserMessage = async (dialog_id) => {
        let data = await chatMessages(dialog_id);
        if (data.data.success) {
            console.log(data.data.data['messages']);
            this.setState({
                messages: data.data.data['messages'],
            });
        }
    }

    sendMessageChat = async () => {
        let userJson = await localStorage.getItem('user');
        let user = JSON.parse(userJson);
        let data = await sendMessage(this.state.user.dialog_id, this.state.message, user['id']);
        if (data.data.success) {
            this.setState({
                message: ""
            });
        }
    }

    render() {
        return (
            <PageLayout>
                <PageHeader
                    style={{margin: '16px 0'}}
                    className="site-page-header"
                >
                    <Content
                        className="site-layout-background">
                        <div style={{position: "relative", height: "500px"}}>
                            <MainContainer responsive>
                                <Sidebar position="left" scrollable={false}>
                                    <ConversationList>
                                        {
                                            this.state.users.map((item) => {
                                                return <Conversation
                                                    onClick={() => {
                                                        this.setState({
                                                            messages: [],
                                                            user: item
                                                        });

                                                        this.getUserMessage(item['dialog_id']);
                                                    }}
                                                    name={item['user']['name'] + " " + item['user']['surname']}
                                                    key={item['user']['id']}
                                                    info={"ID: " + item['user']['id']}
                                                    active={this.state.user['user']['id'] == item['user']['id']}>
                                                    <Avatar
                                                        src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png"
                                                        name="Lilly" status="invisible"/>
                                                </Conversation>;
                                            })
                                        }
                                    </ConversationList>
                                </Sidebar>

                                <ChatContainer>
                                    {
                                        this.state.user && (
                                            <ConversationHeader>
                                                <ConversationHeader.Back/>
                                                <Avatar
                                                    src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png"
                                                    name={this.state.user.user.name + " " + this.state.user.user.surname}/>
                                                <ConversationHeader.Content
                                                    userName={this.state.user.user.name + " " + this.state.user.user.surname}/>
                                            </ConversationHeader>
                                        )
                                    }

                                    <MessageList>
                                        {/*<MessageSeparator content="Saturday, 30 November 2019"/>*/}
                                        {
                                            this.state.messages.map((item) => {
                                                return <Message key={item['id']} model={{
                                                    message: item['text'],
                                                    sentTime: "15 mins ago",
                                                    sender: this.state.user.user.name + " " + this.state.user.user.surname,
                                                    direction: item['user_id'] == this.state.admin['id'] ? "outgoing" : "incoming",
                                                    position: "single"
                                                }}>
                                                </Message>;
                                            })
                                        }
                                    </MessageList>
                                    <MessageInput placeholder="Type message here" value={this.state.message}
                                                  onChange={val => {
                                                      console.log(val);
                                                      this.setState({
                                                          message: val
                                                      })
                                                  }}
                                                  onSend={() => {
                                                      this.sendMessageChat();
                                                  }}/>
                                </ChatContainer>
                            </MainContainer>
                        </div>
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default Chat;
