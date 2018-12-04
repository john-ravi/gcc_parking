import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/models/ParkingArea.dart';
import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/models/parking_slot.dart';

import 'package:gcc_parking/screens/user.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'registration.dart';
import 'task.dart';
import 'alerts.dart';

class ParkingLotManagement extends StatefulWidget {
  @override
  _ParkingLotManagementState createState() => _ParkingLotManagementState();
}

class _ParkingLotManagementState extends State<ParkingLotManagement> {
  List<DropdownMenuItem<String>> listAreas = new List();

  String menuValue = "";
  int totalSlots = 0;
  int availableSlots = 0;
  int occupiedSlots = 0;
  int inactive = 0;
  int pending = 0;

//  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];

  ParkingArea _parkingArea = ParkingArea.named(stringParkingArea: "");

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  int slotsCount = 21;
  List<ParkingSlot> listParkingSlots;
  List<ParkingArea> listParkingAreas;
  List<ParkingArea> listFinalParkingAreas = <ParkingArea>[];

  @override
  void initState() {
    initEverything();
    super.initState();
  }

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
        Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => User()));
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

  /*new DropdownButton<String>(
                        value: _color,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            //   newContact.favoriteColor = newValue;
                            _color = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: listDummy.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      )
  *
  * */

  Widget buildParkingDetailsColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: true,
            child: buildFormField(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                    width: 24.0, child: Image.asset("assets/images/white.png")),
                Text("Total Slots $totalSlots")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                    width: 24.0, child: Image.asset("assets/images/red.png")),
                Text("Occupied Slots $occupiedSlots")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                    width: 24.0, child: Image.asset("assets/images/green.png")),
                Text("Available Slots $availableSlots")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 24.0,
                ),
                Text("Inactive Slots $inactive")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 24.0,
                ),
                Text("Pending Slots $pending")
              ],
            ),
          ),
          buildGridContainer(),
        ],
      ),
    );
  }

  Container buildGridContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.0),
      width: 250.0,
      height: 250.0,
      //       color: Colors.deepPurpleAccent,
      child: _parkingArea.stringParkingArea == ""
          ? Container()
          : GridView.count(
              crossAxisCount: 4,
              children: List.generate(listParkingSlots.length, (index) {
                print("Slots for ${_parkingArea.stringParkingArea} are $index");
                return InkWell(
                  child: GestureDetector(
                    onTap: () {
                      print("Pressed $index");

                      if (listParkingSlots[index].slotStatus ==
                          SlotStatus.occupied) {
                        showSlotDialog(listParkingSlots[index]);
                      } else {
                        String toast = listParkingSlots[index].slotStatus ==
                                SlotStatus.occupied
                            ? "Slot Status ${listParkingSlots[index].slotStatus} \n"
                                ""
                                "Vehicle Number ${listParkingSlots[index].vehicle.vehiclePlateNumber}"
                            : "Slot Status ${listParkingSlots[index].slotStatus}";
                        showToast(toast);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      width: 30.0,
                      height: 30.0,
                      child: returnSlotImageWithColor(index),
                    ),
                  ),
                );
              }),
            ),
    );
  }

  FormField<ParkingArea> buildFormField() {
    return new FormField<ParkingArea>(
      builder: (FormFieldState<ParkingArea> state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Parking Area',
              errorText: state.hasError ? state.errorText : null,
            ),
            isEmpty: _parkingArea.stringParkingArea == '',
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<ParkingArea>(
                value: _parkingArea != null
                    ? _parkingArea.stringParkingArea == "" ? null : _parkingArea
                    : null,
                isDense: true,
                onChanged: (ParkingArea newValue) {
                  print("Selected Parking area ${newValue.stringParkingArea}");
                  setState(() {
                    _parkingArea = newValue;
                    state.didChange(newValue);

                    listParkingSlots = newValue.listParkingSlots;

                    print(
                        "OncHanges List PArking Slots for ${newValue.stringParkingArea} are ${listParkingSlots.length}");

                    if (_parkingArea.stringParkingArea == "") {
                      resetTotalsIndex();
                    } else {
                      updateTotalsIndex();
                    }
                  });
                },
                items: listFinalParkingAreas.map((ParkingArea value) {
                  return new DropdownMenuItem<ParkingArea>(
                    value: value,
                    child: new Text(value.stringParkingArea ?? ""),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
      validator: (val) {
        if (val != null) {
          return val.stringParkingArea != '' ? null : 'Please select a Area';
        } else {
          print('VAlidation val is null');
          return 'Please select an Area';
        }
      },
    );
  }

  void initEverything() async {
    print("InitsEverything");
    Random random = new Random();

    int nextInt = random.nextInt(11);

    slotsCount = nextInt + 10;

    generateParkingAreas(random);

    await Future.delayed(Duration(milliseconds: 700), () {
      setState(() {});
    });
  }

  void updateTotalsIndex() {
    clearTotals();

    listParkingSlots.forEach((slot) {
      print("Slot status ${slot.slotStatus} and ");
      switch (slot.slotStatus) {
        case SlotStatus.inactive:
          {
            inactive++;
            break;
          }
        case SlotStatus.occupied:
          {
            occupiedSlots++;

            break;
          }
        case SlotStatus.pending:
          {
            pending++;
            break;
          }
        case SlotStatus.vacant:
          {
            availableSlots++;
            break;
          }
      }

      totalSlots = inactive + occupiedSlots + pending + availableSlots;
    });
  }

  void clearTotals() {
    totalSlots = inactive = occupiedSlots = pending = availableSlots = 0;
  }

  resetTotalsIndex() {
    _parkingArea.listParkingSlots.clear();
    clearTotals();
  }

  void clearParkingAndFill() {
    listFinalParkingAreas.clear();

    listFinalParkingAreas.add(ParkingArea.named(stringParkingArea: ""));

    listFinalParkingAreas.addAll(listParkingAreas);

    setState(() {});
  }

  void generateParkingAreas(Random random) {
    listParkingAreas = List<ParkingArea>.generate(7, (index) {
      String areaCode = "Area$index";
      return ParkingArea.named(
          stringParkingArea: areaCode,
          listParkingSlots: generateParkingSlots(random, areaCode));
    });

    clearParkingAndFill();
  }

  List<ParkingSlot> generateParkingSlots(Random random, String areaCode) {
    return List<ParkingSlot>.generate(slotsCount, (index) {
      return giveParkingSlotForIndex(random, index, areaCode);
    });
  }

  ParkingSlot giveParkingSlotForIndex(
      Random random, int index, String areaCode) {
    var listVehicleType =
        listVehicleTypes[random.nextInt(listVehicleTypes.length)];
    var slotStatus =
        SlotStatus.values[random.nextInt(SlotStatus.values.length)];
    return ParkingSlot.named(
      slotStatus: slotStatus,
      slotName: areaCode + "-" + index.toString(),
      vehicle: slotStatus == SlotStatus.occupied
          ? Vehicle.named(
              vehiclePlateNumber: "TN 08 EG ${1000 + random.nextInt(8999)}",
              vehicleType: listVehicleType.vehicleClass,
              area: listVehicleType.vehicleDimensions,
              due: random.nextInt(100).toString(),
              applicableFee: listVehicleType.parkingFee.toString(),
            )
          : null,
    );
  }

  Widget returnSlotImageWithColor(int index) {
    Widget widget;
    switch (listParkingSlots[index].slotStatus) {
      case SlotStatus.inactive:
        {
          widget = Image.asset(
            "assets/images/inactiveparking.png",
          );
          break;
        }
      case SlotStatus.occupied:
        {
          widget = Image.asset(
            "assets/images/redparking.png",
          );

          break;
        }
      case SlotStatus.pending:
        {
          widget = Image.asset(
            "assets/images/pending.png",
          );
          break;
        }
      case SlotStatus.vacant:
        {
          widget = Image.asset(
            "assets/images/greenparking.png",
          );

          break;
        }
    }
    return widget;
  }

  void showSlotDialog(ParkingSlot listParkingSlot) {
    ///   return showDialog<Null>(
    ///     context: context,
    ///     barrierDismissible: false, // user must tap button!
    ///     builder: (BuildContext context) {
    ///       return AlertDialog(
    ///         title: Text('Rewind and remember'),
    ///         content: SingleChildScrollView(
    ///           child: ListBody(
    ///             children: <Widget>[
    ///               Text('You will never be satisfied.'),
    ///               Text('You\’re like me. I’m never satisfied.'),
    ///             ],
    ///           ),
    ///         ),
    ///         actions: <Widget>[
    ///           FlatButton(
    ///             child: Text('Regret'),
    ///             onPressed: () {
    ///               Navigator.of(context).pop();
    ///             },
    ///           ),
    ///         ],
    ///       );
    ///     },
    ///   );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListBody(
                  children: <Widget>[
                    Text(
                      "Selected Slot: ${listParkingSlot.slotName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),

                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                    Text(
                      "Occupation Status: ${listParkingSlot.slotStatus.toString().substring(listParkingSlot.slotStatus.toString().indexOf(".") + 1)}",
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),

                    Text(
                      "Occupation Details: ",
                      textAlign: TextAlign.start,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  "Vehicle#: ${listParkingSlot.vehicle
                                      .vehiclePlateNumber}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  "Type: ${listParkingSlot.vehicle
                                      .vehicleType}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  "Dimensions: ${listParkingSlot.vehicle
                                      .area}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  "Pending Dues: ${listParkingSlot.vehicle
                                      .due}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  "Parking Cost: ${listParkingSlot.vehicle
                                      .applicableFee}"),
                            ],
                          ),
                        ),


                        Row(mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButton<String>(
                                //enum SlotStatus { occupied, vacant, inactive, pending }
                                items: <String>['occupied', 'vacant', 'inactive', 'pending'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (test) {
                                  print("onChanged to $test");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
