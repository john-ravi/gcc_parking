import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/enforcement.dart';
import 'package:gcc_parking/screens/parking_lot_management.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'user_management.dart';
import 'task_and_activity.dart';

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: Builder(
        builder: (context) => new Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: Text('Alerts'),
              ),
              drawer: buildDrawer(context),
              body: Row(mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                new Container(
                  decoration: const BoxDecoration(color: Colors.blueGrey),
                  child: buildQuickNavColumn(context),
                ),
                Flexible(
                  child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                            title: Text(listAlerts[index].mapMessage['notification']['title']),
                            subtitle: Text(listAlerts[index].mapMessage['notification']['body']),

                          ), itemCount: listAlerts.length,),
                ),
              ]),
            ),
      ),
    );
  }

  Column buildQuickNavColumn(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,

      children: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesomeIcons.users,
            color: Colors.white,
            size: DRAWER_ICON_SIZE,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserManagement()));
          },
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.productHunt,
            color: Colors.white,
            size: DRAWER_ICON_SIZE,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ParkingLotManagement()));
          },
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.listUl,
            color: Colors.white,
            size: DRAWER_ICON_SIZE,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Task()));
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.exclamationTriangle,
              color: selectionIconColor, size: DRAWER_ICON_SIZE),
          onPressed: () {
            //  Navigator.push(context,
            //   MaterialPageRoute(builder: (context) => (Alert())));
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white, size: DRAWER_ICON_SIZE),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: Container(
                      height: 100.0,
                      width: 150.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Do you really want to Log out',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                RaisedButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    logout(context);
                                  },
                                  color: Colors.green,
                                ),
                                RaisedButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.red,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )));
            //logout(context);
          },
        ),
      ],
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
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
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => new UserManagement()));
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
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ParkingLotManagement()));
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
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new Task()));
            },
          ),
          new ListTile(
            title: Text(
              'Alerts',
              style: TextStyle(color: selectionIconColor),
            ),
            leading: new Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: selectionIconColor,
              size: 30.0,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.push(context,
              //   new MaterialPageRoute(builder: (context) => new Alert()));
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
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          content: Container(
                        height: 100.0,
                        width: 150.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Do you really want to Log out',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      logout(context);
                                    },
                                    color: Colors.green,
                                  ),
                                  RaisedButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )));
              // logout(context);
            },
          ),
        ]),
      ),
    );
  }
}
