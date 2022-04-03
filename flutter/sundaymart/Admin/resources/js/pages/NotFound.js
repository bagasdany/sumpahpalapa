import React from "react";
import { Result, Button } from "antd";
import { withTranslation } from "react-i18next";
class NotFound extends React.Component {
    render() {
        const { t } = this.props;
        return (
            <Result
                status="404"
                title="404"
                subTitle={t("sorry_the_page_you_visited_does_not_exist")}
                extra={
                    <Button
                        type="primary"
                        onClick={() => {
                            window.history.back();
                        }}
                    >
                        {t("back_home")}
                    </Button>
                }
            />
        );
    }
}

export default withTranslation()(NotFound);
