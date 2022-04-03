import React, {useState} from "react";
import {Button, Image, message} from "antd";
import {useTranslation} from "react-i18next";

export default ({open, close, outSideClick, extrasData, addExtras}) => {
    const {t} = useTranslation();

    const [selected, setSelected] = useState([]);

    const handleAddProduct = () => {
        addExtras(selected);
        close();
        setSelected([]);
    };

    return (
        <>
            {open && extrasData.length != 0 ? (
                <div
                    onClick={outSideClick}
                    style={{
                        width: "100%",
                        height: "100%",
                        position: "absolute",
                        right: 0,
                        zIndex: 1200,
                        backgroundColor: "rgba(0, 0, 0, 0.5)",
                    }}
                >
                    <div
                        className="d-flex flex-row align-items-center justify-content-center"
                        style={{
                            height: "100%",
                        }}
                    >
                        <div
                            onClick={(e) => {
                                e.stopPropagation();
                            }}
                            style={{
                                width: "685px",
                                // minHeight: "365px",
                                borderRadius: 15,
                                padding: 24,
                                backgroundColor: "#fff",
                            }}
                        >
                            <div
                                className="d-flex flex-row justify-content-between"
                                style={{
                                    height: "100%",
                                }}
                            >

                                {extrasData.map(
                                    (item, idx) =>
                                        item.type === 1 && (
                                            <div
                                                style={{
                                                    width: "58%",
                                                    height: "100%",
                                                    background: "#F9F9F6",
                                                    borderRadius: "15px",
                                                    padding: "20px",
                                                }}
                                            >
                                                <div key={idx}>
                                                    <span
                                                        style={{
                                                            fontWeight: "bold",
                                                            fontSize: 20,
                                                        }}
                                                    >
                                                        {item.type === 1 &&
                                                        item?.language.name}
                                                    </span>
                                                    <div
                                                        className="d-flex flex-row justify-content-between align-items-center "
                                                        style={{
                                                            flexWrap: "wrap",
                                                        }}
                                                    >
                                                        {item?.extras.map(
                                                            (itm, index) => {
                                                                return (
                                                                    <div
                                                                        key={index}
                                                                        onClick={() => {
                                                                            var slted = selected;
                                                                            var extaItem = {
                                                                                extras_group_id: itm.id_extra_group,
                                                                                id: itm.id,
                                                                                extras_name: itm.language.name,
                                                                                price: itm.price
                                                                            };

                                                                            var index = slted.findIndex((item) => item.extras_group_id == itm.id_extra_group);
                                                                            if (index == -1)
                                                                                slted.push(extaItem);
                                                                            else
                                                                                slted[index] = extaItem;

                                                                            setSelected([...slted]);
                                                                        }
                                                                        }
                                                                        style={{
                                                                            border:
                                                                                selected.findIndex((element) => element.id == itm.id) > -1
                                                                                    ? "1px solid #45A524"
                                                                                    : "none",
                                                                            background:
                                                                                "#FFFFFF",
                                                                            borderRadius: 15,
                                                                            padding:
                                                                                "10px",
                                                                            width: "160px",
                                                                            marginBottom: 8,
                                                                        }}
                                                                    >

                                                                        {
                                                                            item.type ===
                                                                            1 && (
                                                                                <div className="d-flex flex-column">
                                                                                    <Image
                                                                                        height={
                                                                                            60
                                                                                        }
                                                                                        src={
                                                                                            itm.image_url
                                                                                        }
                                                                                        preview={
                                                                                            false
                                                                                        }
                                                                                        fallback="data:image/png;base64,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"
                                                                                    />
                                                                                    <div
                                                                                        style={{
                                                                                            border: "1px solid #f2f2f2",
                                                                                            marginTop:
                                                                                                "10px",
                                                                                            marginBottom:
                                                                                                "10px",
                                                                                        }}
                                                                                    />
                                                                                    <span
                                                                                        style={{
                                                                                            fontWeight:
                                                                                                "bold",
                                                                                            fontSize: 12,
                                                                                        }}
                                                                                    >
                                                                            $
                                                                                        {
                                                                                            itm.price
                                                                                        }
                                                                        </span>
                                                                                </div>
                                                                            )
                                                                        }
                                                                    </div>
                                                                );
                                                            }
                                                        )}
                                                    </div>
                                                </div>
                                            </div>
                                        )
                                )}


                                <div
                                    className="d-flex flex-column justify-content-between"
                                    style={{
                                        width: "38%",
                                    }}
                                >
                                    <div
                                        style={{
                                            background: "#F9F9F6",
                                            borderRadius: "15px",
                                        }}
                                    >
                                        {extrasData.map((item, idx) => (
                                            <div key={idx}>
                                                {item.type === 2 && (
                                                    <div
                                                        className="d-flex flex-column"
                                                        style={{
                                                            padding: "20px",
                                                        }}
                                                    >
                                                        <span
                                                            style={{
                                                                fontWeight:
                                                                    "bold",
                                                                fontSize: 20,
                                                            }}
                                                        >
                                                            {item.type === 2 &&
                                                            item?.language
                                                                .name}
                                                        </span>
                                                        <div className="d-flex flex-row">
                                                            {item.type === 2 &&
                                                            item?.extras.map(
                                                                (
                                                                    itm,
                                                                    index
                                                                ) => {
                                                                    var i = selected.findIndex((element) => element.id == itm.id);
                                                                    return (
                                                                        <div
                                                                            key={
                                                                                index
                                                                            }
                                                                            onClick={() => {
                                                                                var slted = selected;
                                                                                var extaItem = {
                                                                                    extras_group_id: itm.id_extra_group,
                                                                                    id: itm.id,
                                                                                    extras_name: itm.language.name,
                                                                                    price: itm.price
                                                                                };

                                                                                var index = slted.findIndex((item) => item.extras_group_id == itm.id_extra_group);
                                                                                if (index == -1)
                                                                                    slted.push(extaItem);
                                                                                else
                                                                                    slted[index] = extaItem;

                                                                                setSelected([...slted]);
                                                                            }
                                                                            }
                                                                            className="d-flex flex-row align-items-center justify-content-center"
                                                                            style={{
                                                                                width: "20px",
                                                                                height: "20px",
                                                                                borderRadius:
                                                                                    "15px",
                                                                                cursor: "pointer",
                                                                                boxSizing:
                                                                                    "border-box",
                                                                                marginRight: 8,
                                                                                padding: 3,
                                                                                border:
                                                                                    i > -1
                                                                                        ? "2px solid #45A524"
                                                                                        : `2px solid ${itm.background_color}`,
                                                                            }}
                                                                        >
                                                                            <div
                                                                                style={{
                                                                                    width: "10px",
                                                                                    height: "10px",
                                                                                    borderRadius:
                                                                                        "10px",
                                                                                    backgroundColor: `${itm.background_color}`,
                                                                                }}
                                                                            />
                                                                        </div>
                                                                    );
                                                                }
                                                            )}
                                                        </div>
                                                    </div>
                                                )}
                                                {item.type === 2 && (
                                                    <div
                                                        style={{
                                                            border: "1px solid #f2f2f2",
                                                        }}
                                                    />
                                                )}
                                                {item.type === 3 && (
                                                    <div
                                                        className="d-flex flex-column"
                                                        style={{
                                                            padding: "20px",
                                                        }}
                                                    >
                                                        <span
                                                            style={{
                                                                fontWeight:
                                                                    "bold",
                                                                fontSize: 20,
                                                            }}
                                                        >
                                                            {
                                                                item?.language
                                                                    .name
                                                            }
                                                        </span>
                                                        {item.type === 3 && (
                                                            <div className="d-flex flex-row">
                                                                {item.extras.map(
                                                                    (
                                                                        itm,
                                                                        idx
                                                                    ) => {
                                                                        return (
                                                                            <div
                                                                                onClick={() => {
                                                                                    var slted = selected;
                                                                                    var extaItem = {
                                                                                        extras_group_id: itm.id_extra_group,
                                                                                        id: itm.id,
                                                                                        extras_name: itm.language.name,
                                                                                        price: itm.price
                                                                                    };

                                                                                    var index = slted.findIndex((item) => item.extras_group_id == itm.id_extra_group);
                                                                                    if (index == -1)
                                                                                        slted.push(extaItem);
                                                                                    else
                                                                                        slted[index] = extaItem;

                                                                                    setSelected([...slted]);
                                                                                }
                                                                                }
                                                                                key={
                                                                                    idx
                                                                                }
                                                                                className="d-flex flex-row align-items-center justify-content-center"
                                                                                style={{
                                                                                    border:
                                                                                        selected.findIndex((element) => element.id == itm.id) > -1
                                                                                            ? "1px solid #45A524"
                                                                                            : "1px solid #E9E9E6",
                                                                                    padding:
                                                                                        "5px",
                                                                                    borderRadius:
                                                                                        "8px",
                                                                                    cursor: "pointer",
                                                                                    boxSizing:
                                                                                        "border-box",
                                                                                    marginRight: 8,
                                                                                }}
                                                                            >
                                                                                {
                                                                                    itm
                                                                                        .language
                                                                                        .name
                                                                                }
                                                                            </div>
                                                                        );
                                                                    }
                                                                )}
                                                            </div>
                                                        )}
                                                    </div>
                                                )}
                                            </div>
                                        ))}
                                    </div>
                                    <Button
                                        onClick={() => handleAddProduct()}
                                        style={{
                                            borderRadius: 15,
                                            marginTop: 10,
                                            height: 50,
                                            backgroundColor: "#16AA16",
                                            color: "#fff",
                                        }}
                                    >
                                        {t("add_extras")}
                                    </Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            ) : null}
        </>
    );
};
