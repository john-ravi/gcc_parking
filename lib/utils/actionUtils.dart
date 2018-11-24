

import 'package:flutter/material.dart';
import 'package:gcc_parking/enforcement.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logout(BuildContext context) async {
  showloader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(LOGGED_IN);
  prefs.remove(CURRENT_USER);

  print(prefs.getBool(LOGGED_IN) ?? false);
  print(prefs.getString(CURRENT_USER));

  removeloader();
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => new Enforcement()));
}
