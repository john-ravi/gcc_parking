import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_parking/models/model_alert.dart';
import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/screens/dashboard.dart';
import 'package:gcc_parking/widgets/login_enforcement.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';
import 'utils/visualUtils.dart';
import 'utils/networkUtils.dart';
import 'utils/appConstants.dart';


List<ModelAlert> listAlerts = [];

void main() => runWhat();

void runWhat() async {
  await isAgentInPrefs().then((modelAgent) {
    if (modelAgent.boolModelUpdated) {
      runApp(MaterialApp(
          home: Dashboard(modelAgent),
      ));
    } else {
      runApp(LoginEnforcement());
    }
  });
}

Future<ModelAgent> isAgentInPrefs() async {
  SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();

  ModelAgent modelAgent = ModelAgent.named(boolModelUpdated: false);
  if (prefs.getBool(LOGGED_IN) ?? false) {
    var i = prefs.getInt(USER_ID);
    if (prefs.getString(CURRENT_USER) != null && i != null) {
      modelAgent = ModelAgent.named(id: i, boolModelUpdated: true);
    }
  }

  if(!modelAgent.boolModelUpdated) {
    prefs.setBool(LOGGED_IN, null);
    prefs.setString(CURRENT_USER, null);
    prefs.setInt(USER_ID, null);
  }

  print(prefs.getBool(LOGGED_IN) ?? false);
  print(prefs.getString(CURRENT_USER));
  print(prefs.getInt(USER_ID));

  return modelAgent;
}

