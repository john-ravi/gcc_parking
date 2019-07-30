import 'dart:ui';

import 'package:gcc_parking/models/vehicle_type.dart';
import 'package:intl/intl.dart';

/*Strings*/
const String LOGGED_IN = "LoggedIn";
const String CURRENT_USER = "CurrentUser";
const String USER_ID = "uid";
const String stringBlackList = "This User is in BlackList";

const stringInactiveParking = "assets/images/inactiveparking.png";
const stringRedParking = "assets/images/redparking.png";

const stringPendingParking = "assets/images/pending.png";
const stringGreenParking = "assets/images/greenparking.png";
const stringImmobParking = "assets/images/immobparking.png";
const stringOrangeParking = "assets/images/orangeparking.png";

/*Sizes*/
const double DRAWER_ICON_SIZE = 24.0;

/*Color*/
const selectionIconColor = const Color(0xFFF4EBBE);

/*Timer*/
const fourteenHunredMs = const Duration(milliseconds: 4200);

final dateFormat = DateFormat("d/M/yyyy h:mm a");
final dateFormatDateOnly = DateFormat("d/M/yyyy");


/*List*/
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
    vid: 2,
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
