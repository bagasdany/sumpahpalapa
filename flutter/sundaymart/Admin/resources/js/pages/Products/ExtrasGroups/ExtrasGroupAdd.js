import React from "react";
import {
    Button,
    Card,
    Checkbox,
    Form,
    Input,
    message,
    PageHeader,
    Radio,
    Select,
} from "antd";
import languageActive from "../../../requests/Language/LanguageActive";
import extraGroupTypeActive from "../../../requests/ExtrasGroups/ExtrasGroupTypesActive";
import extrasGroupSave from "../../../requests/ExtrasGroups/ExtrasGroupSave";
import extrasGroupGet from "../../../requests/ExtrasGroups/ExtrasGroupGet";
import { withTranslation } from "react-i18next";
import {IS_DEMO} from "../../../global";

const { Option } = Select;

class ExtrasGroupAdd extends React.Component {
    formRef = React.createRef();

    constructor(props) {
        super(props);

        this.state = {
            extras_group_types: [],
            extras_group_type: -1,
            extra_group_names: {},
            active_extra_group: true,
            language: "en",
            languages: [],
            id: props.id,
            edit: props.id > 0 ? true : false,
            product_id: props.product_id,
        };

        this.onFinishProductExtraGroup =
            this.onFinishProductExtraGroup.bind(this);
        this.getActiveExtraGroupTypes =
            this.getActiveExtraGroupTypes.bind(this);
        this.onChangeProductExtraGroupName =
            this.onChangeProductExtraGroupName.bind(this);
        this.onChangeLanguage = this.onChangeLanguage.bind(this);
        this.getInfoById = this.getInfoById.bind(this);

        this.getActiveExtraGroupTypes();
        this.getActiveLanguages();
    }

    componentDidMount() {
        if (this.state.edit)
            setTimeout(() => this.getInfoById(this.state.id), 1000);
    }

    getInfoById = async (id) => {
        let data = await extrasGroupGet(id);
        if (data.data.success) {
            let extras_group = data.data.data;
            let extras_group_language = data.data.data["languages"];

            var namesArray = this.state.extra_group_names;
            for (let i = 0; i < extras_group_language.length; i++) {
                var lang = extras_group_language[i].language.short_name;
                namesArray[lang] = extras_group_language[i].name;
            }

            this.setState({
                active_extra_group: extras_group.active == 1 ? true : false,
                extra_group_names: namesArray,
                extras_group_type: extras_group.type,
            });

            this.formRef.current.setFieldsValue({
                extra_group_name: namesArray[this.state.language],
                extras_group_type: extras_group.type,
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

            var extrasNamesArray = this.state.extra_group_names;

            for (let i = 0; i < data.data.data.length; i++) {
                var lang = data.data.data[i].short_name;
                extrasNamesArray[lang] = "";
            }

            this.setState({
                extra_group_names: extrasNamesArray,
            });
        }
    };

    getActiveExtraGroupTypes = async () => {
        let data = await extraGroupTypeActive();
        if (data.data.success == 1 && data.data.data.length > 0) {
            this.setState({
                extras_group_types: data.data.data,
                extras_group_type: data.data.data[0].id,
            });

            const index = data.data.data.findIndex((element, index) => {
                if (element.id === this.state.id_extra_group_type) {
                    return true;
                }
            });

            this.formRef.current.setFieldsValue({
                extras_group_type:
                    index > -1
                        ? this.state.id_extra_group_type
                        : data.data.data[0].id,
            });
        }
    };

    changeStatusExtraGroup = (e) => {
        this.setState({
            active_extra_group: e.target.checked,
        });
    };

    onChangeProductExtraGroupName = (e) => {
        var extraGroupNamesArray = this.state.extra_group_names;
        extraGroupNamesArray[this.state.language] = e.target.value;
        this.setState({
            extra_group_names: extraGroupNamesArray,
        });
    };

    onFinishProductExtraGroup = async (values) => {
        if(IS_DEMO) {
            message.warn("You cannot save in demo mode");
            return;
        }

        let data = await extrasGroupSave(
            this.state.product_id,
            this.state.extra_group_names,
            values.extras_group_type,
            this.state.active_extra_group,
            this.state.id
        );

        if (data.data.success == 1) {
            this.setState({
                id: data.data.data.id,
            });

            this.props.onSave();
        }
    };

    onFinishFailed = (errorInfo) => {};

    onChangeExtrasGroupType = (e) => {
        this.setState({ extras_group_type: e });
    };

    onChangeLanguage = (e) => {
        let lang = e.target.value;
        this.setState({
            language: lang,
        });

        this.formRef.current.setFieldsValue({
            extra_group_name: this.state.extra_group_names[lang],
        });
    };

    render() {
        const { t } = this.props;
        return (
            <PageHeader
                onBack={() => this.props.onSave()}
                className="site-page-header"
                title={
                    this.state.edit
                        ? t("product_extras_group_edit")
                        : t("product_extras_group_add")
                }
            >
                <Form
                    ref={this.formRef}
                    name="basic"
                    initialValues={{
                        extras_group_type: 1,
                    }}
                    layout="vertical"
                    onFinish={this.onFinishProductExtraGroup}
                    onFinishFailed={this.onFinishFailed}
                >
                    <div className="row">
                        <div className="col-md-12 col-sm-12">
                            <Radio.Group
                                value={this.state.language}
                                onChange={this.onChangeLanguage}
                                className="float-right"
                            >
                                {this.state.languages.map((item) => {
                                    return (
                                        <Radio.Button
                                            value={item.short_name}
                                            key={item.short_name}
                                        >
                                            {item.name}
                                        </Radio.Button>
                                    );
                                })}
                            </Radio.Group>
                        </div>
                    </div>
                    <Card
                        style={{ marginTop: "20px" }}
                        title={t("product_extra_group")}
                    >
                        <div className="row">
                            <div className="col-md-6 col-sm-12">
                                <Form.Item
                                    label={t("product_extra_group_name")}
                                    name="extra_group_name"
                                    rules={[
                                        {
                                            required: true,
                                            message: t(
                                                "missing_product_extra_group_name"
                                            ),
                                        },
                                    ]}
                                    tooltip={t(
                                        "enter_product_extra_group_name"
                                    )}
                                >
                                    <Input
                                        placeholder={t(
                                            "product_extra_group_name"
                                        )}
                                        onChange={
                                            this.onChangeProductExtraGroupName
                                        }
                                    />
                                </Form.Item>
                            </div>
                            <div className="col-md-3 col-sm-6">
                                <Form.Item
                                    name="extras_group_type"
                                    label={t("extras_group_type")}
                                    tooltip={t("select_extras_group_type")}
                                >
                                    <Select
                                        placeholder={t(
                                            "select_extras_group_type"
                                        )}
                                        onChange={this.onChangeExtrasGroupType}
                                    >
                                        {this.state.extras_group_types.map(
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
                                        "uncheck_if_extras_group_is_inactive"
                                    )}
                                >
                                    <Checkbox
                                        checked={this.state.active_extra_group}
                                        onChange={this.changeStatusExtraGroup}
                                    >
                                        {this.state.active_extra_group
                                            ? t("active")
                                            : t("inactive")}
                                    </Checkbox>
                                </Form.Item>
                            </div>
                        </div>
                    </Card>
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
            </PageHeader>
        );
    }
}

export default withTranslation()(ExtrasGroupAdd);
