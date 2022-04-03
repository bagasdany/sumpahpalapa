import React from "react";
import {
    Breadcrumb,
    Button,
    Checkbox,
    Form,
    Input,
    Layout,
    message,
    Modal,
    PageHeader,
    Radio,
    Select,
    Spin,
    Upload,
} from "antd";
import { Link } from "react-router-dom";
import PageLayout from "../../layouts/PageLayout";
import shopActive from "../../requests/Shops/ShopActive";
import languageActive from "../../requests/Language/LanguageActive";
import categoryGet from "../../requests/Categories/CategoryGet";
import faqSave from "../../requests/Faq/FaqSave";
import faqGet from "../../requests/Faq/FaqGet";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../global";

const { Option } = Select;
const { Content } = Layout;
const { TextArea } = Input;

class FaqAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            shops: [],
            language: "en",
            languages: [],
            questions: {},
            answers: {},
            active: true,
            id: props.location.state ? props.location.state.id : 0,
            edit: props.location.state ? props.location.state.edit : false,
        };

        this.getActiveShops = this.getActiveShops.bind(this);
        this.onChangeAnswer = this.onChangeAnswer.bind(this);
        this.getActiveLanguages = this.getActiveLanguages.bind(this);
        this.changeStatus = this.changeStatus.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.onChangeQuestion = this.onChangeQuestion.bind(this);
        this.getInfoById = this.getInfoById.bind(this);

        this.getActiveLanguages();
        this.getActiveShops();
    }

    getInfoById = async (id) => {
        let data = await faqGet(id);
        if (data.data.success) {
            let faq = data.data.data;
            let faq_language = data.data.data["languages"];

            var questionsArray = this.state.questions;
            var answersArray = this.state.answers;
            for (let i = 0; i < faq_language.length; i++) {
                var lang = faq_language[i].language.short_name;
                questionsArray[lang] = faq_language[i].question;
                answersArray[lang] = faq_language[i].answer;
            }

            this.setState({
                active: faq.active == 1 ? true : false,
                questions: questionsArray,
                answers: answersArray,
                shop_id: faq.id_shop,
            });

            this.formRef.current.setFieldsValue({
                question: questionsArray[this.state.language],
                answer: answersArray[this.state.language],
                shop: parseInt(faq.id_shop),
            });
        }
    };

    getActiveLanguages = async () => {
        let data = await languageActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                languages: data.data.data,
                language: data.data.data[0].short_name,
            });

            var questionsArray = this.state.questions;
            var answersArray = this.state.answers;

            for (let i = 0; i < data.data.data.length; i++) {
                var lang = data.data.data[i].short_name;
                questionsArray[lang] = "";
                answersArray[lang] = "";
            }

            this.setState({
                questions: questionsArray,
                answers: answersArray,
            });

            if (this.state.edit) this.getInfoById(this.state.id);
        }
    };

    getActiveShops = async () => {
        let data = await shopActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                shops: data.data.data,
                shop_id: data.data.data[0].id,
            });

            if (this.formRef.current != null)
                this.formRef.current.setFieldsValue({
                    shop: data.data.data[0].id,
                });
        }
    };

    changeStatus = (e) => {
        this.setState({
            active: e.target.checked,
        });
    };

    onChangeQuestion = (e) => {
        var questionsArray = this.state.questions;
        questionsArray[this.state.language] = e.target.value;
        this.setState({
            questions: questionsArray,
        });
    };

    onChangeAnswer = (e) => {
        var answersArray = this.state.answers;
        answersArray[this.state.language] = e.target.value;
        this.setState({
            answers: questionsArray,
        });
    };

    onChangeLanguage = (e) => {
        let lang = e.target.value;
        this.setState({
            language: lang,
        });

        this.formRef.current.setFieldsValue({
            question: this.state.questions[lang],
            answer: this.state.answers[lang],
        });
    };

    onFinish = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await faqSave(
            this.state.questions,
            this.state.answers,
            values.shop,
            this.state.active,
            this.state.id
        );

        if (data.data.success == 1) window.history.back();
    };

    onFinishFailed = (errorInfo) => {};

    render() {
        const { t } = this.props;
        return (
            <PageLayout>
                <Breadcrumb style={{ margin: "16px 0" }}>
                    <Breadcrumb.Item>
                        <Link to="/faq" className="nav-text">
                            {t("faq")}
                        </Link>
                    </Breadcrumb.Item>
                    <Breadcrumb.Item>
                        {this.state.edit ? t("edit") : t("add")}
                    </Breadcrumb.Item>
                </Breadcrumb>
                <PageHeader
                    onBack={() => window.history.back()}
                    className="site-page-header"
                    title={this.state.edit ? t("faq_edit") : t("faq_add")}
                >
                    <Content className="site-layout-background padding-20">
                        {this.state.languages.length > 0 ? (
                            <Form
                                ref={this.formRef}
                                name="basic"
                                initialValues={{}}
                                layout="vertical"
                                onFinish={this.onFinish}
                                onFinishFailed={this.onFinishFailed}
                            >
                                <div className="row">
                                    <div className="col-md-12 col-sm-12">
                                        <Radio.Group
                                            value={this.state.language}
                                            onChange={this.onChangeLanguage}
                                            className="float-right"
                                        >
                                            {this.state.languages.map(
                                                (item) => {
                                                    return (
                                                        <Radio.Button
                                                            value={
                                                                item.short_name
                                                            }
                                                            key={
                                                                item.short_name
                                                            }
                                                        >
                                                            {item.name}
                                                        </Radio.Button>
                                                    );
                                                }
                                            )}
                                        </Radio.Group>
                                    </div>
                                </div>
                                <div className="row">
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("question")}
                                            name="question"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t("missing_question"),
                                                },
                                            ]}
                                            tooltip={t("enter_question")}
                                        >
                                            <TextArea
                                                showCount
                                                maxLength={1000}
                                                onChange={this.onChangeQuestion}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("answer")}
                                            name="answer"
                                            rules={[
                                                {
                                                    required: true,
                                                    message:
                                                        t("missing_answer"),
                                                },
                                            ]}
                                            tooltip={t("enter_answer")}
                                        >
                                            <TextArea
                                                showCount
                                                maxLength={1000}
                                                onChange={this.onChangeAnswer}
                                            />
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-6 col-sm-12">
                                        <Form.Item
                                            label={t("shop")}
                                            name="shop"
                                            rules={[
                                                {
                                                    required: true,
                                                    message: t("missing_shop"),
                                                },
                                            ]}
                                            tooltip={t("select_shop")}
                                        >
                                            <Select
                                                placeholder={t("select_shop")}
                                            >
                                                {this.state.shops.map(
                                                    (item) => {
                                                        return (
                                                            <Option
                                                                value={item.id}
                                                                key={item.id}
                                                            >
                                                                {item.name}
                                                            </Option>
                                                        );
                                                    }
                                                )}
                                            </Select>
                                        </Form.Item>
                                    </div>
                                    <div className="col-md-3 col-sm-6">
                                        <Form.Item
                                            label={t("status")}
                                            name="active"
                                            tooltip={t(
                                                "uncheck_if_category_is_inactive"
                                            )}
                                        >
                                            <Checkbox
                                                checked={this.state.active}
                                                onChange={this.changeStatus}
                                            >
                                                {this.state.active
                                                    ? t("active")
                                                    : t("inactive")}
                                            </Checkbox>
                                        </Form.Item>
                                    </div>
                                </div>
                                <Form.Item>
                                    <Button
                                        type="primary"
                                        className="btn-success"
                                        style={{ marginTop: "40px" }}
                                        htmlType="submit"
                                    >
                                        {t("save")}
                                    </Button>
                                </Form.Item>
                            </Form>
                        ) : (
                            <div
                                className="d-flex flex-row justify-content-center"
                                style={{ height: "400px" }}
                            >
                                <Spin
                                    style={{
                                        marginTop: "auto",
                                        marginBottom: "auto",
                                    }}
                                    size="large"
                                />
                            </div>
                        )}
                    </Content>
                </PageHeader>
            </PageLayout>
        );
    }
}

export default withTranslation()(FaqAdd);
