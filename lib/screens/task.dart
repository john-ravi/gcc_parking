import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user.dart';
import 'alerts.dart';
import 'registration.dart';

class Task extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'ADMIN LOGIN',
        home: new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
              Icon(FontAwesomeIcons.envelope),
              Icon(FontAwesomeIcons.bell),
            ],

            //title: Text(widget.title),
          ),
          body:
          Row(
              children : <Widget>[
          new Expanded(child: new Container(decoration: const BoxDecoration(color: Colors.blueGrey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.users,color: Colors.white,size: 40.0),onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>User()));
              },
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.productHunt,color: Colors.white,size: 40.0),onPressed: (){
/*
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>Parking1()));
*/
              },
              ),
              Icon(FontAwesomeIcons.listUl,color: Colors.white,size: 40.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),

              IconButton(
                icon: Icon(FontAwesomeIcons.registered,color: Colors.white,size: 40.0),onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) =>Registration()));
              },
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.exclamationTriangle,color: Colors.white,size: 40.0),onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) =>Alert()));
              },
              ),
          ],

          ),)),


          Column(
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(6.0),
                 child: Row(
                   children: <Widget>[
                     new Container(
                       color: Colors.cyan,
                       child: new Center(
                         child: Padding(
                           padding: const EdgeInsets.all(6.0),
                           child: new Text(
                             "Vehicles Checked",
                             style: TextStyle(color: Colors.white,fontSize: 15.0),
                           ),
                         ),
                       ),
                     ),
                     new Container(
                       color: Colors.grey,
                       child: new Center(
                         child: Padding(
                           padding: const EdgeInsets.all(6.0),
                           child: new Text(
                             "Vehicles immobilised",
                             style: TextStyle(color: Colors.white,fontSize: 15.0),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),

               Text('Select Parked vehicles',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
               new DropdownButton<String>(
              //isDense: true,
              value: '                                                            ',
              items: <DropdownMenuItem<String>>[
                new DropdownMenuItem(
                    child: new Container(
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Text('                                                            ')
                        ],
                      ),
                    ),
                    value: '                                                            '),

              ],
              onChanged: null),
               Padding(
             padding: const EdgeInsets.all(10.0),
             child: Row(
               children: <Widget>[
                 Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text('TS01CH2018',style: TextStyle(color: Colors.black,fontSize: 23.0),textAlign: TextAlign.start,),
                     Text('Parked st Area 1',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),

                   ],
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: <Widget>[
                     RaisedButton(
                       color: Colors.grey,
                       onPressed: (){},
                       child: Text('Un Checked',style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.end,),
                     ),

                   ],
                 )
               ],
             ),
           ),

            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('TS01CH2019',style: TextStyle(color: Colors.black,fontSize: 23.0),textAlign: TextAlign.start,),
                    Text('Parked st Area 2',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    RaisedButton(
                      color: Colors.blueGrey,
                      onPressed: (){},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Checked  ',style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.end,),

                      ),
                    ),



                  ],
                )
              ],
            ),
           Row(
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Text('TS01CH2020',style: TextStyle(color: Colors.black,fontSize: 23.0),textAlign: TextAlign.start,),
                   Text('Parked st Area 3',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),
                   Padding(
                     padding: EdgeInsets.all(8.0),
                   ),
                 ],
               ),
               Column(
                 children: <Widget>[
                   RaisedButton(
                     color: Colors.blueGrey,
                     onPressed: (){},
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Checked  ',style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.end,),

                     ),
                   ),


                 ],
               )
             ],
           ),
           Row(
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Text('TS01CH2021',style: TextStyle(color: Colors.black,fontSize: 23.0),textAlign: TextAlign.start,),
                   Text('Parked st Area 1',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),
                   Padding(
                     padding: EdgeInsets.all(8.0),
                   ),
                 ],
               ),
               Column(
                 children: <Widget>[
                   RaisedButton(
                     color: Colors.blueGrey,
                     onPressed: (){},
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Checked  ',style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.end,),

                     ),
                   ),

                 ],
               )
             ],
           ),
           Row(
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Text('TS01CH2022',style: TextStyle(color: Colors.black,fontSize: 23.0),textAlign: TextAlign.start,),
                   Text('Parked st Area 2',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),
                   Padding(
                     padding: EdgeInsets.all(8.0),
                   ),
                 ],
               ),
               Column(
                 children: <Widget>[
                   RaisedButton(
                     color: Colors.blueGrey,
                     onPressed: (){},
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Checked  ',style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.end,),

                     ),
                   ),

                 ],
               )
             ],
           ),
           Row(
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Text('TS01CH2023',style: TextStyle(color: Colors.black,fontSize: 23.0),textAlign: TextAlign.start,),
                   Text('Parked st Area 3',style: TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),
                   Padding(
                     padding: EdgeInsets.all(8.0),
                   ),
                 ],
               ),
               Column(
                 children: <Widget>[
                   RaisedButton(
                     color: Colors.blueGrey,
                     onPressed: (){},
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Checked  ',style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.end,),

                     ),
                   ),

                 ],
               )
             ],
           ),


             ],
           ),
         ]),
             ),



    );
  }
}