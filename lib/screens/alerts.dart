import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'alert.dart';
import 'user.dart';
import 'registration.dart';
import 'task.dart';

class Alert extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,

          actions: <Widget>[
           // Icon(FontAwesomeIcons.bars,size: 23.0,),
            Icon(FontAwesomeIcons.envelope),
            Icon(FontAwesomeIcons.bell),
          ],

          //title: Text(widget.title),
        ),

        drawer: Drawer(
          child:Container(
            color: Colors.blueGrey,

            child: ListView(
                children: <Widget>[
                  //new Expanded(child: new Container(decoration: const BoxDecoration(color: Colors.blue)),),
                  DrawerHeader(child: Icon(FontAwesomeIcons.bars, size: 30.0,color: Colors.white,),decoration: BoxDecoration(color: Colors.blueGrey)),
                  //Icon(FontAwesomeIcons.search,size: 20.0,),

                  new ListTile(
                    title: Text('User Management',
                      style: TextStyle(color: Colors.white),),

                    leading: new Icon(FontAwesomeIcons.users,color: Colors.white,size: 40.0,),
                    onTap:  () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.push(context, new MaterialPageRoute
                        (builder: (context) => new User()));
                    },
                  ),
                  new ListTile(
                    title: Text('Parking lot Management',
                      style: TextStyle(color: Colors.white),),
                    leading: new Icon(FontAwesomeIcons.productHunt,color: Colors.white,size: 40.0,),
                    onTap:  () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
/*
                      Navigator.push(context, new MaterialPageRoute
                        (builder: (context) => new Parking1()));
*/
                    },
                  ),
                  new ListTile(
                    title: Text('Task and Activity',style: TextStyle(color: Colors.white),),
                    leading: new Icon(FontAwesomeIcons.listUl,color: Colors.white,size: 40.0,),
                    onTap:  () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.push(context, new MaterialPageRoute
                        (builder: (context) => new Task()));
                    },
                  ),
                  new ListTile(
                    title: Text('Quick Registration',style: TextStyle(color: Colors.white),),
                    leading: new Icon(FontAwesomeIcons.registered,color: Colors.white,size: 40.0,),
                    onTap:  () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.push(context, new MaterialPageRoute
                        (builder: (context) => new Registration()));
                    },
                  ),
                  new ListTile(
                    title: Text('Alerts',style: TextStyle(color: Colors.white),),
                    leading: new Icon(FontAwesomeIcons.exclamationTriangle,color: Colors.white,size: 40.0,),
                    onTap:  () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.push(context, new MaterialPageRoute
                        (builder: (context) => new Alert()));
                    },
                  ),
                ]
            ),

          ),

        ),


        body: Row(
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
                 IconButton(
                   icon: Icon(FontAwesomeIcons.listUl,color: Colors.white,size: 40.0),onPressed: (){
                   Navigator.push(context,
                       MaterialPageRoute(
                           builder: (context) =>Task()));
                 },
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                        children: <Widget>[

                          new Container(
                            color: Colors.blueGrey,

                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('TS01CH2018',style: new TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.w600,fontSize: 25.0),),
                            ),
                          ),//Icon(FontAwesomeIcons.),
                          // TODO: implement build
                          //  Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          // children: <Widget>[

                          RaisedButton(
                            color: Colors.cyan,
                            child: Text('View Details',style: new TextStyle(color: Colors.white,fontSize: 17.0,
                              fontWeight: FontWeight.w600,)),
                            textColor: Colors.white,colorBrightness: Brightness.dark,
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => User()));
                            },
                          ),
                        ]),
                  ),
                  Row(
                      children: <Widget>[

                        new Container(
                          color: Colors.blueGrey,

                          child:Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('TS01CH2019',style: new TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w600,fontSize: 25.0),),
                          ),
                        ),//Icon(FontAwesomeIcons.),
                        // TODO: implement build
                        //  Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // children: <Widget>[
                        RaisedButton(
                          color: Colors.cyan,
                          child: Text('View Details',style: new TextStyle(color: Colors.white,fontSize: 17.0,
                            fontWeight: FontWeight.w600,)),
                          textColor: Colors.white,colorBrightness: Brightness.dark,
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => User()));
                          },
                        ),
                      ]),
                  Row(

                      children: <Widget>[

                        new Container(
    color: Colors.blueGrey,

                       child:Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Text('TS01CH2020',style: new TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w600,fontSize: 25.0),),
                       ),
                        ),//Icon(FontAwesomeIcons.),
                        // TODO: implement build
                        //  Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // children: <Widget>[
                        RaisedButton(
                          color: Colors.cyan,
                          child: Text('View Details',style: new TextStyle(color: Colors.white,fontSize: 17.0,
                            fontWeight: FontWeight.w600,)),
                          textColor: Colors.white,colorBrightness: Brightness.dark,
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => User()));
                          },
    ),

                        ])
                      ]),
                ]),


        ),

    );
  }

}
