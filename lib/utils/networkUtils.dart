import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:http/http.dart' as http;

import 'package:gcc_parking/utils/visualUtils.dart';

String authority = "18.191.190.195";
String unencodedPath = "/gccparking/parkingapi/parkingapi.php";

Future<bool> validateAndLogin(
    String agent_email, String agent_pwd, BuildContext context) async {
/*action=agent_login&agent_email=test@gmail.com&agent_pwd=456123*/
  var uri = Uri.http(authority, unencodedPath, {
    "action": "agent_login",
    "agent_email": agent_email,
    "agent_pwd": agent_pwd
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

    Future.delayed(Duration(milliseconds: 700),
        () => validateAndLogin(agent_email, agent_pwd, context));
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
  int countVehicles = 0;
  var uri = Uri.http(authority, unencodedPath, {
    "action": "occupied_slots",
  });

//  d(uri);
  http.Response httpResponse = await http.post(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
//   print("decoded body \t" + decodedBody.toString());

    List listRaw = decodedBody["all_slots"];
    listRaw.forEach((slot) {
      //   print("Row \t $slot and oo ${slot["Occupied slots"]}");
      if (slot["occupied_slots"] == "1") {
        countVehicles++;
      }
    });
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

//  print("Count $countVehicles");
  return countVehicles;
}

Future<List<Vehicle>> getVehicles(BuildContext context) async {
  List<Vehicle> listVehicles = new List();
  var uri = Uri.http(authority, unencodedPath, {
    "action": "user_details",
  });

//  d(uri);
  http.Response httpResponse = await http.post(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
    print("decoded body \t" + decodedBody.toString());

    List listRaw = decodedBody["all_users"];

    /*
    * "Vehicle Plate Number": "TN-09-PN-0000",
            "Vehicle Type": "bus",
            "User Id": "1",
            "Start Time": "02:00:00",
            "End Time": "00:30:00",
            "Parking Slot": "slot2",
            "Applicable Fee": "20",
            "Payement Status": "1",
            "Applicable Fine": "20",
            "Penalty": "10",
            "Due": "30",
            "Profile": "http://18.191.190.195/gccparking/admin/"
             "Black List": "0"
    * */
    listRaw.forEach((vehicle) {
      //   print("Row \t $slot and oo ${slot["Occupied slots"]}");

      listVehicles.add(Vehicle.fromMap(vehicle));
    });
  } else {
    showToast("Network Error - ${httpResponse.reasonPhrase}");
  }

//  print("Count $countVehicles");
  return listVehicles;
}

Future<double> getTotalPayments(BuildContext context) async {
  double totalPayments = 0.0;
  var uri = Uri.http(authority, unencodedPath, {
    "action": "payments",
  });

  // d(uri);
  http.Response httpResponse = await http.post(uri);

  if (httpResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(httpResponse.body);
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

  print("Count $totalPayments");
  return totalPayments;
}

Future<bool> updateVehicleBlacklistStatus(
    String vehicleNumber, String uid, bool blacklisted) async {
  vehicleNumber = vehicleNumber.substring(0, 2) +
      "-" +
      vehicleNumber.substring(2, 4) +
      "-" +
      vehicleNumber.substring(4, 6) +
      "-" +
      vehicleNumber.substring(6);

  print("Vehicle no $vehicleNumber");

  var uri = Uri.http(authority, unencodedPath, {
    "action": "user_bstatus",
    "v_plate_no": vehicleNumber,
    "uid": uid,
    "black_list": blacklisted ? "1" : "0",
  });

  /*
  * http://18.191.190.195/gccparking/parkingapi/parkingapi.php?action=user_bstatus&v_plate_no=TN-09-PN-0000&uid=1&black_list=0
  * */

  http.Response httpResponse;
  try {
    httpResponse = await http.post(uri);

    d(uri);

    if (httpResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(httpResponse.body);
      print("decoded body \t" + decodedBody.toString());

      //    "status": "success",
      if (decodedBody["status"] == "success") {
        showToast(
            "$vehicleNumber is ${blacklisted ? "Blacklisted" : "Not Blacklisted"}");
      } else {
        print("Invalid Vehicle Detaiuls");
      }
    } else {
      showToast("Network Error - ${httpResponse.reasonPhrase}");
    }
  } catch (e) {
    showToast("Please Check Network");
    print(e);
  }

  return null;
}

// Multiple Rows
/**
 *
 * Future<List<Bills>> getBills() async {
    List<Bills> bills = new List();

    var uri = Uri.http(authority, unencodedPath, {
    "page": "getBills",
    });

    d(uri);
    http.Response registerUserResponse = await http.get(uri);

    if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {

    print("decoded body \t" + decodedBody.toString());
    List billsDecoded = decodedBody["body"];

    print("List \t" + bills.toString());

    billsDecoded.forEach((rowCustomerObject) {
    print("ROW \t" + rowCustomerObject.toString());

    Map billsMap = rowCustomerObject;

    print("CustomerMap  ${billsMap.toString()}");
    /*
 *
    Full texts
    invoice_number
    amount
    status
    customer_name
 * */

    bills.add(Bills(billsMap["invoice_number"], billsMap["amount"],
    billsMap["status"], billsMap["customer_name"]));

    print("List as Whiole \t" + bills.toString());
    });

    //    return Post.fromJson(json.decode(response.body));
    } else {
    print("Couldn't fetch rows, please check");
    }
    } else {
    print("Error Fetching States, Check Network: In Utility");
    }

    return bills;
    }

 *
 * */
