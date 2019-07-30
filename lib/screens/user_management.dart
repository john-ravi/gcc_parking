import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/screens/parking_lot_management.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'task_and_activity.dart';
import 'alerts.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class UserManagement extends StatefulWidget {
  @override
  UserManagementState createState() {
    return new UserManagementState();
  }
}

class UserManagementState extends State<UserManagement> {
  bool serachActive = true;
  GlobalKey<AutoCompleteTextFieldState<ParkingSlot>> keySearchVehicle =
      new GlobalKey();
  List<ParkingSlot> suggestions = new List();

  AutoCompleteTextField textField;
  Vehicle currentVehicle = new Vehicle();
  bool isBlacklisted = false;

  String vehicleNumber = "Plate # XX XX XX XXXX";
  String rawVehicleNumber;

  ParkingSlot currentParkingSlot;

  String vehicleType,
      userName,
      startTime,
      endTime,
      parkingLot,
      parkingSlot,
      appFee,
      payStatus,
      appFine,
      dues,
      penalty;

  bool blacklisted = false;

  TextEditingController controllerAddNotes2 = TextEditingController();

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  void initEverything() async {
    //populateList();

    var list = await getVehicles(context);

    if (list != null) {
      suggestions = await getVehicles(context);
      textField.updateSuggestions(suggestions);
      print("updated suggestions");
    } else {
      print('Returned Null List from Get Vehicles for Search');
    }

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

        body: buildQuickNavAndVehicleRow(context),
      ),
    );
  }

  void buildSearchText() {
    textField = new AutoCompleteTextField<ParkingSlot>(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Ex:TN01EH1234",
        ),
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        key: keySearchVehicle,
        suggestionsAmount: 7,
        itemSubmitted: (vehicle) {
          currentParkingSlot = vehicle;
          showVehicle(vehicle);
          setState(() {

          });
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
              child: new Text(item.vehicle.vehiclePlateNumber));
        },
        itemSorter: (a, b) {
          return a.vehicle.vehiclePlateNumber
              .compareTo(b.vehicle.vehiclePlateNumber);
        },
        itemFilter: (item, query) {
          print('Item filter $item and query $query');
          return item.vehicle.vehiclePlateNumber
              .toLowerCase()
              .startsWith(query.toLowerCase());
        });
  }

  void showVehicle(ParkingSlot parkingSlotPassed) {
    currentVehicle = parkingSlotPassed.vehicle;
    rawVehicleNumber = currentVehicle.vehiclePlateNumber;
    vehicleNumber = currentVehicle.vehiclePlateNumber;
    vehicleType = currentVehicle.vehicleType;
    userName = currentVehicle.userName;
    startTime = parkingSlotPassed.dateTimeStart.toString();
    endTime = parkingSlotPassed.dateTimeEnd.toString();
    parkingLot = parkingSlotPassed.lot;
    this.parkingSlot = parkingSlotPassed.id.toString();
    appFee = parkingSlotPassed.fee;
    payStatus = parkingSlotPassed.paymentStatus;
    appFine = parkingSlotPassed.fine;
    dues = parkingSlotPassed.due;
    penalty = parkingSlotPassed.penalty;

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
              style: TextStyle(
                color: selectionIconColor,
              ),
            ),
            leading: new Icon(
              FontAwesomeIcons.users,
              color: selectionIconColor,
              size: 30.0,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              /* Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new UserManagement()));*/
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
              //logout(context);
            },
          ),
        ]),
      ),
    );
  }

  Widget buildQuickNavAndVehicleRow(BuildContext context) {
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
                      print("Praking on pressed");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParkingLotManagement()));
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
              ),
            ),
          ),
          buildVehicleDetailsColumn()
        ]),
      ],
    );
  }

  Widget buildVehicleDetailsColumn() {
    return Expanded(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                vehicleNumber,
                style: new TextStyle(color: Colors.black, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'User Name:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
              Text(
                userName ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Start time:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
              Text(
                startTime ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'End time:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
              Text(
                endTime ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Parking Lot:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(
                    parkingLot ?? "",
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Parking slot:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
              Text(
                parkingSlot ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Applicable fees:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
              Text(
                appFee ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Payment status: ',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
              Text(
                payStatus == '1' ? 'Paid' : 'Not Paid' ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Applicable fines:',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
              Text(
                appFine ?? "",
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Penalty",
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              Container(
                color: Colors.grey,
                child: new Center(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: new Text(penalty ?? "0",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Due's",
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  color: Colors.grey,
                  child: new Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: new Text(dues ?? "0",
                          style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                ),
              ],
            )),
        currentParkingSlot != null ?
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: controllerAddNotes2,
                    decoration: InputDecoration(
                      labelText: 'Add Notes',
                    ),
                    maxLines: 4,
                  ),
                )
              ],
            ))
        :Container(),

        currentParkingSlot != null ?
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () async{
                      if (controllerAddNotes2.text.length > 0) {
                        if(await addNotes(currentParkingSlot.bookingId,
                                                  controllerAddNotes2.text)) {
                                                showToast('Success Added Notes');
                                              }
                      }
                    },
                    child: Text(
                      'Add Private Notes',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ))

            : Container(),
      ]),
    );
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
                })));
  }
}
