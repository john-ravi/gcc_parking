import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/screens/booking_details.dart';
import 'package:gcc_parking/screens/parking_lot_management.dart';
import 'package:gcc_parking/screens/reports.dart';
import 'package:gcc_parking/screens/search.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';

import 'user_management.dart';
import 'task_and_activity.dart';
import 'alerts.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/utils_fcm.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

BuildContext mContxt;

class Dashboard extends StatelessWidget {
  ModelAgent modelAgent;

  Dashboard(this.modelAgent);

  @override
  Widget build(BuildContext context) {
    mContxt = context;
    return WillPopScope(
      onWillPop: _willPop,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
              buildContainerAlert(context),
              Padding(padding: EdgeInsets.only(right: 24.0))
            ],
          ),

          drawer: buildDrawer(context),
          //Icon(FontAwesomeIcons.search,size: 20.0,),

          body: Dashboards(modelAgent),
        );
      }),
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
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UserManagement()));
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

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ParkingLotManagement()));
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
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => new Task()));
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

  Future<bool> _willPop() async {
    print("EXITING");
    return await showDialog(
          context: mContxt,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: Container(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      new Text('Do you want to exit'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => exit(0),
                    child: new Text('Yes'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: new Text('No'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}

class Dashboards extends StatefulWidget {
  ModelAgent modelAgent;

  Dashboards(this.modelAgent);

  @override
  DashboardState createState() {
    return new DashboardState();
  }
}

class DashboardState extends State<Dashboards> with WidgetsBindingObserver {
  int countVehicles = 0;
  double totalPayments = 0.0;
  Timer timer;
  List<charts.Series> seriesList, seriesListOccupancy;
  bool animate = false;
  AppLifecycleState _notification;
  bool timerStarted = false;
  bool boolVisible = true;

  int i = 0;

  String fcmToken;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    print("Stop Timer - Timer Started? $timerStarted and mounted $mounted and"
        " is visbile $boolVisible");

    if (timerStarted) {
      print("Timer Started? $timerStarted");
      timer.cancel();

      if (mounted) {
        setState(() {
          timerStarted = false;
        });
      print("Timer Started? $timerStarted ans timer state ${timer.isActive}");
      }

    }
  }

  void initEverything() async {
    fetchDashUpdates();
    startTimer();

    seriesList = _createSampleData();
    seriesListOccupancy = _createSampleDataOccupancy();

    configureFCM(context);
  }

  void startTimer() {
      print("Strart Timer - Timer Started? $timerStarted and mounted $mounted and"
          " is visbile $boolVisible");
    if (!timerStarted && mounted && boolVisible) {

      timer = new Timer.periodic(fourteenHunredMs, realTimeUpdate);

      setState(() {
        timerStarted = true;
      });

      print('Timer Started in start timer $timerStarted');
    }
  }

  void realTimeUpdate(Timer t) async {
    if (mounted) {
      await fetchDashUpdates();
    } else {
      print('Not Mounted - so not updating paymets');
    }
  }

  Future fetchDashUpdates() async {
/*
    await getTotalVehicles(context).then((count) {
      print("Count $count");
      setState(() {
        ++i;
        countVehicles = count;
      });

      print("int $i");
    });
*/

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
      new OrdinalSales('00', random.nextInt(100)),
      new OrdinalSales('01', random.nextInt(100)),
      new OrdinalSales('02', random.nextInt(100)),
      new OrdinalSales('03', random.nextInt(100)),
      new OrdinalSales('04', random.nextInt(100)),
      new OrdinalSales('05', random.nextInt(100)),
      new OrdinalSales('06', random.nextInt(100)),
      new OrdinalSales('07', random.nextInt(100)),
      new OrdinalSales('08', random.nextInt(100)),
      new OrdinalSales('09', random.nextInt(100)),
      new OrdinalSales('10', random.nextInt(100)),
      new OrdinalSales('11', random.nextInt(100)),
      new OrdinalSales('12', random.nextInt(100)),
      new OrdinalSales('13', random.nextInt(100)),
      new OrdinalSales('14', random.nextInt(100)),
      new OrdinalSales('15', random.nextInt(100)),
      new OrdinalSales('16', random.nextInt(100)),
      new OrdinalSales('17', random.nextInt(100)),
      new OrdinalSales('18', random.nextInt(100)),
      new OrdinalSales('19', random.nextInt(100)),
      new OrdinalSales('20', random.nextInt(100)),
      new OrdinalSales('21', random.nextInt(100)),
      new OrdinalSales('22', random.nextInt(100)),
      new OrdinalSales('23', random.nextInt(100)),
      new OrdinalSales('24', random.nextInt(100)),
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

  /// Create one series with sample hard coded data.
  List<charts.Series<OrdinalSales, String>> _createSampleDataOccupancy() {
    final random = new Random();

    final data = [
      new OrdinalSales('Sun', random.nextInt(10)),
      new OrdinalSales('Mon', random.nextInt(10)),
      new OrdinalSales('Tue', random.nextInt(10)),
      new OrdinalSales('Wed', random.nextInt(10)),
      new OrdinalSales('Thu', random.nextInt(10)),
      new OrdinalSales('Wed', random.nextInt(10)),
      new OrdinalSales('Fri', random.nextInt(10)),
      new OrdinalSales('Sat', random.nextInt(10)),
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
        child: buildaNavColumn(context),
      ),
      Expanded(
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SlotReports()));
                    },
                    child: Text(
                      'Slot Reports',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Flexible(
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Search()));
                    },
                    child: Text(
                      'User Bookings',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
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
                              '00.00',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 24.0),
            child: Container(
                height: 250.0,
                width: 720.0,
                margin: EdgeInsets.only(left: 16.0),
                child: SimpleBarChart(
                  seriesList,
                  animate: animate,
                )),
          ),
          Center(
            child: Text('Number of Vehicles-In Hourly Trends'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 24.0),
            child: Container(
                height: 250.0,
                width: 360.0,
                margin: EdgeInsets.only(left: 16.0),
                child: SimpleBarChart(
                  seriesListOccupancy,
                  animate: animate,
                )),
          ),
          Center(
            child: Container(
              child: Text('Average Occupancy Time in Hours'),
              margin: EdgeInsets.only(bottom: 24.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Powered By ',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Image.asset(
                "assets/images/nts.png",
                height: 24.0,
              ),
            ],
          ),
        ]),
      ),
    ]);
  }

  Column buildaNavColumn(BuildContext context) {
    return Column(
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

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ParkingLotManagement()));
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.listUl,
              color: Colors.white, size: DRAWER_ICON_SIZE),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Task()));
          },
        ),
/*
          IconButton(
            icon: Icon(FontAwesomeIcons.registered,
                color: Colors.white, size: DRAWER_ICON_SIZE),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Registration()));
            },
          ),
*/
        IconButton(
          icon: Icon(FontAwesomeIcons.exclamationTriangle,
              color: Colors.white, size: DRAWER_ICON_SIZE),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => (Alert())));
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.signOutAlt,
              color: Colors.white, size: DRAWER_ICON_SIZE),
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
            // logout(context);
          },
        ),
      ],
    );
  }

  void gotoUser(BuildContext context) async {
    stopTimer();
    setState(() {
      boolVisible = false;
    });
    Future futureUser = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserManagement()));

    print('Printing after coming back to Dashboard $futureUser');
    if (mounted) {
      setState(() {
        boolVisible = true;
      });
      startTimer();
    }

    //   startTimer();
  }

  void configureFCM(BuildContext context) {
    _firebaseMessaging.configure(
      onLaunch: onFCMLaunch,
      onMessage: (mapMessage) {
        print('FCM MESSAGE $mapMessage');
        return onFCMMessage(context, mapMessage);
      },
      onResume: onFCMResume,
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      var _homeScreenText = "Push Messaging token: $token";
      fcmToken = token;
      print('printing FCM TOKEN $fcmToken');
      print(_homeScreenText);
      widget.modelAgent.fcmToken = fcmToken;
      await sendTokenToServer(widget.modelAgent);
    });
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
