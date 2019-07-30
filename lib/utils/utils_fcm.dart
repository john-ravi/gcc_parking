import 'package:flutter/material.dart';
import 'package:gcc_parking/enforcement.dart';
import 'package:gcc_parking/models/model_alert.dart';

Future onFCMLaunch(Map<String, dynamic> message) {
  print('printing onLaunch $message');
}

Future onFCMMessage(BuildContext context, Map<String, dynamic> mapMessage) {
  print('printing on Message $mapMessage');

  print('Alerts List Sizt ${listAlerts.length}');
  listAlerts.add(ModelAlert(mapMessage));
  print('Alerts List Sizt ${listAlerts.length}');

  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text('Booking Request For Slot 101'),
    actions: <Widget>[

      FlatButton(
        child: Text('Ok'),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
    ],
  ));
}

Future onFCMResume(Map<String, dynamic> message) {
  print('printing on FCM Resume $message');
}
