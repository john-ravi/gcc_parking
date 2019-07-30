import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart' show BuildContext;
import 'package:gcc_parking/models/immobolised.dart';
import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/models/model_booking.dart';

import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/models/parking_area.dart';
import 'package:gcc_parking/models/parking_lot.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/models/vehicles_in_out.dart';
import 'package:http/http.dart' as http;

import 'package:gcc_parking/utils/visualUtils.dart';

String remoteAuthority = "3.16.206.234";
String localAuthority = "192.168.0.5";
String authority = remoteAuthority;
String unencodedPath = "/gccparking/parkingapi/parkingapi.php";
String unencodedEnforcementPath = "/gccparking/parkingapi/enforcement.php";
//Enforcement Api http://18.191.190.195/gccparking/parkingapi/enforcement.php?action=agent_login
Future<ModelAgent> validateAndLogin(String agent_email, String agent_pwd,
    String device_num, String agent_pass_code, BuildContextcontext) async {
  ModelAgent modelAgent = ModelAgent.named(boolModelUpdated: false);
/*
  * &agent_email=agent1@gmail.com &agent_pwd=123456789&agent_pass_code=gcc123
  * */
  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "agent_login",
    "agent_email": agent_email,
    "agent_pwd": agent_pwd,
    'agent_device_no': device_num,
    'agent_pass_code': agent_pass_code
  });

  d(uri);

  http.Response httpResponse;
  bool valid;
  try {
    httpResponse = await http.post(uri);
    valid = false;
    if (httpResponse.statusCode == 200) {
// If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(httpResponse.body);
      print("decoded body \t" + decodedBody.toString());

/*
      * {
    "status": "success",
    "agent_id": "1",
    "agent_name": "lakkshmiagent",
    "agent_email": "agent1@gmail.com",
    "agent_mobile": "789413456",
    "agent_device_no": "444444",
    "agent_pass_code": "gcc123",
    "agent_img": "http://ntsolutions.co.in/gccparking/parkingapi/agentimg/1545310937ab2.jpg"
}
      * */
      valid = decodedBody["status"] == "success";
      if (valid) {
        showToast("Logging In - Welcome");
        modelAgent.boolModelUpdated = true;
        modelAgent.id = int.tryParse(decodedBody['agent_id']);
        modelAgent.email = agent_email;
        modelAgent.agentName = decodedBody['agent_name'];
      } else {
        showToast("Please Check Login Details");
      }
    } else {
      showToast("Network Error - ${httpResponse.reasonPhrase}");
    }

    print("Last Mile check validate $valid");
  } catch (e) {
    print(e);
  }

  print("before returning validate $modelAgent");
  return modelAgent;
}

Future<bool> validate(
    String agent_email, String agent_pwd, BuildContext context) async {
  var uri = Uri.http(authority, unencodedPath, {
    "action": "agent_login",
    "agent_email": agent_email,
    "agent_pwd": agent_pwd
  });

  http.Response httpResponse;
  bool valid;
  try {
    httpResponse = await http.post(uri);
    valid = false;
    if (httpResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(httpResponse.body);
      print("decoded body \t" + decodedBody.toString());

      valid = decodedBody["status"] == "success";
      if (valid) {
        showToast("Logging In - Welcome");
      } else {
        showToast("Please Check Login Details");
      }
    } else {
      showToast("Network Error - ${httpResponse.reasonPhrase}");
    }

    print("Last Mile check validate $valid");
  } catch (e) {
    print(e);
  }

  print("before returning validate $valid");
  return valid;
}

Future<bool> dummy(
    String agent_email, String agent_pwd, BuildContext context) async {
/*action=agent_login&agent_email=test@gmail.com&agent_pwd=456123*/
  var uri = Uri.http(authority, unencodedPath, {
    "action": "",
  });

//  d(uri);
  http.Response httpResponse = await http.post(uri);

  bool valid = false;
  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    //   print("decoded body \t" + decodedBody.toString());

    valid = decodedBody["status"] == "success";
    if (valid) {
      s(context, "Logging In - Welcome");
    } else {
      s(context, "Please Check Login Details");
    }
  } else {
    s(context, "Network Error - ${httpResponse.reasonPhrase}");
  }

  return true;
}

Future<int> getTotalVehicles(BuildContext context) async {
/*
  int countVehicles = 0;
  var uri = Uri.http(authority, unencodedPath, {
    "action": "occupied_slots",
  });

  d(uri);
  http.Response httpResponse = await http.post(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
//   print("decoded body \t" + decodedBody.toString());

    List listRaw = decodedBody["all_slots"];
    if (listRaw != null) {
      listRaw.forEach((slot) {
        //   print("Row \t $slot and oo ${slot["Occupied slots"]}");
        if (slot["occupied_slots"] == "1") {
          countVehicles++;
        }
      });
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

//  print("Count $countVehicles");
  return countVehicles;
*/
  return 0;
}

Future<List<ParkingArea>> getParkingAreas(ModelAgent modelAgent) async {
  List<ParkingArea> listParkingArea = [];

  //http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=agent_loc&agent_id=1
  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "agent_loc",
    "agent_id": "${modelAgent.id}",
  });

  d(uri);

  try {
    http.Response httpResponse = await http.get(uri);
    if (httpResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      //   print('raw response ${httpResponse.}');
      var decodedBody;
      try {
        decodedBody = json.decode(httpResponse.body);
      } catch (e) {
        print('error decoding parking areas $e');
      }
      print("decoded body \t" + decodedBody.toString());
/*
{
    "all_lots": [
        {
            "p_loc_id": "1",
            "location": "Anna Nagar ",
            "agent_id": "1",
            "agent_email": "agent1@gmail.com"
        }
    ]
}
         */
      List listRaw = decodedBody["all_lots"];
      if (listRaw != null) {
        listRaw.forEach((location) {
          listParkingArea.add(ParkingArea.named(
            stringParkingArea: location['location'],
            id: int.tryParse(location['p_loc_id']),
          ));
        });
      }
    } else {
      showToast("Network Error - ${httpResponse.reasonPhrase}");
    }
  } catch (e) {
    print('Network Error $e');
  }



  print('list parking area $listParkingArea');
  return listParkingArea;
}

Future<List<Immobolised>> getImmobilised() async {
  List<Immobolised> listImmobolisedVehicles = new List();
  var uri =
      Uri.http(authority, unencodedEnforcementPath, {"action": "immobilised"});

  try {
    http.Response httpResponce = await http.post(uri);
    print(uri);
    if (httpResponce.statusCode == 200) {
      var decodedBody = json.decode(httpResponce.body);
      /*
      *  "all_slots": [
        {
            "slot_b_id": "633",
            "uid": "791",
            "uname": "gopi",
            "v_plate_no": "TN-10-FT-999",
            "location": "Anna Nagar ",
            "Lot name": "Lot-1 Thirumangalam  Metro",
            "p_slot_id": "1",
            "slot_number": "1",
            "Start Date& Time": "2019-01-29 18:34:11",
            "Stop Date& Time": "2019-01-29 19:33:00",
            "Fee Amount": "0.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "6",
            "Penalty Amount": "0.00",
            "Due Amount": "0.00"
        }
    ]
      * */
      print('decoded Body: $decodedBody');
      List vehiclesList = decodedBody["all_slots"];
      if (vehiclesList != null) {
        vehiclesList.forEach((vehicle) {
          print('printing vehicle:$vehicle');

          var immobolised = Immobolised.fromMap(vehicle);
          print('print variable$immobolised');
          listImmobolisedVehicles.add(immobolised);
        });
      } else {
        print('Check Response Body - Are there Immobilised Vehicles');
      }
    }
  } catch (e) {
    print('eroor getting immobilizesd $e');
  }

  return listImmobolisedVehicles;
}

Future<List<ParkingLot>> getParkingLots(int parkingAreaId, ModelAgent modelAgent) async {
  List<ParkingLot> listParkingLot = [];
/*

  http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=agent_lots_list&agent_id=1&p_loc_id=1
*/

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "agent_lots_list",
    'p_loc_id': parkingAreaId.toString(),
    'agent_id': modelAgent.id.toString(),

  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    print("decoded body \t" + decodedBody.toString());
/*
{
    "all_lots": [
        {
            "Agent Id": "1",
            "Agent email": "agent1@gmail.com",
            "Agent Device": "444444",
            "location": "Anna Nagar ",
            "Lot id": "1",
            "Lot name": "Lot-1 Thirumangalam  Metro"
        },

         */
    List listRaw = decodedBody["all_lots"];
    if (listRaw != null) {
      listRaw.forEach((lot) {
        listParkingLot.add(ParkingLot.named(
          stringParkingLotName: lot['Lot name'],
          id: int.tryParse(lot['Lot id']),
        ));
      });
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('list Parking lots $listParkingLot');

  return listParkingLot;
}

Future<int> fetchSlotForLotLength(int i) async {
  // http://18.191.190.195/gccparking/parkingapi/parkingapi.php?action=List_of_slots
  var uri = Uri.http(authority, unencodedPath,
      {"action": "list_of_slots", 'p_loc_id': '1', 'p_lot_id': i.toString()});

  print(uri);
  http.Response httpResponse = await http.get(uri);
  List listRaw;
  if (httpResponse.statusCode == 200) {
    var decodedBody = json.decode(httpResponse.body);
    print("decoded body \t" + decodedBody.toString());
    /*
    "all_slots": [
        {
            "id": "1",
            "location_id": "1",
            "location": "Anna Nagar ",
            "lot_id": "1",
            "lot_name": "lot-01",
            "slot_number": "001",
            "latitude": "13.084678",
            "longitude": "80.216426",
            "slot_avilability": "4",
            "slot_status": "1"
        },
            */

    listRaw = decodedBody["all_slots"];
    if (listRaw != null) {
      print('Parking slots length ${listRaw.length}');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  return listRaw.length;
}

Future<void> sendTokenToServer(ModelAgent modelAgent) async {
  print(' send token to server ${modelAgent.fcmToken}');
  bool boolModelUpdated = false;

/*
http://192.168.0.11/gccparking/parkingapi/enforcement.php?action=agent_push_id&agent_id=1&agent_push_id=12234dsrdg6
* */
  Map<String, String> map = {};
  map['action'] = 'agent_push_id';
  map['agent_id'] = modelAgent.id.toString();
  map['agent_push_id'] = modelAgent.fcmToken;
  var uri = Uri.http(authority, unencodedEnforcementPath, map);

  print(uri);
  http.Response httpResponse;
  try {
    httpResponse = await http.post(uri);
  } catch (e) {
    print(e);
    showToast('Error occured please retry');
  }
  print('SEnd token response code ${httpResponse.statusCode}');
  if (httpResponse.statusCode == 200) {
    var decode;
    try {
      decode = json.decode(httpResponse.body);
    } catch (e) {
      print('error decoding send Token body $e');
    }
    print('json decode $decode');
    /*
{
    "status": "success",
    "message": "User Push Notification updated successfully"
}        */

    if (decode != null) {
      if (decode['status'] == 'success') {
        print('FCM Token sent to Server');
      } else {
        print('FAiled Updateing Token ');
      }
    } else {
      print('Decode is nukkl');
    }
  } else {
    showToast('Network Error ${httpResponse.reasonPhrase}');
  }
}

Future<List<ModelBooking>> getUserDetails(String userID) async {
  List<ModelBooking> vehiclesList = new List();
  http.Response httpResponce;
  try {
    var url = Uri.http(
        authority, unencodedPath, {"action": "search_vehicles", "uid": userID});
    print(url);
    httpResponce = await http.post(url);
    if (httpResponce.statusCode == 200) {
      print(httpResponce.statusCode);
      var decodedBody = json.decode(httpResponce.body);
      print('decodedBody:$decodedBody');
      var decodedStatus = decodedBody['status'];
      if (decodedStatus == 'No result found!') {
        showToast('user details not found');
      } else
        (showToast('getting user detais'));
      List search = decodedBody["all_slots"];
      search.forEach((veh) {
        /*
    "uid": "1",
    "v_plate_no": "AP-09-AP-0123",
    "Current Booking": null,
    "all_slots": [
        {
            "user_id": "1",
            "user name": "lakan",
            "v_plate_no": "AP-09-AP-0123",
            "vehicle type": null,
            "slot_booking_id": "3",
            "slot_booking_Location": "Anna Nagar ",
            "slot_booking_Lot": "lot-01",
            "slot_booking_slot": "007",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "slot number": "007",
            "Start Data & Time": "2019-01-24 17:28:59",
            "Stop Data & Time": "2019-01-24 18:28:59",
            "arrivel Data & Time": "0000-00-00 00:00:00",
            "depar_time": "0000-00-00 00:00:00",
            "Fee": "30.00",
            "Fine": "0.00",
            "Penalty": "0.00",
            "Due": "0.00",
            "payment_status": "2",
            "booking status": "2"*/
        var serhList = ModelBooking.fromMap(veh);
        serhList.modelVehicle = Vehicle.named(
            vehiclePlateNumber: veh['v_plate_no'],
            vehicleType: veh['vehicle '
                'type'],
            userName: veh['user name'],
            userId: veh['user_id']);

        vehiclesList.add(serhList);
        print('this is search list:$serhList');
      });
    }
  } catch (e) {
    print(e);
  }
  print('Vehicle ?List $vehiclesList');
  return vehiclesList;
}

// todo - see else has no block braces you will get error in future
Future<List<ModelBooking>> getVehicleDetails(String vehNum) async {
  List<ModelBooking> vehiclesHistoryList = new List();
  http.Response httpResponce;
  try {
    var url = Uri.http(authority, unencodedPath,
        {"action": "search_veh_booking", "v_plate_no": vehNum});
    print(url);
    httpResponce = await http.post(url);
    if (httpResponce.statusCode == 200) {
      print(httpResponce.statusCode);
      print(httpResponce.body);
      var decodedBody = json.decode(httpResponce.body);
      print('decodedBody:$decodedBody');
      var decodedStatus = decodedBody['status'];
      if (decodedStatus == 'No result found!') {
        showToast('Vehicle details not found');
      } else{
        showToast('getting vehicle details');}
      List search = decodedBody["all_slots"];
      search.forEach((veh) {
        /*
    "uid": "1",
    "v_plate_no": "AP-09-AP-0123",
    "Current Booking": null,
    "all_slots": [
        {
            "user_id": "1",
            "user name": "lakan",
            "v_plate_no": "AP-09-AP-0123",
            "vehicle type": null,
            "slot_booking_id": "3",
            "slot_booking_Location": "Anna Nagar ",
            "slot_booking_Lot": "lot-01",
            "slot_booking_slot": "007",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "slot number": "007",
            "Start Data & Time": "2019-01-24 17:28:59",
            "Stop Data & Time": "2019-01-24 18:28:59",
            "arrivel Data & Time": "0000-00-00 00:00:00",
            "depar_time": "0000-00-00 00:00:00",
            "Fee": "30.00",
            "Fine": "0.00",
            "Penalty": "0.00",
            "Due": "0.00",
            "payment_status": "2",
            "booking status": "2"*/
        var serhList = ModelBooking.fromMap(veh);
        serhList.modelVehicle = Vehicle.named(
            vehiclePlateNumber: veh['v_plate_no'],
            vehicleType: veh['vehicle '
                'type'],
            userName: veh['user name'],
            userId: veh['user_id']);
        vehiclesHistoryList.add(serhList);
      });
    }
  } catch (e) {
    print(e);
  }
  print('Vehicle ?List $vehiclesHistoryList');
  return vehiclesHistoryList;
}

Future<Vehicle> getUserFromVehicle(String vehNum) async {
  Vehicle vehicle;
  http.Response httpResponce;
  try {
    http: //3.16.206.234/gccparking/parkingapi/enforcement.php?action=user_details&v_plate_no=TN-20-BU-0001
    var url = Uri.http(authority, unencodedEnforcementPath,
        {"action": "user_details", "v_plate_no": vehNum});
    print(url);
    httpResponce = await http.post(url);
    if (httpResponce.statusCode == 200) {
      print(httpResponce.statusCode);
      print(httpResponce.body);
      var decodedBody = json.decode(httpResponce.body);
      print('decodedBody:$decodedBody');
      /*
      "status": "success"
      * "user_details": [
        {
            "user_id": "96",
            "user_name": "uday",
            "user_mobile": "8593941310",
            "user_vid": "81",
            "v_plate_no": "TN-20-BU-0001",
            "vehicle_id": "1",
            "vehicle_type": "CAR"
        },
      * */
      var decodedStatus = decodedBody['status'];
      if (decodedStatus == 'success') {
        showToast('Vehicle details found hehe');
        List listRaw = decodedBody["user_details"];
        print('List Raw length ${listRaw.length}');
        print('List of 0 ${listRaw[0]}');
        var map = listRaw[0];
        vehicle = Vehicle.named(
          userId: map['user_id'],
          userName: map['user_name'],
          mobile: map['user_mobile'],
          userVehicleId: map['user_vid'],
          vehiclePlateNumber: map['v_plate_no'],
          vehicleType: map['vehicle_type'],
        );
      } else
        showToast('Vehicle Not in Records');
    }
  } catch (e) {
    print(e);
  }
  print('Vehicle ?List $vehicle');
  return vehicle;
}

Future<List<ParkingSlot>> getParkingSlots(
    int parkingLocId, int parkingLotId, bool boolDisabled) async {
  List<ParkingSlot> listParkingSlot = [];
/*
http://3.16.206.234/gccparking/parkingapi/parkingapi.php?action=list_of_slots&p_loc_id=1&p_lot_id=1&disabled_type=Normal*/

  String disabledType = boolDisabled ? 'Disabled' : 'Normal';
  var uri = Uri.http(authority, unencodedPath, {
    "action": "list_of_slots",
    'p_loc_id': parkingLocId.toString(),
    'p_lot_id': parkingLotId.toString(),
    'disabled_type': disabledType,
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    //   print("decoded body \t" + decodedBody.toString());

    List listRaw = decodedBody["all_slots"];
    if (listRaw != null) {
      listRaw.forEach((slot) {
        var dateStart;
        var dateEnd;
        Vehicle vehicle = Vehicle.named();
        SlotStatus slotStatus;

/*
all_slots": [
        {
            "id": "100",
            "location_id": "1",
            "location": "Anna Nagar ",
            "lot_id": "2",
            "lot_name": "lot-02",
            "slot_number": "101",
            "latitude": "13.084805",
            "longitude": "80.210033",
            "slot_avilability": "1"
        },

        "all_slots": [
        {
            "user name": "John RAvi",
            "v_plate_no": "TN-09-H-77777",
            "location": "Anna Nagar ",
            "Lot name": "Lot-3 Santhosh Super Market",
            "slot number": "72",
            "Start Data & Time": "2019-01-31 15:34:00",
            "Stop Data & Time": "2019-01-31 16:00:00",
            "Applicable Fees": "15.00",
            "Payment Status": "2",
            "Applicable Fine": "0.00",
            "slot booking status": "2",
            "Profile": "http://3.16.206.234/gccparking/admin/",
            "black_list": "1"
        },
                               */
        var stringSlotStatus = slot['slot_avilability'];
        var slotNumber = slot['slot_number'];

        var slotAvailability;
        if (stringSlotStatus != null) {
          slotAvailability = int.tryParse(stringSlotStatus);
        } else {
          print('HEEYYYYYYYYY slot Availbility from json is null - CHECKK');
        }

        if (slotAvailability == 1 || slotAvailability == 4) {
          slotStatus = SlotStatus.vacant;
        } else if (slotAvailability == 3) {
          slotStatus = SlotStatus.occupied;
        } else if (slotAvailability == 5) {
          slotStatus = SlotStatus.inactive;
        } else if (slotAvailability == 6) {
          slotStatus = SlotStatus.immobilized;
        } else if (slotAvailability == 2) {
          slotStatus = SlotStatus.reserved;
        } else if (slotAvailability == 7) {
          slotStatus = SlotStatus.pending;
        }

        ParkingSlot parkingSlot = ParkingSlot.named(
          id: int.tryParse(slot['id']),
          slotName: slotNumber,
          slotStatus: slotStatus,
          slotNumber: slotNumber,
          vehicle: vehicle,
          dateTimeStart: dateStart,
          dateTimeEnd: dateEnd,
        );
        //    print('api parkin slot is $parkingSlot');
        listParkingSlot.add(parkingSlot);
      });
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  return listParkingSlot;
}

Future<List<ParkingSlot>> getBookingsForTheDate(
    DateTime dateTimeStart, DateTime dateTimeEnd, int slotId) async {
  List<ParkingSlot> listParkingSlot = [];
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=booking_reports&p_slot_id=1&booking_sdt=2019-01-26 00:00:00&booking_dt=2019-01-27 00:00:00

*/

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "booking_reports",
    'p_slot_id': '$slotId',
    'booking_sdt': '$dateTimeStart',
    'booking_dt': '$dateTimeEnd',
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    //   print("decoded body \t" + decodedBody.toString());

    List listRaw = decodedBody["All_Booking"];
    if (listRaw != null) {
      listRaw.forEach((slot) {
/*
"All_Booking": [
        {
            "slot_b_id": "104",
            "v_plate_no": "TN-13-R-6775",
            "vehicle_type": "CAR",
            "location": "Anna Nagar ",
            "Lot name": "Lot-1 Thirumangalam  Metro",
            "slot id": "1",
            "slot number": "1",
            "Start Data & Time": "2019-01-26 18:20:30",
            "Arrivel_time": "2019-01-26 18:20:30",
            "Depar_time": "2019-01-26 19:19:57",
            "Stop Data & Time": "2019-01-26 19:20:00",
            "slot booking status": "4",
            "slot_comments": null,
            "payment status": "1"
        },
                               */
        var dateStart = DateTime.tryParse(slot['Start Data & Time']);
        var dateEnd = DateTime.tryParse(slot['Depar_time']);
        SlotStatus slotStatus;

        var slotNumber = slot['slot number'];
        Vehicle vehicle = Vehicle.named(
          vehiclePlateNumber: slot['v_plate_no'],
          vehicleType: slot['vehicle_type'],
        );

        ParkingSlot parkingSlot = ParkingSlot.named(
          id: slotId,
          bookingId: int.tryParse(slot['slot_b_id']),
          slotName: slotNumber,
          slotStatus: slotStatus,
          slotNumber: slotNumber,
          vehicle: vehicle,
          dateTimeStart: dateStart,
          dateTimeEnd: dateEnd,
        );
        print('api parkin slot is $parkingSlot');
        listParkingSlot.add(parkingSlot);
      });
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('List Bookings $listParkingSlot');
  return listParkingSlot;
}

Future<List<ParkingSlot>> getReservedBooking(ParkingSlot parkingSlotSent) async {
  List<ParkingSlot> listParkingSlot = <ParkingSlot>[];
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=reserved_vehicles&p_slot_id=27*/

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "reserved_vehicles",
    'p_slot_id': parkingSlotSent.id.toString(),
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody;
    print('body ${httpResponse.body}');
    try {
      decodedBody = json.decode(httpResponse.body);

      List listRaw = decodedBody["Reserved_bookings"];
      if (listRaw != null) {
        listRaw.forEach((slot) {
          var dateStart;
          var dateEnd;

/*
{
    "Reserved_bookings": [
        {
            "id": "653",
            "v_plate_no": "TN-09-H-77777",
            "location": "Anna Nagar ",
            "Lot name": "Lot-2 Adyar Anand Bhavan",
            "slot id": "27",
            "slot number": "27",
            "Start Data & Time": "2019-02-02 14:20:00",
            "Stop Data & Time": "2019-02-02 15:20:00",
            "slot booking status": "2",
            "payment status": "2"
        }
    ]
                                */

          try {
            ParkingSlot parkingSlot = ParkingSlot.named(
              //       id: parkingSlotSent.id,
              slotName: slot['slot number'],
              vehicle: Vehicle.named(vehiclePlateNumber: slot['v_plate_no']),
              dateTimeStart: DateTime.tryParse(slot['Start Data & Time']),
              dateTimeEnd: DateTime.tryParse(slot['Stop Data & Time']),
              bookingId: int.tryParse(slot['id']),
            );
            listParkingSlot.add(parkingSlot);
          } catch (e) {
            print('error assigning parking slot $e');
          }
          //    print('api parkin slot is $parkingSlot');
        });
      }
    } catch (e) {
      print('Error Decoding Resereved Booking');
    }

    //   print("decoded body \t" + decodedBody.toString());

  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('List Parking Bookinfs $listParkingSlot');
  return listParkingSlot;
}

Future<bool> logVehicleIn(ParkingSlot parkingSlotSent) async {
/*http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=change_status_occupied&slot_b_id=67&p_slot_id=67&arrivel_time=2019-01-24 3:22:00&slot_b_status=3
*
* */

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "change_status_occupied",
    'p_slot_id': parkingSlotSent.id.toString(),
    'slot_b_id': parkingSlotSent.bookingId.toString(),
    'arrivel_time': DateTime.now().toString(),
    'slot_b_status': '3',
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    //   print("decoded body \t" + decodedBody.toString());

    /*
   * {
    "status": "success",
    "message": "Updated successfly in parking slots status"
}
   * */

    if (decodedBody['status'] == 'success') {
      showToast('Vehicle Checked In');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  return true;
}

Future<ParkingSlot> bookSlotAfterQuickReg(ParkingSlot parkingSlotSent) async {
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=agent_bookings&p_slot_id=21&booking_edt=2019-01-25 15:50:00&uid=17&user_vid=20
* */

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "agent_bookings",
    'p_slot_id': parkingSlotSent.id.toString(),
    'booking_edt': '${parkingSlotSent.dateTimeEnd.toString()}',
    'uid': '${parkingSlotSent.vehicle.userId}',
    'user_vid': '${parkingSlotSent.vehicle.userVehicleId}',
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Agent Book Slot \t" + decodedBody.toString());

      if (decodedBody['status'] == 'success') {
        parkingSlotSent.vehicle.boolModelModified = true;
        parkingSlotSent.bookingId = decodedBody['slot_b_id'];
      } else {
        parkingSlotSent.vehicle.boolModelModified = false;
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
/*
* {
    "status": "success",
    "message": "Updated successfly in parking slots status",
    "slot_b_id": 8,
    "uid": "1",
    "uname": "lakan",
    "user_vid": "5",
    "v_plate_no": "TN-20-ES-9012",
    "p_loc_id": "1",
    "p_lot_id": "1",
    "p_slot_id": "3",
    "booking_sdt": "0000-00-00 00:00:00",
    "booking_edt": "2019-01-25 14:46:00",
    "payment_status": "1",
    "slot_b_status": "3"
}
* */

  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('List Parking Bookinfs $parkingSlotSent');
  return parkingSlotSent;
}

Future<ParkingSlot> vacateSlot(
    ParkingSlot parkingSlotSent, String optionalComments) async {
  parkingSlotSent.vehicle.boolModelModified = false;

/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=change_status_vacated&slot_b_id=1&p_slot_id=28&depar_time=2019-01-25 18:22:00&slot_b_status=1* */

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "change_status_vacated",
    'p_slot_id': parkingSlotSent.id.toString(),
    'slot_b_id': '${parkingSlotSent.bookingId}',
    'depar_time': '${DateTime.now()}',
    'user_vid': '${parkingSlotSent.vehicle.userVehicleId}',
    'slot_b_status': '1',
    'slot_b_cmt': optionalComments
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Agent Book Slot \t" + decodedBody.toString());
/*
{
    "status": "success",
    "message": "Updated successfly in parking slots status",
    "string": "1023759622249372700"
}* */

      if (decodedBody['status'] == 'success') {
        parkingSlotSent.slotStatus = SlotStatus.vacant;

        parkingSlotSent.vehicle.boolModelModified = true;
      } else {
        parkingSlotSent.vehicle.boolModelModified = false;
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('List Parking Bookinfs $parkingSlotSent');
  return parkingSlotSent;
}

Future<bool> addNotes(int bId, String comments) async {
  bool success = false;
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=agent_p_note&slot_b_id=1&slot_b_cmt=testing */

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "agent_p_note",
    'slot_b_cmt': comments,
    'slot_b_id': '$bId',
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Add Pricate NMote \t" + decodedBody.toString());
/*
{
    "status": "success",
    "message": "Agent add private note for user"
}}* */

      if (decodedBody['status'] == 'success') {
        success = true;
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('Add note sucess $success');
  return success;
}

Future<bool> immobilizeVehicle(ParkingSlot parkingSlotSent, String comments) async {
  bool success = false;
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=change_status_immobilised&slot_b_id=2&slot_b_cmt=I aam immobilizing
*/

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "change_status_immobilised",
    'slot_b_cmt': comments,
    'slot_b_id': '${parkingSlotSent.bookingId}',
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Add Pricate NMote \t" + decodedBody.toString());
/*
{
    "status": "success",
    "message": "Updated successfly in parking slots status",
    "string": "1013761255560639900"
}
 */

      if (decodedBody['status'] == 'success') {
        success = true;
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('Add note sucess $success');
  return success;
}

Future<bool> makeInactiveCall(ParkingSlot parkingSlotSent, int status) async {
  bool success = false;
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=change_inactive&p_slot_id=144
*/

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "change_inactive",
    'p_slot_id': '${parkingSlotSent.id}',
    'pslot_av': '$status'
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Make Slot inactive \t" + decodedBody.toString());
/*
{
    "status": "success",
    "message": "Booking slot status changed "
}
 */

      if (decodedBody['status'] == 'success') {
        success = true;
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('Make Slot Inactive sucess? $success');
  return success;
}

Future<ParkingSlot> getSlotDetails(ParkingSlot parkingSlotSent) async {
/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=current_booking_v&p_slot_id=12* */

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "current_booking_v",
    'p_slot_id': parkingSlotSent.id.toString(),
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;

    /*
{
    "current_booking": [
        {
            "id": "19",
            "v_plate_no": "GH-25-GJ-771",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "slot id": "12",
            "slot number": "012",
            "Start Data & Time": "2019-01-25 15:34:00",
            "Stop Data & Time": "2019-01-25 16:34:00",
            "slot booking status": "3",
            "payment status": "1"
        }
    ]
}    * */
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Agent Book Slot \t" + decodedBody.toString());

      List listRaw = decodedBody['current_booking'];
      if (listRaw != null) {
        listRaw.forEach((booking) {
          print('booking $booking');
          DateTime dateStart = DateTime.tryParse(booking['Start Data & Time']);
          DateTime dateEnd = DateTime.tryParse(booking['Stop Data & Time']);
          print('DAte start $dateStart');
          print('DAte end $dateEnd');

          parkingSlotSent.lot = booking['Lot name'];
          parkingSlotSent.location = booking['location'];
          parkingSlotSent.bookingId = int.tryParse(booking['id']);
          parkingSlotSent.vehicle.vehiclePlateNumber = booking['v_plate_no'];
          parkingSlotSent.dateTimeStart = dateStart;
          parkingSlotSent.dateTimeEnd = dateEnd;
        });

        parkingSlotSent.vehicle.boolModelModified = true;
      } else {
        parkingSlotSent.vehicle.boolModelModified = false;
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('List Parking Bookinfs $parkingSlotSent');
  return parkingSlotSent;
}

Future<ParkingSlot> getImmobilizedSlotDetails(ParkingSlot parkingSlotSent) async {
  parkingSlotSent.vehicle.boolModelModified = false;

/*
http://3.16.206.234/gccparking/parkingapi/enforcement.php?action=current_booking_v&p_slot_id=12* */

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "current_booking_v",
    'p_slot_id': parkingSlotSent.id.toString(),
  });

  d(uri);
  http.Response httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('Http Body ${httpResponse.body}');
    var decodedBody;

    /*
{
    "current_booking": [
        {
            "id": "19",
            "user_vid": "74",
            "v_plate_no": "TN-08-G-77777",
            "location": "Anna Nagar ",
            "Lot name": "Lot-1 Thirumangalam  Metro",
            "slot id": "3",
            "slot number": "3",
            "Start Data & Time": "2019-01-26 16:12:20",
            "Stop Data & Time": "2019-01-26 17:11:00",
            "slot booking status": "4",
            "payment status": "1"
        },    * */ /** slot booking status will be 6 for immobilized */
    try {
      decodedBody = json.decode(httpResponse.body);
      print("decoded body Agent Book Slot \t" + decodedBody.toString());

      List listRaw = decodedBody['current_booking'];
      if (listRaw != null) {
        listRaw.forEach((booking) {
          if (booking['slot booking status'] == '6') {
            parkingSlotSent.bookingId = int.tryParse(booking['id']);
            parkingSlotSent.vehicle.userVehicleId = booking['user_vid'];
            parkingSlotSent.vehicle.boolModelModified = true;
          }
        });
      }
    } catch (e) {
      print('Error Decoding Book slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print('List Parking Bookinfs $parkingSlotSent');
  return parkingSlotSent;
}


Future<bool> createTempSlot(String locId, String lotId, int slotNumber) async {
  bool boolSlotCreated = false;

  slotNumber += 1;
  var uri = Uri.http(authority, unencodedPath, {
/*
* http://3.16.206.234/gccparking/parkingapi/parkingapi.php?action=booking_temp_slot&p_loc_id=1&p_lot_id=1&slot_num=1-024&latitude=5&longitude=4&disabled_type=Normal
* */
    "action": "booking_temp_slot",
    'p_loc_id': locId,
    'p_lot_id': lotId,
    'slot_num': '$lotId-${slotNumber.toString()}',
    'latitude': '23',
    'longitude': '32',
    'disabled_type': 'Normal'
  });
  d(uri);

  http.Response httpResponse = await http.post(uri);
/*
{status: success, message: your temparary slot created successfully! please wait for admin approval}
* */
  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    try {
      var decodedBody = json.decode(httpResponse.body);
      print("decoded body \t" + decodedBody.toString());

      if (decodedBody['status'] == 'success') {
        boolSlotCreated = true;
      }
    } catch (e) {
      print('Error decoding temp slot $e');
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print("bool $boolSlotCreated");
  return boolSlotCreated;
}

Future<List<ParkingSlot>> getVehicles(BuildContext context) async {
  List<ParkingSlot> listParkingSlots = new List();
  http: //3.16.206.234/gccparking/parkingapi/enforcement.php?action=vehiclesin
  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "vehiclesin",
  });

  d(uri);
  http.Response httpResponse = await http.post(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    print("decoded body \t" + decodedBody.toString());

    List listRaw = decodedBody["all_slots"];
    if (listRaw != null) {
      listRaw.forEach((parkingSlotTemp) {
        //   print("Row \t $slot and oo ${slot["Occupied slots"]}");
/*
* {
"all_slots": [
        {
            "slot_b_id": "22",
            "uname": "uue",
            "v_plate_no": "AP-08-EG-1038",
            "location": "Anna Nagar ",
            "Lot name": "lot-02",
            "p_slot_id": "112",
            "Start Date& Time": "2019-01-25 10:53:03",
            "Stop Date& Time": "2019-01-25 16:22:00",
            "Fee Amount": "0.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "3",
            "Penalty Amount": "0.00",
            "Due Amount": "0.00"
        },* */

        int intSlotStatus = int.tryParse(parkingSlotTemp['slot_b_id']);

        var uname = parkingSlotTemp['uname'];
        if (uname == null) {
          print('Uname CAme NULL FROM API');
          uname = '';
        }
        var plateNum = parkingSlotTemp['v_plate_no'];
        if (plateNum == null) {
          print('Plate Num Came NULL from API');
          plateNum = '';
        }
        SlotStatus slotStatus = getSlotStaus(intSlotStatus);
        ParkingSlot parkingSlot = ParkingSlot.named(
          bookingId: int.tryParse(parkingSlotTemp['slot_b_id']),
          location: parkingSlotTemp['location'],
          lot: parkingSlotTemp['Lot name'],
          id: int.parse(parkingSlotTemp['p_slot_id']),
          dateTimeStart: DateTime.tryParse(parkingSlotTemp['Start Date& Time']),
          dateTimeEnd: DateTime.tryParse(parkingSlotTemp['Stop Date& Time']),
          fee: parkingSlotTemp['Fee Amount'],
          fine: parkingSlotTemp['Fine Amount'],
          paymentStatus: parkingSlotTemp['Payment Status'],
          penalty: parkingSlotTemp['Penalty Amount'],
          due: parkingSlotTemp['Due Amount'],
          slotStatus: slotStatus,
          vehicle: Vehicle.named(
            userName: uname,
            vehiclePlateNumber: plateNum,
          ),
        );

        print("Parking Slot $parkingSlot");
        listParkingSlots.add(parkingSlot);
      });
    }
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

  print("list $listParkingSlots");
  return listParkingSlots;
}

SlotStatus getSlotStaus(int intSlotStatus) {
  if (intSlotStatus == 1 || intSlotStatus == 4) {
    return SlotStatus.vacant;
  } else if (intSlotStatus == 2) {
    return SlotStatus.reserved;
  } else if (intSlotStatus == 3) {
    return SlotStatus.reserved;
  } else if (intSlotStatus == 5) {
    return SlotStatus.inactive;
  } else if (intSlotStatus == 6) {
    return SlotStatus.immobilized;
  } else if (intSlotStatus == 7) {
    return SlotStatus.pending;
  }
}

Future<double> getTotalPayments(BuildContext context) async {
  double totalPayments = 0.0;

  var uri = Uri.http(authority, unencodedPath, {
    "action": "payments",
  });

  d(uri);
  http.Response httpResponse;
  try {
    httpResponse = await http.post(uri);

    if (httpResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody;
      try {
        decodedBody = json.decode(httpResponse.body);
      } catch (e) {
        print('Error Decoding Payments $e');
      }
      //  print("decoded body \t" + decodedBody.toString());

      List listRaw = decodedBody["all_paymets"];
      listRaw.forEach((row) {
        String amountInString = row["total_amount"];
        //    print("Row \t $row and oo $amountInString");
        totalPayments += double.tryParse(amountInString);
      });
    } else {
      showToast("Network Error - ${httpResponse.reasonPhrase}");
    }
  } catch (e) {
    print('error in http reposnse payments $e');
  }

  print("Count $totalPayments");
  return totalPayments;
}

Future<Vehicle> quickRegistration(Vehicle vehicleSent) async {
  bool isNewUser;
/*
  print(
      "\n User Name: $uname\n Mobile Number: $mobile \t vehicle num $vehicleNumber");
*/

  http.Response httpResponse;

  var uri = Uri.http(authority, unencodedEnforcementPath, {
    "action": "user_quick_reg",
    "user_type": "2",
    "uname": "${vehicleSent.userName}",
    "mobile": "${vehicleSent.mobile}",
  });
  try {
    httpResponse = await http.get(uri);
  } catch (e) {
    print("Please Check Network");
    print(e);
  }
  print(uri);

  print('stsus ${httpResponse.statusCode}');
  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody;
    try {
      decodedBody = json.decode(httpResponse.body);
    } catch (e) {
      print('Eerror Decoding $e');
    }
    print("decoded body \t" + decodedBody.toString());

    /*
      * {
    "status": "success",
    "message": "User Registered successfully please register vehicle number",
    "uid": 22,
    "uname": "Non Chennai User",
    "mobile": "888569777"
}
      * */
    if (decodedBody != null) {
      if (decodedBody["status"] == "success") {
        print('User Registration Success');

        vehicleSent.userId = decodedBody['uid'].toString();
        vehicleSent = await vehicleRegistration(vehicleSent);
      } else {
        vehicleSent.boolModelModified = false;
      }
    } else {
      print('Decdoded body vehicle reg is NULL');
    }
  } else {
    print("Network Error - ${httpResponse.reasonPhrase}");
  }

  return vehicleSent;
}

Future<Vehicle> vehicleRegistration(Vehicle vehicleSent) async {
  bool isVehicledAddedToUser;
  // print("Vehicle Number: $vehicleNumber\n uid $uid,");

  var uri = Uri.http(authority, unencodedPath, {
    "action": "user_vehicle_reg",
    'v_plate_no': '${vehicleSent.vehiclePlateNumber}',
    'vid': '1',
    'uid': '${vehicleSent.userId}',
    'user_type': '2',
    'vehicle_chk': '0',
  });

  d(uri);

  http.Response httpResponse;
  try {
    httpResponse = await http.get(uri);
  } catch (e) {
    print("Please Check Network");
    print(e);
  }

  print('stsus ${httpResponse.statusCode}');
  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody;
    try {
      print('Http Response \t ${httpResponse.body}');

      decodedBody = json.decode(httpResponse.body);
    } catch (e) {
      print('Error Decoding vehicle treg $e');
    }
    print("decoded body \t" + decodedBody.toString());

    /*
{"status":"success","message":"registration completed successfully","user_vid":34,"uid":"46","uname":"sdf","mobile":"5574488665","v_plate_no":"DD-66-SS-580","vid":"1","vname":"CAR","string":"1023759003167241700"}
      */

    if (decodedBody["status"] == "success") {
      isVehicledAddedToUser = true;
      vehicleSent.userVehicleId = decodedBody['user_vid'].toString();
      vehicleSent.boolModelModified = true;
      print('Vehicle Registration Success');
    } else {
      vehicleSent.boolModelModified = false;
      isVehicledAddedToUser = false;
      print('Vehicle Registration Faile');
    }
  } else {
    print("Network Error - ${httpResponse.reasonPhrase}");
  }

  return vehicleSent;
}

Future<List<CheckedVehiclesIn_Out>> getCheckedVehiclesIn() async {
  List<CheckedVehiclesIn_Out> listVehiclesIn = new List();

  var uri = Uri.http(authority, unencodedEnforcementPath, {"action": "vehiclesin"});

  http.Response httpResponse = await http.post(uri);

  if (httpResponse.statusCode == 200) {
    var decodedBody = json.decode(httpResponse.body);
    print('decoded body \t' + decodedBody.toString());

    if (decodedBody['status'] != null && decodedBody['status'] != 'fail') {
      print('Check in what happeininf');
    } else if (decodedBody['status'] == null) {
      List listRaw = decodedBody["all_slots"];

      listRaw.forEach((vehicle) {
        var checkedVehicle = CheckedVehiclesIn_Out.fromMap(vehicle);
        listVehiclesIn.add(checkedVehicle);
      });
    } else {
      print('Check decoded body vehicle in ${decodedBody.toString()}');
    }
  } else {
    print("Network Error - ${httpResponse.reasonPhrase}");
  }

  print("vehicle in list $listVehiclesIn");
  return listVehiclesIn;
}

Future<List<CheckedVehiclesIn_Out>> getCheckedVehiclesOut() async {
  List<CheckedVehiclesIn_Out> listVehiclesIn = new List();
  var uri =
      Uri.http(authority, unencodedEnforcementPath, {"action": "vehiclesout"});

  http.Response httpResponse = await http.post(uri);
  if (httpResponse.statusCode == 200) {
    var decodedBody = json.decode(httpResponse.body);
    print('decoded body \t' + decodedBody.toString());

    print('is null ${decodedBody['status']}');
    if (decodedBody['status'] != null && decodedBody['status'] != 'fail') {
      print('CheCk What?');
    } else if (decodedBody['status'] == null) {
      List listRaw = decodedBody["all_slots"];

      listRaw.forEach((vehicle) {
        /*"all_slots": [
        {
            "slot_b_id": "2",
            "uname": "lakan",
            "v_plate_no": "AP-09-AP-0123",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "slot number": "001",
            "Start Date& Time": "2019-01-24 05:00:00",
            "Stop Date& Time": "2019-01-24 06:37:00",
            "Fee Amount": "50.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "4",
            "Penalty Amount": "0.00",
            "Due Amount": "0.00"
        }
    ]*/
        var checkedVehicle = CheckedVehiclesIn_Out.fromMap(vehicle);
        listVehiclesIn.add(checkedVehicle);
      });
    } else {
      print('Check decoded body vehicle OUT ${decodedBody.toString()}');
    }
  } else {
    print("Network Error - ${httpResponse.reasonPhrase}");
  }

  print("vehicle in list $listVehiclesIn");
  return listVehiclesIn;
}
