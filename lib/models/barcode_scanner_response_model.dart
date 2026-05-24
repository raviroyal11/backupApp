// To parse this JSON data, do
//
//     final barcodeScannerResponseModel = barcodeScannerResponseModelFromJson(jsonString);

import 'dart:convert';

BarcodeScannerResponseModel barcodeScannerResponseModelFromJson(String str) =>
    BarcodeScannerResponseModel.fromJson(json.decode(str));

String barcodeScannerResponseModelToJson(BarcodeScannerResponseModel data) =>
    json.encode(data.toJson());

class BarcodeScannerResponseModel {
  int locationId;
  String locationLatitude;
  String locationLongitude;

  BarcodeScannerResponseModel({
    required this.locationId,
    required this.locationLatitude,
    required this.locationLongitude,
  });

  factory BarcodeScannerResponseModel.fromJson(Map<String, dynamic> json) =>
      BarcodeScannerResponseModel(
        locationId: json["location_id"],
        locationLatitude: json["location_latitude"],
        locationLongitude: json["location_longitude"],
      );

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "location_latitude": locationLatitude,
        "location_longitude": locationLongitude,
      };
}
