import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/screens/parking_lot_management.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'registration.dart';
import 'task.dart';
import 'alerts.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class User extends StatefulWidget {
  @override
  UserState createState() {
    return new UserState();
  }
}

class UserState extends State<User> {
  bool serachActive = true;
  GlobalKey<AutoCompleteTextFieldState<Vehicle>> keySearchVehicle =
      new GlobalKey();
  List<Vehicle> suggestions = new List();

  AutoCompleteTextField textField;
  Vehicle currentVehicle = new Vehicle();
  bool isBlacklisted = false;

  String vehicleNumber = "Plate # XX XX XX XXXX";
  String rawVehicleNumber;

  String vehicleType,
      userId,
      startTime,
      endTime,
      parkingSlot,
      appFee,
      payStatus,
      appFine,
      dues,
      penalty;

  bool blacklisted = false;

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  void initEverything() async {
    //populateList();

    suggestions = await getVehicles(context);
    textField.updateSuggestions(suggestions);
    print("updated suggestions");

/*
    Future.delayed(
        Duration(
          milliseconds: 4200,
        ), () {
      textField.key.currentState.textField.inputFormatters.add(
        WhitelistingTextInputFormatter(RegExp("^[A-Za-z0-9]+")),
      );
    });
*/
  }

  @override
  Widget build(BuildContext context) {
    buildSearchText();

    return new MaterialApp(
      title: 'AGENT LOGIN',
      home: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            serachActive ? buildAutoSearch() : Icon(FontAwesomeIcons.search),
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

  void buildSearchText() {
    textField = new AutoCompleteTextField<Vehicle>(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Ex:TN01eh1234",
        ),
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        key: keySearchVehicle,
        suggestionsAmount: 7,
        itemSubmitted: (vehicle) {
          showVehicle(vehicle);
        },
        submitOnSuggestionTap: true,
        clearOnSubmit: true,
        suggestions: suggestions,
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.go,
        textChanged: (item) {
          print("currwent $item");
          print("list ${suggestions.toString()}");
        },
        textSubmitted: (item) {
          print("Submitteed $item");
        },
        itemBuilder: (context, item) {
          return new Padding(
              padding: EdgeInsets.all(8.0),
              child: new Text(item.vehiclePlateNumber));
        },
        itemSorter: (a, b) {
          return a.vehiclePlateNumber.compareTo(b.vehiclePlateNumber);
        },
        itemFilter: (item, query) {
          return item.vehiclePlateNumber
              .toLowerCase()
              .startsWith(query.toLowerCase());
        });
  }

  void showVehicle(Vehicle vehicle) {
    currentVehicle = vehicle;
    rawVehicleNumber = currentVehicle.vehiclePlateNumber;
    vehicleNumber = currentVehicle.vehiclePlateNumber;
    vehicleType = currentVehicle.vehicleType;
    userId = currentVehicle.userId;
    startTime = currentVehicle.startTime;
    endTime = currentVehicle.endTime;
    parkingSlot = currentVehicle.parkingSlot;
    appFee = currentVehicle.applicableFee;
    payStatus = currentVehicle.payementStatus;
    appFine = currentVehicle.applicableFine;
    dues = currentVehicle.due;
    penalty = currentVehicle.penalty;

    vehicleNumber =
        'Plate # ${vehicleNumber.substring(0, 2)} ${vehicleNumber.substring(2, 4)} ${vehicleNumber.substring(4, 6)} ${vehicleNumber.substring(6)}';

    setState(() {});
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

  Widget buildDescriptionRow(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      children: <Widget>[
        Row(children: <Widget>[
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(right: 10.0),
            child: new Container(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.users,
                        color: selectionIconColor,
                        size: DRAWER_ICON_SIZE * 1.16,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.productHunt,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
                    onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ParkingLotManagement()));
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.listUl,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
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
              ),
            ),
          ),
          buildVehicleDetailsColumn()
        ]),
      ],
    );
  }

  Column buildVehicleDetailsColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
            Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              vehicleNumber,
              style: new TextStyle(color: Colors.black, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    isBlacklisted ? stringBlackList : "",
                    style: new TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Vehicle type:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          vehicleType ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'User Id:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          userId ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Start time:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          startTime ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'End time:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          endTime ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Parking slot:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          parkingSlot ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Applicable fees:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          appFee ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Payment status: ${payStatus ?? ""}',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Applicable fines:',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          appFine ?? "",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Due's",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Container(
                          color: Colors.grey,
                          child: new Center(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: new Text(dues ?? "0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Penalty",
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Container(
                          color: Colors.grey,
                          child: new Center(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: new Text(penalty ?? "0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Blacklist",
                        style: new TextStyle(
                            color: Colors.black, fontSize: 24.0),
                      ),
                    )
                  ],
                ),
                Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: <Widget>[
                        new Container(
                          //blacklited = true means No hsould display grey
                          color: blacklisted ? Colors.grey : Colors.blueGrey,
                          child: new Center(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: InkWell(
                                onTap: () {
                                  if (blacklisted == true) {
                                    setState(() {
                                      blacklisted = false;
                                    });

                                    updateVehicleBlacklistStatus(
                                        rawVehicleNumber, userId, blacklisted);
                                  }
                                },
                                child: new Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Container(
                          color: blacklisted ? Colors.blueGrey : Colors.grey,
                          child: new Center(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: InkWell(
                                onTap: () {
                                  if (blacklisted == false) {
                                    setState(() {
                                      blacklisted = true;
                                    });

                                    updateVehicleBlacklistStatus(
                                        rawVehicleNumber, userId, blacklisted);
                                  }

                                },
                                child: new Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
              ]),
        ]);
  }

  Widget buildAutoSearch() {
    return Container(
      width: 250.0,
      child: ListTile(
          title: textField,
          trailing: new IconButton(
              icon: new Icon(Icons.clear),
              onPressed: () {
                print("pressed reset");
                setState(() {});
              })),
    );
  }
}

