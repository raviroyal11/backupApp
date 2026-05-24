import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:zob/home/clockIn/break_in_out_screen.dart';
import 'package:zob/home/clockIn/clock_in_screen.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/home/controller/map_screen_controller.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/models/barcode_scanner_response_model.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final mapController = Get.put(MapScreenController());
  final dashboardScreenController = Get.find<DashboardScreenController>();

  @override
  void initState() {
    super.initState();
    getClockinButtonStatus();
    dashboardScreenController.getCheckInStatus();
    dashboardScreenController.getUserLoctionUsingApi();
    dashboardScreenController.checkLoginStatus();
    getClockinButtonStatus();
  }

  getClockinButtonStatus() async {
    mapController.isClockinByMap.value = await SharePref().getisClockinByMap();
    mapController.isClockinByQr.value = await SharePref().getisClockinByQr();
    debugPrint("Check by qr status : ${mapController.isClockinByQr.value}");
  }

  //// Add Custom marker
  addCustomMarker({required LatLng tapLatLong}) {
    setState(() {
      mapController.markers.add(
        Marker(
          markerId: MarkerId(tapLatLong.toString()),
          position: tapLatLong,
          onTap: () {
            print('Marker tapped');
            removeMarker(MarkerId(tapLatLong.toString()));
          },
        ),
      );
    });
  }

  //// Remove custom marker
  removeMarker(MarkerId markerId) {
    setState(() {
      mapController.markers
          .removeWhere((marker) => marker.markerId == markerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Obx(
      () => Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              mapController.isSelectMapTab.value
                  ? mapController.isLoadingMap.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.color77DC,
                          ),
                        )
                      : GoogleMap(
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(mapController.latitude.value,
                                mapController.longitude.value),
                            zoom: 14,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            mapController.googleMapController
                                .complete(controller);
                          },
                          onTap: (LatLng latlong) async {
                            debugPrint(
                                "LatLong Value : latitude : ${latlong.latitude}, longitude : ${latlong.longitude}");
                            var mapTapLocationLati = latlong.latitude;
                            var mapTapLocationLongi = latlong.longitude;
                            await mapController.getLatLongToAddress(
                                latitude: latlong.latitude,
                                longitude: latlong.longitude);
                            // ignore: use_build_context_synchronously
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => MapTapInOutDialogWidget(
                                dashboardScreenController:
                                    dashboardScreenController,
                                address: mapController.address,
                                getUserCheckInOutStatusValue:
                                    dashboardScreenController
                                        .getUserClockInOutStatusValue,
                                mapScreenController: mapController,
                                mapTapLocationLati:
                                    mapTapLocationLati.toString(),
                                mapTapLocationLongi:
                                    mapTapLocationLongi.toString(),
                              ),
                            );
                            // addCustomMarker(tapLatLong: latlong);
                          },
                          markers: {
                              Marker(
                                markerId: const MarkerId('s'),
                                position: LatLng(mapController.latitude.value,
                                    mapController.longitude.value),
                              )
                            } //mapController.markers,
                          )
                  : BarcodeScannerScreen(
                      mapScreenController: mapController,
                      dashboardScreenController: dashboardScreenController,
                      location: dashboardScreenController.address.value,
                    ),
              Positioned(
                top: height * 0.075,
                left: width * 0.045,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: height * 0.045,
                    width: height * 0.045,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 231, 233),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColor.colorABF5,
                              blurRadius: 2.0,
                              spreadRadius: 0)
                        ]),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                  ),
                ),
              ),

              //// Map And Scan button

              Obx(
                () => mapController.isClockinByMap.value == true
                    ? Positioned(
                        top: height * 0.075,
                        right: width * 0.35,
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.color95ED,
                          ),
                          child: Center(
                            child: Text(
                              "Map",
                              style: AppStyle()
                                  .workSansSemiBold(context)
                                  .copyWith(
                                    color: !mapController.isSelectMapTab.value
                                        ? AppColor.color4551
                                        : Colors.white,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                      )
                    : Positioned(
                        top: height * 0.075,
                        right: width * 0.25,
                        child: Obx(
                          () => Container(
                            height: height * 0.045,
                            width: width * 0.427,
                            decoration: BoxDecoration(
                              color: AppColor.colorF0FF,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColor.color4551),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    mapController.isSelectMapTab.value = true;
                                  },
                                  child: Container(
                                    height: height * 0.05,
                                    width: width * 0.209,
                                    decoration: !mapController
                                            .isSelectMapTab.value
                                        ? const BoxDecoration()
                                        : const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                            ),
                                            color: AppColor.color95ED,
                                          ),
                                    child: Center(
                                      child: Text(
                                        "Map",
                                        style: AppStyle()
                                            .workSansSemiBold(context)
                                            .copyWith(
                                              color: !mapController
                                                      .isSelectMapTab.value
                                                  ? AppColor.color4551
                                                  : Colors.white,
                                              fontSize: 18,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.07,
                                  width: width * 0.002,
                                  color: AppColor.color4551,
                                ),
                                InkWell(
                                  onTap: () {
                                    mapController.isSelectMapTab.value = false;
                                    // mapController.scanCode();
                                  },
                                  child: Container(
                                    height: height * 0.05,
                                    width: width * 0.209,
                                    decoration: mapController
                                            .isSelectMapTab.value
                                        ? const BoxDecoration()
                                        : const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            ),
                                            color: AppColor.color95ED,
                                          ),
                                    child: Center(
                                      child: Text(
                                        "Scan",
                                        style: AppStyle()
                                            .workSansSemiBold(context)
                                            .copyWith(
                                              color: mapController
                                                      .isSelectMapTab.value
                                                  ? AppColor.color4551
                                                  : Colors.white,
                                              fontSize: 18,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),

              // //// Breack bottom sheet
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Container(
              //     height: height * 0.14,
              //     decoration: const BoxDecoration(
              //       color: AppColor.white,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(16),
              //         topRight: Radius.circular(16),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       child: Row(
              //         children: [
              //           Container(
              //             height: height * 0.05,
              //             width: height * 0.05,
              //             decoration: const BoxDecoration(
              //                 color: Color.fromARGB(255, 134, 184, 244),
              //                 shape: BoxShape.circle),
              //             child: Center(
              //               child: SvgPicture.asset(
              //                 AppImg.account,
              //                 color: AppColor.white,
              //                 height: height * 0.035,
              //               ),
              //             ),
              //           ),
              //           AppHelper().horizontalSpace(size: 10),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Obx(
              //                 () => Text(
              //                   dashboardScreenController.userName.value,
              //                   style: AppStyle.workSansSemiBold.copyWith(
              //                       fontSize: 18, color: AppColor.color4551),
              //                 ),
              //               ),
              //               Text(
              //                 "${dashboardScreenController.getUserClockInOutStatusValue.value == 0 ? "Clock In" : "Clock Out"}",
              //                 style: AppStyle.workSansMedium.copyWith(
              //                     fontSize: 16,
              //                     color: AppColor.color969D,
              //                     height: 1),
              //               )
              //             ],
              //           ),
              //           const Spacer(),
              //           InkWell(
              //             onTap: () {
              // if (dashboardScreenController
              //         .getUserClockInOutStatusValue.value !=
              //     0) {
              //                 Get.to(BreakInOutScreen());
              //               } else {
              //                 CommonSnackBarWidget().snackBarWidget(
              //                     context: context,
              //                     title: "Oh Snap!",
              //                     message:
              //                         "Cannot start brake without clock in",
              //                     snackBarType: ContentType.failure);
              //               }
              //             },
              //             child: Container(
              //               height: height * 0.055,
              //               width: width * 0.3,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 border: Border.all(
              //                     color: AppColor.colorB5BA, width: 1.5),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   "${!dashboardScreenController.breakStart.value ? "Start" : "Stop"} break",
              //                   style: AppStyle.workSansSemiBold.copyWith(
              //                       fontSize: 17, color: AppColor.color969D),
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              //// Clock in button
              !mapController.isSelectMapTab.value
                  ? Container()
                  : mapController.isClockinByQr.value == true
                      ? Positioned(
                          bottom: height * 0.04,
                          right: width * 0.3,
                          left: width * 0.3,
                          child: Container(
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              color: AppColor.color95ED,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: InkWell(
                              onTap: () async {
                                Get.to(BreakInOutScreen());
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    AppHelper().horizontalSpace(size: 5),
                                    Text(
                                      "${!dashboardScreenController.breakStart.value ? "Start" : "Stop"} break",
                                      textAlign: TextAlign.center,
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              fontSize: 17,
                                              color: AppColor.white,
                                              height: 1.2),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          bottom: height * 0.04,
                          right: width * 0.28,
                          left: width * 0.28,
                          child: Container(
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              color: AppColor.color95ED,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: InkWell(
                              onTap: () async {
                                var data = await Get.to(ClockInOutScreen());
                                debugPrint("Check my navigation data : $data");
                                if (data == true) {
                                  getClockinButtonStatus();
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    AppHelper().horizontalSpace(size: 5),
                                    Text(
                                      "${dashboardScreenController.getUserClockInOutStatusValue.value == 0 ? "Check In" : "Check Out"} \nflexible",
                                      textAlign: TextAlign.center,
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              fontSize: 17,
                                              color: AppColor.white,
                                              height: 1.2),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}

class MapTapInOutDialogWidget extends StatelessWidget {
  final RxString address;
  final RxInt getUserCheckInOutStatusValue;
  final MapScreenController mapScreenController;
  final String mapTapLocationLati;
  final String mapTapLocationLongi;
  final DashboardScreenController dashboardScreenController;
  const MapTapInOutDialogWidget(
      {super.key,
      required this.address,
      required this.getUserCheckInOutStatusValue,
      required this.mapScreenController,
      required this.mapTapLocationLati,
      required this.mapTapLocationLongi,
      required this.dashboardScreenController});

  @override
  Widget build(BuildContext context) {
    final dashboardScreenController = Get.find<DashboardScreenController>();
    return Obx(
      () => CupertinoAlertDialog(
        title: Text(
            'Do you want to check ${getUserCheckInOutStatusValue.value == 0 ? "in" : "out"}?'),
        content: Text(
          address.value,
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          CupertinoDialogAction(
            child: mapScreenController.isLoading.value
                ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: AppColor.color77DC,
                      backgroundColor: AppColor.color4551,
                    ),
                  )
                : Text(
                    getUserCheckInOutStatusValue.value == 0
                        ? "Check In"
                        : "Check Out",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColor.color77DC),
                  ),
            onPressed: () {
              mapScreenController.getUserJobLocationData(
                  getUserClockInOutStatus: getUserCheckInOutStatusValue.value,
                  mapTapLocationLati: mapTapLocationLati,
                  mapTapLocationLongi: mapTapLocationLongi,
                  location: dashboardScreenController.address.obs.value.value,
                  callback: (status) {
                    if (status == true) {
                      dashboardScreenController.getUserClockInOutStatus();
                    }
                  });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class BarcodeScannerScreen extends StatefulWidget {
  final MapScreenController mapScreenController;
  final DashboardScreenController dashboardScreenController;
  final String location;
  const BarcodeScannerScreen(
      {super.key,
      required this.mapScreenController,
      required this.dashboardScreenController,
      required this.location});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    // widget.mapScreenController.scanCode();
    // debugPrint("Check hello");
    // if (Platform.isAndroid) {
    //   controller?.pauseCamera();
    // } else if (Platform.isIOS) {
    //   controller?.resumeCamera();
    // }
    getRosterStatus();
    getClockinButtonStatus();
    super.initState();
  }

  getRosterStatus() async {
    widget.dashboardScreenController.isAceptRoster.value =
        await SharePref().getAcceptRoster();
    debugPrint(
        "Clock in value status : ${widget.dashboardScreenController.isAceptRoster.value}");
    widget.dashboardScreenController.isRejectRoster.value =
        await SharePref().getRejectRoster();
    debugPrint(
        "Clock out value status : ${widget.dashboardScreenController.isRejectRoster.value}");
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  getClockinButtonStatus() async {
    widget.mapScreenController.isClockinByMap.value =
        await SharePref().getisClockinByMap();
    widget.mapScreenController.isClockinByQr.value =
        await SharePref().getisClockinByQr();
    debugPrint(
        "Check by qr status : ${widget.mapScreenController.isClockinByQr.value}");
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        String qrResult = scanData.code ?? "";
        Map<String, dynamic> qrResultMap = jsonDecode(qrResult);
        BarcodeScannerResponseModel barcodeScannerResponseModel =
            BarcodeScannerResponseModel.fromJson(qrResultMap);
        if (barcodeScannerResponseModel.locationId != 0) {
          debugPrint("Check data : ");
          debugPrint(
              "My check in value : ${widget.dashboardScreenController.getUserClockInOutStatusValue.value}");
          if ((widget.dashboardScreenController.isAceptRoster.value) == true &&
              (widget.dashboardScreenController.getUserClockInOutStatusValue
                      .value ==
                  0)) {
            debugPrint("Check data : 123 ");
            SharePref().setBarcodeResponse(setBarcodeResponse: qrResult);
            // Get.back();
            widget.dashboardScreenController.clockInApiCall(
              locationId: barcodeScannerResponseModel.locationId.toString(),
              locationLati: barcodeScannerResponseModel.locationLatitude,
              locationLongi: barcodeScannerResponseModel.locationLongitude,
              callBack: (status) {
                widget.mapScreenController.isClockinByQr.value = status;
              },
            );

            widget.mapScreenController.isSelectMapTab.value = true;
          } else {
            widget.dashboardScreenController.clockOutApiCall(
              locationId: barcodeScannerResponseModel.locationId.toString(),
              locationLati: barcodeScannerResponseModel.locationLatitude,
              locationLongi: barcodeScannerResponseModel.locationLongitude,
              location: widget.location,
              callBack: (status) {
                widget.mapScreenController.isClockinByQr.value = status;
              },
            );
            widget.mapScreenController.isSelectMapTab.value = true;
          }
        }
        debugPrint(
            "barcodeScannerResponseModel ${barcodeScannerResponseModel.locationId}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
              borderColor: AppColor.color8EE9,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
            ),
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
      ],
    );
  }
}

///// Add check in/out map dialog widget
