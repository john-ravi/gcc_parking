import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/enforcement.dart';
import 'package:gcc_parking/screens/alerts.dart';
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


Container buildContainerAlert(BuildContext context) {
  return Container(
    //          color: Colors.orange,
    child: Stack(children: <Widget>[
      Center(child: Container(
        //      color: Colors.red,
        child: IconButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>
              Alert()));},
          icon: Icon
            (FontAwesomeIcons.bell, color: Colors.redAccent,),
        ),
      )),
      new Positioned(
        bottom: 15.0,
        right: 10.0,
        child: new Center(
          child: new Text(
            '${listAlerts.length}',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 17.5,
                fontWeight: FontWeight.w900
            ),
          ),
        ),

      ),
    ]),
  );
}
