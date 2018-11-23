import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user.dart';
import 'alerts.dart';

class Task1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: new Scaffold(

    body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
         //crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('Vehical number   :',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
           ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Booking time       :',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Duration               :',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Charge                 :',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Expiry                   :',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
        ),
        ],
      ),
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('TS01CH2018',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('10:40 AM - 09-10-2018',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('10 hr',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('20 per hour',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('10:40 AM - 10-10-2018',style: TextStyle(color: Colors.black,fontSize: 13.0,),),
      ),
      RaisedButton(
        child: Text('Confirm and send sms',style: TextStyle(color: Colors.black,fontSize: 13.0),),
        onPressed: (){},

      ),
      ]),
      ]),

    )
    ),
    );
  }
}
