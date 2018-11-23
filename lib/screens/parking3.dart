import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Parking3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: new Scaffold(

       body:
       Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(50.0),
             child: Text('Select parking area',style: TextStyle(color: Colors.black,fontSize: 25.0)),

),
           new DropdownButton<String>(
             //isDense: true,
               value: '                                               ',
               items: <DropdownMenuItem<String>>[
                 new DropdownMenuItem(
                     child: new Container(
                       child: new Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           new Text('                                               '),
                         ],
                       ),
                     ),
                     value: '                                               '),

               ],
               onChanged: null),
           RaisedButton(
             color: Colors.blue,
             child: Text('Send Request to Admin',style: TextStyle(color: Colors.white,fontSize: 20.0),),
             onPressed:(){
               //Navigator.push(context,
               //    MaterialPageRoute(
                 //  builder: (context) =>Parking4()));





             }
           ),
           Text('Your slot becomes active once approved by admin',style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.center,),


      ] ,),

           ),





      );
  }
}

