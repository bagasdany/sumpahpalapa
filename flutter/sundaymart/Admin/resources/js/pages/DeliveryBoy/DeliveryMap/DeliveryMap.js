import React, { useEffect, useState } from "react";
import {
    withGoogleMap,
    GoogleMap,
    Marker,
    withScriptjs,
    Polyline,
    OverlayView,
} from "react-google-maps";
import PageLayout from "../../../layouts/PageLayout";
import {
    Breadcrumb,
    PageHeader,
    Layout,
    Table,
    Button,
    Card,
    message,
    Tag,
} from "antd";
import { CloseSquareFilled } from "@ant-design/icons";
import getDeliveryBoyData from "../../../requests/DeliveryBoy/DeliveryBoyList";
import reqwest from "reqwest";
import { isAllowed } from "../../../helpers/IsAllowed";
import { useTranslation } from "react-i18next";
import {GOOGLE_MAP_API_KEY} from "../../../global";

const { Content } = Layout;
const getPixelPositionOffset = (width, height) => ({
    x: width,
    y: height,
});
const MyMapComponent = withScriptjs(
    withGoogleMap(({ data, handleMarker, polylineCoordinates }) => {
        const pathCoordinates = polylineCoordinates.map((item) => ({
            lat: item[1],
            lng: item[0],
        }));

        return (
            <GoogleMap
                defaultZoom={8}
                defaultCenter={{
                    lat: data[0]?.position.lat,
                    lng: data[0]?.position.lng,
                }}
            >
                {data.map((item, idx) => (
                    <OverlayView
                        key={`${idx + 1}`}
                        position={{
                            lat: item.position.lat,
                            lng: item.position.lng,
                        }}
                        mapPaneName={OverlayView.OVERLAY_MOUSE_TARGET}
                        getPixelPositionOffset={getPixelPositionOffset}
                    >
                        <>
                            <Marker
                                onClick={() => handleMarker(item.id)}
                                position={{
                                    lat: item.position.lat,
                                    lng: item.position.lng,
                                }}
                            />
                            <div
                                style={{
                                    backgroundColor: "#fff",
                                    borderRadius: "5px",
                                    padding: "5px 10px",
                                    position: "absolute",
                                    top: "-45px",
                                    right: "-88px",
                                }}
                            >
                                <div
                                    style={{
                                        width: 0,
                                        height: 0,
                                        borderTop: "10px solid transparent",
                                        borderBottom: "10px solid transparent",
                                        position: "absolute",
                                        left: -8,
                                        top: 8,
                                        borderRight: "10px solid #fff",
                                    }}
                                />
                                <div className="d-flex flex-row align-items-center pointer">
                                    <div className="d-flex flex-column">
                                        <span
                                            style={{
                                                fontSize: "12px",
                                                fontWeight: "normal",
                                            }}
                                        >
                                            {item.name}
                                        </span>
                                        <span
                                            style={{
                                                fontSize: "10px",
                                                fontWeight: "lighter",
                                            }}
                                        >
                                            {item.shop_name}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </>
                    </OverlayView>
                ))}
                {pathCoordinates.length > 0 && (
                    <>
                        <Marker
                            icon={
                                "http://maps.google.com/mapfiles/ms/icons/blue.png"
                            }
                            position={{
                                lat: pathCoordinates[0]?.lat,
                                lng: pathCoordinates[0]?.lng,
                            }}
                        />
                        <Polyline
                            path={pathCoordinates}
                            geodesic={true}
                            options={{
                                strokeColor: "#389e0d",
                                strokeOpacity: 0.75,
                                strokeWeight: 5,
                                icons: [
                                    {
                                        icon: "hello",
                                        offset: "0",
                                        repeat: "20px",
                                    },
                                ],
                            }}
                        />
                        <Marker
                            icon={
                                "http://maps.google.com/mapfiles/ms/icons/green.png"
                            }
                            position={{
                                lat: pathCoordinates[pathCoordinates.length - 1]
                                    .lat,
                                lng: pathCoordinates[pathCoordinates.length - 1]
                                    .lng,
                            }}
                        />
                    </>
                )}
            </GoogleMap>
        );
    })
);
const DeliveryMap = () => {
    const { t } = useTranslation();
    const [data, setData] = useState([]);
    const [tableData, setTableData] = useState([]);
    const [coordinates, setCoordinates] = useState([]);
    const [loading, setLoading] = useState(false);
    const [show, setShow] = useState(false);
    const [pagination, setPagination] = useState({
        current: 1,
        pageSize: 10,
    });
    const columns = [
        {
            title: "ID",
            dataIndex: "id",
        },
        {
            title: "Client",
            dataIndex: "user",
        },
        {
            title: "Price",
            dataIndex: "amount",
        },
        {
            title: "Status",
            dataIndex: "order_status",
            render: (order_status, row) => {
                var order_status_colors = [
                    "default",
                    "processing",
                    "warning",
                    "success",
                    "error",
                ];
                return (
                    <Tag color={order_status_colors[row.order_status_id - 1]}>
                        {order_status}
                    </Tag>
                );
            },
        },
        {
            title: "Options",
            dataIndex: "options",
            render: (options, row) => {
                return (
                    <div>
                        {row.options?.edit && isAllowed("/admins/edit") && (
                            <Button
                                type="link"
                                onClick={() => handleRoute(row)}
                            >
                                {t("route")}
                            </Button>
                        )}
                    </div>
                );
            },
        },
    ];

    useEffect(() => {
        fetchData();
    }, []);

    const handleRoute = (row) => {
        setLoading(true);
        console.log("Row data", row);
        const token = localStorage.getItem("jwt_token");
        reqwest({
            url: "/api/m/order/delivery/route",
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                order_id: row.id,
                origin_address: row.shop_lng_lat,
                destination_address: row.address_lng_lat,
            },
        }).then((data) => {
            if (!data.success) {
                message.warn(data?.message.message);
                setCoordinates((prev) => []);
                setLoading(false);
            } else {
                setLoading(false);
                console.log(data.data);
                setCoordinates(data.data.properties?.coordinates);
            }
        });
    };

    fetch = (params = {}) => {
        const token = localStorage.getItem("jwt_token");
        setLoading(true);
        reqwest({
            url: `/api/auth/order/datatable?id_delivery_boy=${params.id}`,
            method: "post",
            type: "json",
            headers: {
                Authorization: "Bearer " + token,
            },
            data: {
                sort: true,
                length: params.pagination.pageSize,
                start:
                    (params.pagination.current - 1) *
                    params.pagination.pageSize,
            },
        }).then((data) => {
            setLoading(false);
            setTableData(data.data);
            const pag = {
                current: params.pagination.current,
                pageSize: 10,
                total: data.total,
            };
            setPagination(pag);
        });
    };
    const fetchData = async () => {
        let response = await getDeliveryBoyData();
        const newData = response.data.data.map((item) => ({
            ...item,
            position: {
                created_at: item.position.created_at,
                updated_at: item.position.updated_at,
                lat: item.position.coordinates.split(",")[0] * 1,
                lng: item.position.coordinates.split(",")[1] * 1,
            },
        }))

        setData(newData);
    };
    const openTable = (id) => {
        setShow(true);
        fetch({ pagination, id });
    };
    const closeTable = () => {
        setCoordinates((prev) => []);
        setShow(false);
    };
    const handleTableChange = (pagination, filters, sorter) => {
        fetch({
            sortField: sorter.field,
            sortOrder: sorter.order,
            pagination,
            ...filters,
        });

        setPagination(pagination);
    };

    return (
        <PageLayout>
            <Breadcrumb style={{ margin: "16px 0" }}>
                <Breadcrumb.Item>{t("delivery_boy_map")}</Breadcrumb.Item>
            </Breadcrumb>
            <PageHeader
                className="site-page-header"
                title={t("delivery_boy_map")}
            >
                <Content className="site-layout-background">
                    <div className="row">
                        <div
                            className={`${
                                show
                                    ? "col-md-8 col-sm-12 mb-3"
                                    : "col-md-12 col-sm-12 mb-3"
                            } `}
                            style={{ height: "700px" }}
                        >
                            {data.length > 0 ? (
                                <MyMapComponent
                                    data={data}
                                    polylineCoordinates={coordinates}
                                    handleMarker={openTable}
                                    isMarkerShown
                                    googleMapURL={"https://maps.googleapis.com/maps/api/js?key=" + GOOGLE_MAP_API_KEY + "&v=3.exp&libraries=geometry,drawing,places"}
                                    loadingElement={
                                        <div style={{ height: `100%` }} />
                                    }
                                    containerElement={
                                        <div style={{ height: `700px` }} />
                                    }
                                    mapElement={
                                        <div style={{ height: `100%` }} />
                                    }
                                />
                            ) : (
                                <></>
                            )}
                        </div>
                        {show ? (
                            <div className="col-md-4 col-sm-12 mb-3">
                                <Card
                                    style={{
                                        position: "relative",
                                    }}
                                >
                                    <Table
                                        columns={columns}
                                        rowKey={(record) => record.id}
                                        dataSource={tableData}
                                        pagination={pagination}
                                        loading={loading}
                                        onChange={handleTableChange}
                                    />
                                    <CloseSquareFilled
                                        style={{
                                            position: "absolute",
                                            right: 0,
                                            top: 0,
                                            fontSize: "28px",
                                            color: "#f00",
                                        }}
                                        onClick={closeTable}
                                    />
                                </Card>
                            </div>
                        ) : (
                            <></>
                        )}
                    </div>
                </Content>
            </PageHeader>
        </PageLayout>
    );
};

export default DeliveryMap;
