import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/screens/user.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'registration.dart';
import 'task.dart';
import 'alerts.dart';

class ParkingLotManagement extends StatefulWidget {
  @override
  _ParkingLotManagementState createState() => _ParkingLotManagementState();
}

class _ParkingLotManagementState extends State<ParkingLotManagement> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AGENT LOGIN',
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
        ),

        drawer: buildDrawer(context),
        //Icon(FontAwesomeIcons.search,size: 20.0,),

        body: buildDescriptionRow(context),
      ),
    );
  }

  Widget buildDescriptionRow(BuildContext context) {
    return ListView(
      shrinkWrap: false,

      children: <Widget>[
        Row(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(color: Colors.orangeAccent,
                child: Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: new Container(
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: buildQuickNavColumn(context),
                  ),
                ),
              ),
              buildParkingDetailsColumn()
            ]),
      ],
    );
  }

  Column buildQuickNavColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.users,
                    color: Colors.white,
                    size: DRAWER_ICON_SIZE,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => User()));
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.productHunt,
                    color: selectionIconColor,
                    size: DRAWER_ICON_SIZE * 1.16,
                  ),
                  onPressed: () {
/*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Parking1()));
*/
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.listUl,
                    color: Colors.white,
                    size: DRAWER_ICON_SIZE,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Task()));
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.registered,
                      color: Colors.white, size: DRAWER_ICON_SIZE),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration()));
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
    );
  }

  Widget buildParkingDetailsColumn() {
    return Container(height: 900.0, width: 300.0, color: Colors.black, child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            items: dropdownItems,
            onChanged: this.onChanged,
            value: this.preSelected,
            style: new TextStyle(
              color: Colors.black,
            ),
          ),
        )
    ),);
  }
}