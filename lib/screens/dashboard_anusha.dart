import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gcc_parking/screens/parking_lot_management.dart';
import 'package:gcc_parking/utils/actionUtils.dart';

import 'user.dart';
import 'registration.dart';
import 'task.dart';
import 'alerts.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';

BuildContext mContxt;
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    mContxt = context;
    return WillPopScope(
      onWillPop: _willPop,
      child: new MaterialApp(
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
          //Icon(FontAwesomeIcons.search,size: 20.0,),

          body: Dashboards(),
        ),
      ),
    );
  }

  Future<bool> _willPop() async{
    print("EXITING");
    return await showDialog(
      context: mContxt,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;

  }
}

class Dashboards extends StatefulWidget {
  @override
  DashboardState createState() {
    return new DashboardState();
  }
}

class DashboardState extends State<Dashboards> with WidgetsBindingObserver {
  int countVehicles = 0;
  double totalPayments = 0.0;
  Timer timer;
  List<charts.Series> seriesList;
  bool animate = false;
  AppLifecycleState _notification;
  bool timerStarted = false;

  int i = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initEverything();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    print("DID CHANGE $_notification");

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.suspending:
        {
          stopTimer();
          break;
        }

      case AppLifecycleState.resumed:
        {
          startTimer();
          break;
        }
    }
  }

  void stopTimer() {
    if(timerStarted) {

    print("Stopped Timer $timerStarted");
    timer.cancel();
    setState(() {
      timerStarted = false;
    });
    }
  }

  void initEverything() async {
    fetchDashUpdates();
    startTimer();

    seriesList = _createSampleData();
  }

  void startTimer() {
    if(!timerStarted){

    print("Strart Timer $timerStarted");
    timer = new Timer.periodic(fourteenHunredMs, realTimeUpdate);

    setState(() {
      timerStarted = true;
    });

    }
  }

  void realTimeUpdate(Timer t) async {
    await fetchDashUpdates();
  }

  Future fetchDashUpdates() async {
    await getTotalVehicles(context).then((count) {
      print("Count $count");
      setState(() {
        ++i;
        countVehicles = count;
      });

      print("int $i");
    });

    await getTotalPayments(context).then((totalPayments) {
      print("Total Paymets $totalPayments");
      setState(() {
        this.totalPayments = totalPayments;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("DispOSE CALED");
    stopTimer();
    super.dispose();
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final random = new Random();

    final data = [
      new OrdinalSales('2014', random.nextInt(100)),
      new OrdinalSales('2015', random.nextInt(100)),
      new OrdinalSales('2016', random.nextInt(100)),
      new OrdinalSales('2017', random.nextInt(100)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Payments Recieved',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      new Container(
        decoration: const BoxDecoration(color: Colors.blueGrey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.users,
                color: Colors.white,
                size: DRAWER_ICON_SIZE,
              ),
              onPressed: () {
                gotoUser(context);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.productHunt,
                  color: Colors.white, size: DRAWER_ICON_SIZE),
              onPressed: () {
                stopTimer();
                print("Praking on pressed");

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParkingLotManagement()));              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.listUl,
                  color: Colors.white, size: DRAWER_ICON_SIZE),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Task()));
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.registered,
                  color: Colors.white, size: DRAWER_ICON_SIZE),
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
      Expanded(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                new Container(
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Total\n'
                          'Vehicles',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Container(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          '  \n'
                              '${countVehicles ?? 0}',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                new Container(
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Received\n'
                          'Payments',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    new Container(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          '  \n'
                              '$totalPayments',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 24.0),
            height: 250.0,
            width: 250.0,
            child: SimpleBarChart(seriesList, animate: animate),
          ),
        ]),
      ),
    ]);
  }

  void gotoUser(BuildContext context) {
    stopTimer();
     Navigator.push(
        context, MaterialPageRoute(builder: (context) => User()));

 //   startTimer();
  }
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
