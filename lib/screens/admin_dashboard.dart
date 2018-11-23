import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/app_colors.dart';

import '../fragments/alerts_admin.dart';
import '../fragments/parking_lot_management.dart';
import '../fragments/quick_registration.dart';
import '../fragments/task_and_activity.dart';
import '../fragments/users_managment.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<Widget> homeFragments = [
    UsersManagement(),
    ParkingLotManagement(),
    TaskAndActivity(),
    QuickRegistration(),
    AlertsAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(


          child: ListView(
            children: <Widget>[
              ListTile(
                title: new Text('User Management'),
                leading: new Icon(
                  FontAwesomeIcons.users,
                  color: PrimaryColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsersManagement()));
                },
              ),
              ListTile(
                title: new Text('Parking Lot Management'),
                leading: new Icon(
                  FontAwesomeIcons.parking,
                  color: PrimaryColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParkingLotManagement()));
                },
              ),
              ListTile(
                title: new Text('Task and Activity'),
                leading: new Icon(
                  FontAwesomeIcons.tasks,
                  color: PrimaryColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskAndActivity()));
                },
              ),
              ListTile(
                title: new Text('Quick Registration'),
                leading: new Icon(
                  FontAwesomeIcons.uniregistry,
                  color: PrimaryColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuickRegistration()));
                },
              ),
              ListTile(
                title: new Text('Alerts'),
                leading: new Icon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: PrimaryColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsersManagement()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
