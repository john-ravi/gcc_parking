import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


OverlayEntry loaderentry;


showloader(BuildContext context) {
  OverlayState loaderstate = Overlay.of(context);
  loaderentry = OverlayEntry(
      builder: (context) => Center(
        child: Container(
/*
          padding: EdgeInsets.all(8.0),
          width: 50.0,
          height: 50.0,
          color: Colors.black45,
*/
          child: CircularProgressIndicator(
            backgroundColor: Colors.amberAccent,
          ),
        ),
      ));
  loaderstate.insert(loaderentry);
}

removeloader() {
  loaderentry.remove();
}

d(var debugvalue) {
  print("$debugvalue");
}

s(BuildContext context, String value) {
  try {
    Scaffold.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 5),
        content: new Text(
          value,
          style: TextStyle(fontFamily: 'Georgia'),
        )));
  } on Exception catch (e) {
    print("printing Exception $e");
  }
}

showToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      textcolor: '#ffffff'
  );
}
