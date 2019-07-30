import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/models/immobolised.dart';
import 'package:gcc_parking/models/vehicles_in_out.dart';
import 'package:gcc_parking/screens/alerts.dart';
import 'package:gcc_parking/screens/parking_lot_management.dart';
import 'package:gcc_parking/screens/user_management.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Immobolised> listImmobilised;
  List<CheckedVehiclesIn_Out> checkedInVehiclesList;
  List<CheckedVehiclesIn_Out> checkedOutVehiclesList;
  bool boolLoading = true;



  @override
  void initState() {
    print('in iniut everything');
    initEverything();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('in build');
    return MaterialApp(
        home: DefaultTabController(

          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,

              bottom: TabBar(
               isScrollable: true,
                tabs: <Widget>[
                  Tab(
                      child: Text(
                        'Checked In',
                        style: TextStyle(fontSize: 18.0),
                      )),
                  Tab(
                    child: Text(
                      'Checked Out',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Immobilised',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
              title: Text(
                '   Task and Activity',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ),
            drawer: buildDrawer(context),
            body: TabBarView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:checkedInVehiclesList != null && !boolLoading ? vehiclesIn():
                Container(),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Container(
                      child: checkedOutVehiclesList !=null && !boolLoading? vehiclesOut() :
                    Container()
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: (listImmobilised != null && listImmobilised.length != 0)
                    ?
                  buildList()
                      :
                   boolLoading ?
                  Container(
                    child: Center(child: Text('Loading'),))
                    : Container(
                  child: Center(child: Text('No Immobilised Vehicles'),)
                  ),
                ),
              ),
            ]),
          ),
        ));
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserManagement()));
          },
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.productHunt,
            color: selectionIconColor,
            size: DRAWER_ICON_SIZE,
          ),
          onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ParkingLotManagement()));
          },
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.listUl,
            color: Colors.white,
            size: DRAWER_ICON_SIZE * 1.16,
          ),
          onPressed: () {
/*
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Task()));
*/
          },
        ),
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
              style: TextStyle(color: Colors.white,),
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
                  new MaterialPageRoute(builder: (context) => new UserManagement()));
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
              style: TextStyle(color: selectionIconColor),
            ),
            leading: new Icon(
              FontAwesomeIcons.listUl,
              color: selectionIconColor,
              size: 30.0,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              /*Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Task()));*/
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
              showDialog(context: context,builder: (context)=>AlertDialog(content: Container(
                height: 100.0,
                width: 150.0,
                child: Column(children: <Widget>[
                  Text('Do you really want to Log out',style: TextStyle(fontWeight: FontWeight.w500),),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: <Widget>[
                      RaisedButton(
                        child: Text('Yes'),
                        onPressed: (){logout(context);},
                        color: Colors.green,
                      ),
                      RaisedButton(
                        child: Text('No'),
                        onPressed:(){Navigator.pop(context);},
                        color: Colors.red,
                      )
                    ],),
                  )
                ],),
              )
              )
              );
             // logout(context);
            },
          ),
        ]),
      ),
    );
  }

  void initEverything() async {
    print('beofre network call');

    listImmobilised = await getImmobilised();
    checkedInVehiclesList=await getCheckedVehiclesIn();
    checkedOutVehiclesList=await getCheckedVehiclesOut();
    print('after network call');
    setState(() {
      boolLoading = false;
    });
    print('List of immobilisere ${listImmobilised.toString()}');
  }

  Widget buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        print('printing index value $index');
        print('index value is${listImmobilised[index]}');
        return Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '${listImmobilised[index].vehicleNumber}'),
                    ),
                  ],
                ),
              ),

              RaisedButton(
                splashColor: Colors.deepOrange,
                color: Colors.orange,
                child: Text('View Details'),
                onPressed: () {
                  print('before dialog');
                  showDialog(
                      context: context,builder: (context)=>AlertDialog(
                    content: new Container(
                            child: Text('Vehicle Number ${listImmobilised[index].vehicleNumber} \n '
                                'User Name - ${listImmobilised[index].userName} \n'
                                'Lot : ${listImmobilised[index].lotName}\n'
                                'Slot Number - ${listImmobilised[index].slotNumber} \n'
                                'Due Amount - ${listImmobilised[index].dueAmount}')
                            /*userName: leokanchana, vehicleNumber: TN-00-EN-2345, slotNumber: 003, dueAmount: 0.00*/


                    ),
                  ));
                },
              )
            ],
          ),
        );
      },
      itemCount: listImmobilised.length,
    );
  }

  Widget vehiclesIn(){
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                            Text(
                            '${checkedInVehiclesList[index].vehicleNumber}'),
                          ],
                    ),
                  ),
                  RaisedButton(
                    splashColor: Colors.deepOrange,
                    color: Colors.orange,
                    child: Text('View Details'),
                    onPressed: () {
                      print('before dialog');
                      showDialog(
                          context: context,builder: (context)=>AlertDialog(
                        content: new Container(
                          child: Text('Vehicle Number ${checkedInVehiclesList[index].vehicleNumber}\n'
                              'User Name : ${checkedInVehiclesList[index].userID}\n'
                              'User ID : ${checkedInVehiclesList[index].userName ?? ''
                          }\n'
                              'Location : ${checkedInVehiclesList[index].area}\n'
                              'Lot : ${checkedInVehiclesList[index].lotName}\n'
                              'Slot Id : ${checkedInVehiclesList[index]
                              .slotId ?? ''}\n'
                              'Start Date&Time : ${checkedInVehiclesList[index].startTime}\n'
                              'End Date&Time : ${checkedInVehiclesList[index].endTime}\n'
                              'Fee Amount : ${checkedInVehiclesList[index].fee}\n'
                              'Fine Amount : ${checkedInVehiclesList[index].fine}\n'
                              'Payment Status : ${checkedInVehiclesList[index]
                              .paymentStatus == '1' ? 'Paid' : 'Not Paid'}\n'
                              'Slot Status : ${checkedInVehiclesList[index].slotStatus}\n'
                              'Penalty Amount : ${checkedInVehiclesList[index].slotStatus}\n'
                              'Due Amount : ${checkedInVehiclesList[index].due}')
                        ),
                      ));
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
      itemCount: checkedInVehiclesList.length,
    );

  }
  Widget vehiclesOut(){
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                            Text(
                            '${checkedOutVehiclesList[index].vehicleNumber}'),
                          ],
                    ),
                  ),
                  SizedBox(
                    width: 45.0,
                  ),
                  RaisedButton(
                    splashColor: Colors.deepOrange,
                    color: Colors.orange,
                    child: Text('View Details'),
                    onPressed: () {
                      print('before dialog index $index and slot id ${checkedOutVehiclesList[index]
                          .slotId}');
                      showDialog(
                          context: context,builder: (context)=>AlertDialog(
                        content: new Container(
                          child:  Text('Vehicle Number ${checkedOutVehiclesList[index].vehicleNumber}\n'
                                'User Name : ${checkedOutVehiclesList[index]
                              .userName ?? ''}\n'
                                'User ID : ${checkedOutVehiclesList[index].userID}\n'
                                'Location : ${checkedOutVehiclesList[index].area}\n'
                              'Lot : ${checkedOutVehiclesList[index].lotName}\n'
                              'Slot Id : ${checkedOutVehiclesList[index]
                              .slotId ?? ''}\n'
                                'Start Date&Time : ${checkedOutVehiclesList[index].startTime}\n'
                                'End Date&Time : ${checkedOutVehiclesList[index].endTime}\n'
                                'Fee Amount : ${checkedOutVehiclesList[index].fee}\n'
                                'Fine Amount : ${checkedOutVehiclesList[index].fine}\n'
                              'Payment Status : ${checkedOutVehiclesList[index]
                              .paymentStatus == '1' ? 'Paid' : 'Not Paid'}\n'
                                'Penalty Amount : ${checkedOutVehiclesList[index]
                              .penalty}\n'
                                'Due Amount : ${checkedOutVehiclesList[index].due}')
                        ),
                      ));
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
      itemCount: checkedOutVehiclesList.length,
    );

  }
}
