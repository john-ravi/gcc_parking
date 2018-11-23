import 'package:flutter/material.dart';

class Parking4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: new Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text('Select slot A101200',style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Occupied status :',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.center,),
                ),
            Column(
              children: <Widget>[
                Text(' Occupied',style: TextStyle(color: Colors.cyan,fontSize: 20.0),textAlign: TextAlign.center,),
              ],
            ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Occupied Details',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w700),textAlign: TextAlign.center,)
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Vehicle #               :',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.start,),
                ),
                Text('TS012989',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.end,),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Vehicles Type       :',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.start,),
                ),
                Text('Four Wheeler(XUV)',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.end,),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Area Occupied      :',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.start,),
                ),
                Text('24X24',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.end,),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Pending Dues        :',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.start,),
                ),
                Text('0',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.end,),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Parking Cost          :',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.start,),
                ),
                Text('20 RS per day',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.end,),
              ],
            ),
            Row(
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Report vehicle for violation',style: TextStyle(color: Colors.cyan,fontSize: 20.0),textAlign: TextAlign.center,),
                ),
               ] ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Change parking slot status:',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w600)),

          ),

            new DropdownButton<String>(
              //isDense: true,
                value: 'Status                                               ',
                items: <DropdownMenuItem<String>>[
                  new DropdownMenuItem(
                      child: new Container(
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Text('Status                                               '),
                          ],
                        ),
                      ),
                      value: 'Status                                               '),

                ],
                onChanged: null),

              ],
            ),


       ] ),





    ),
    );
  }
}
