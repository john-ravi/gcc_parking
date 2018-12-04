import 'dart:ui';

import 'package:gcc_parking/models/vehicle_type.dart';

/*Strings*/
const String LOGGED_IN = "LoggedIn";
const String CURRENT_USER = "CurrentUser";
const String stringBlackList = "This User is in BlackList";

/*Sizes*/
const double DRAWER_ICON_SIZE = 24.0;

/*Color*/
const selectionIconColor = const Color(0xFFF4EBBE);

/*Timer*/
const fourteenHunredMs = const Duration(milliseconds: 4200);

List<String> listDummy = <String>[
  '',
  "Apple",
  "Armidillo",
  "Actual",
  "Actuary",
  "America",
  "Argentina",
  "Australia",
  "Antarctica",
  "Blueberry",
  "Cheese",
  "Danish",
  "Eclair",
  "Fudge",
  "Granola",
  "Hazelnut",
  "Ice Cream",
  "Jely",
  "Kiwi Fruit",
  "Lamb",
  "Macadamia",
  "Nachos",
  "Oatmeal",
  "Palm Oil",
  "Quail",
  "Rabbit",
  "Salad",
  "T-Bone Steak",
  "Urid Dal",
  "Vanilla",
  "Waffles",
  "Yam",
  "Zest"
];

List<VehicleTypeModel> listVehicleTypes = <VehicleTypeModel>[
  VehicleTypeModel.named(
    vehicleClass: "Two Wheeler",
    vehicleDimensions: "2 m x 1.25 m",
    vehicleECSValue: "0.25",
    parkingFee: 10,
  ),
  VehicleTypeModel.named(
      vehicleClass: "Auto rickshaw",
      vehicleDimensions: "3 m x 1.5-2 m",
      vehicleECSValue: "0.6",
      parkingFee: 15),
    VehicleTypeModel.named(
        vehicleClass: "Car",
        vehicleDimensions: " 5 m x 2 m",
        vehicleECSValue: "1",
    parkingFee: 20),
/*
    VehicleTypeModel.named(
        vehicleClass: "Two Wheeler",
        vehicleDimensions: "2 m x 1.25 m",
        vehicleECSValue: "0.25"),
    VehicleTypeModel.named(
        vehicleClass: "Two Wheeler",
        vehicleDimensions: "2 m x 1.25 m",
        vehicleECSValue: "0.25"),
*/
];
