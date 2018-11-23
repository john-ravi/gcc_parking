import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'registration.dart';
import 'task.dart';
import 'alerts.dart';
//import 'dashboardmenu.dart';

class User extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'ADMIN LOGIN',
        home: new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
             // Icon(FontAwesomeIcons.bars,size: 23.0),
              Icon(FontAwesomeIcons.search),
              //TextField(decoration: InputDecoration(labelText: 'SEARCH'),),
              Icon(FontAwesomeIcons.envelope),
              Icon(FontAwesomeIcons.bell),
           ],
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(FontAwesomeIcons.users,color: Colors.white,size: 40.0),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.productHunt,color: Colors.white,size: 40.0),onPressed: (){
/*
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>Parking1()));
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

          Padding(
                padding: const EdgeInsets.all(10.0),
              ),
            ],

          ),)),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[


                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Plate # TS 01 CH 2019',style:new TextStyle(color: Colors.black,fontSize: 26.0),textAlign: TextAlign.center,),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                             Text('                                  '),

                            ],
                          ),

                          Column(
                            children: <Widget>[


                          Text('this user in black list',style:new TextStyle(
                          color: Colors.red,fontSize: 13.0,fontWeight: FontWeight.w900),textAlign: TextAlign.end,),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[



                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Vehicle license plate number:',style: new TextStyle(
                            color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                             Vehicle type:',style: new TextStyle(
                            color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                                     User Id:',style: new TextStyle(
                            color: Colors.black,fontSize: 15.0),textAlign: TextAlign.center,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                                 Start time:',style: new TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                                   End time:',style: new TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                             Parking slot:',style: new TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                        Applicable fees:',style: new TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                      Text('                        Payment status:',style: new TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('                       Applicable fines:',style: new TextStyle(color: Colors.black,fontSize: 15.0),textAlign: TextAlign.start,),
                      ),
                            ],
                          ),

                          Column(
                            children: <Widget>[
                              Text('                        '),
                            ],
                          )
                        ],
                      ),


                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("            Due's",style: new TextStyle(color: Colors.black,fontSize: 30.0,),),
                              ),

                            ],

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Container(
                                    color: Colors.grey,
                                    child: new Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: new Text(
                                          "0            ",
                                          style: TextStyle(color: Colors.white,fontSize: 15.0)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Text("Send Reminder",style: new TextStyle(color: Colors.black,fontSize: 10.0,fontWeight: FontWeight.w600),),

                            ],

                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("no dues",style: new TextStyle(color: Colors.black,fontSize: 10.0,),),
                              )
                            ],

                          ),

                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("      Penaltie",style: new TextStyle(color: Colors.black,fontSize: 30.0,),),
                              )
                            ],

                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Container(
                                color: Colors.grey,
                                child: new Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: new Text(
                                      "0            ",
                                      style: TextStyle(color: Colors.white,fontSize: 15.0),
                                    ),
                                  ),
                                ),
                              ),
                                ],
                              )


                         ] ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("Charge",style: new TextStyle(color: Colors.black,fontSize: 10.0,),),
                              )
                            ],

                          ),

                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("Blacklist",style: new TextStyle(color: Colors.black,
                                    fontSize: 30.0),),
                              )
                            ],

                          ),
                          Column(
                          children: <Widget>[
    Padding(
    padding: const EdgeInsets.all(6.0),
    child: Row(
    children: <Widget>[
    new Container(
    color: Colors.blueGrey,
    child: new Center(
    child: Padding(
    padding: const EdgeInsets.all(6.0),
    child: new Text(
    "No",
    style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600),
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
    "Yes",
    style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600),
    ),
    ),
    ),
    ),
    ],
    ),
    ),


    ])


                    ]),
    ])
        ]),

        ),
                    );






  }
}
