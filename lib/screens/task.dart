import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'user.dart';
import 'alerts.dart';
import 'registration.dart';

class Task extends StatefulWidget {
  @override
  TaskState createState() {
    return new TaskState();
  }
}

class TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            Icon(FontAwesomeIcons.envelope),
            Padding(
              padding: EdgeInsets.only(right: 24.0),
            ),
            Icon(FontAwesomeIcons.bell),
            Padding(
              padding: EdgeInsets.only(right: 24.0),
            ),
          ],

          //title: Text(widget.title),
        ),
        body: buildRow(context),
        drawer: Drawer(
          child: Container(
            color: Colors.blueGrey,
            child: ListView(children: <Widget>[
              DrawerHeader(
                  child: Icon(
                    FontAwesomeIcons.bars,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(color: Colors.blueGrey)),
              //Icon(FontAwesomeIcons.search,size: 20.0,),

              new ListTile(
                title: Text(
                  'User Management',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new User()));
                },
              ),
              new ListTile(
                title: Text(
                  'Parking lot Management',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.productHunt,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
/*
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Parking1()));
*/
                },
              ),
              new ListTile(
                title: Text(
                  'Task and Activity',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.listUl,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Task()));
                },
              ),
              new ListTile(
                title: Text(
                  'Quick Registration',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.registered,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Registration()));
                },
              ),
              new ListTile(
                title: Text(
                  'Alerts',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Alert()));
                },
              ),
              new ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  logout(context);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Row buildRow(BuildContext context) {
    return Row(children: <Widget>[
      new Container(
        decoration: const BoxDecoration(color: Colors.blueGrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                  size: DRAWER_ICON_SIZE,
                ),
                onPressed: () {},
              ),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.productHunt,
                  color: Colors.white, size: DRAWER_ICON_SIZE),
              onPressed: () {
/*
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Parking1()));
*/
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.listUl,
                color: selectionIconColor,
                size: DRAWER_ICON_SIZE * 1.16,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Task()));
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.registered,
                color: Colors.white,
                size: DRAWER_ICON_SIZE,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registration()));
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.exclamationTriangle,
                  color: Colors.white, size: DRAWER_ICON_SIZE),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => (Alert())));
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt,
                  color: Colors.white, size: DRAWER_ICON_SIZE),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
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
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
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
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Select Parked vehicles',
            style: TextStyle(color: Colors.black, fontSize: 15.0),
            textAlign: TextAlign.start,
          ),
          new DropdownButton<String>(
              //isDense: true,
              value:
                  '                                                            ',
              items: <DropdownMenuItem<String>>[
                new DropdownMenuItem(
                    child: new Container(
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Text(
                              '                                                            ')
                        ],
                      ),
                    ),
                    value:
                        '                                                            '),
              ],
              onChanged: null),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TS01CH2018',
                      style: TextStyle(color: Colors.black, fontSize: 23.0),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Parked st Area 1',
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.grey,
                      onPressed: () {},
                      child: Text(
                        'Un Checked',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      ),
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
                  Text(
                    'TS01CH2019',
                    style: TextStyle(color: Colors.black, fontSize: 23.0),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Parked st Area 2',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
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
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checked  ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      ),
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
                  Text(
                    'TS01CH2020',
                    style: TextStyle(color: Colors.black, fontSize: 23.0),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Parked st Area 3',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checked  ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      ),
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
                  Text(
                    'TS01CH2021',
                    style: TextStyle(color: Colors.black, fontSize: 23.0),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Parked st Area 1',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checked  ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      ),
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
                  Text(
                    'TS01CH2022',
                    style: TextStyle(color: Colors.black, fontSize: 23.0),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Parked st Area 2',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checked  ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      ),
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
                  Text(
                    'TS01CH2023',
                    style: TextStyle(color: Colors.black, fontSize: 23.0),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Parked st Area 3',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checked  ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ]);
  }
}
