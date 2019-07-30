import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/models/parking_area.dart';
import 'package:gcc_parking/models/parking_lot.dart';
import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/models/parking_slot.dart';

import 'package:gcc_parking/screens/user_management.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/stringUtils.dart';
import 'package:gcc_parking/utils/utilsPrefs.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'package:gcc_parking/widgets/dialog_immobilized.dart';
import 'package:gcc_parking/widgets/dialog_occupied.dart';
import 'package:gcc_parking/widgets/dialog_quick_registration.dart';
import 'package:gcc_parking/widgets/dialog_reserved.dart';
import 'package:gcc_parking/widgets/dialog_slot_booking_reg.dart';
import 'task_and_activity.dart';
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
  int reservedSlots = 0;
  int inactive = 0;
  int immobilized = 0;
  int pending = 0;

  ParkingArea _parkingArea;
  ParkingLot _parkingLot;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<ParkingSlot> listParkingSlots;
  List<ParkingLot> listFinalParkingLots = <ParkingLot>[];
  List<ParkingArea> listParkingArea;
  ModelAgent modelAgent;

  bool boolDisabled = false;

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            buildContainerAlert(context),
            Padding(
              padding: EdgeInsets.only(right: 27.0),
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
              listParkingArea != null ? buildParkingDetailsColumn() : Container(),
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
                context, MaterialPageRoute(builder: (context) => UserManagement()));
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
              style: TextStyle(color: selectionIconColor),
            ),
            leading: new Icon(
              FontAwesomeIcons.productHunt,
              color: selectionIconColor,
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
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => new Task()));
            },
          ),
/*
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
*/
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

  Widget buildParkingDetailsColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: true,
            child: listParkingArea.length > 0 ? buildFormFields() : Container(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 24.0,
                          child: Image.asset("assets/images/white.png")),
                      Text("Total Slots $totalSlots")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 24.0,
                          child: Image.asset(stringOrangeParking)),
                      Text("Reserved Slots $reservedSlots")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 24.0,
                          child: Image.asset(stringRedParking)),
                      Text("Occupied Slots $occupiedSlots")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 24.0,
                          child: Image.asset(stringGreenParking)),
                      Text("Available Slots $availableSlots")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 16.0),
                        width: 24.0,
                        child: Image.asset(stringInactiveParking),
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
                        margin: EdgeInsets.only(right: 16.0),
                        width: 24.0,
                        child: Image.asset(stringImmobParking),
                      ),
                      Text("Immobilized Slots $immobilized")
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 24.0,
                          child: Image.asset(stringPendingParking),
                        ),
                        Text("Pending Admin Approval Slots $pending")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          listParkingSlots != null && listParkingSlots.length > 0
              ? Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      print('list parking slots beofre ${listParkingSlots.length}');
                      int slotLength = listParkingSlots.length + 2;

                      createTemporarySlot(context, slotLength);
                    },
                    child: Text('Create Temporary Slot'),
                  ),
                )
              : Container(),
          listParkingSlots != null && listParkingSlots.length > 0
              ? buildGridContainer()
              : Container(),
        ],
      ),
    );
  }

  //todo Check Success Messsage not in reply after creating temp slot
  void createTemporarySlot(BuildContext context, int length) async {
    showloader(context);
    bool slotCreated = await createTempSlot(
        _parkingArea.id.toString(), _parkingLot.id.toString(), length);
    removeloader();

    print('Slot Created $slotCreated');
    if (slotCreated) {
      showToast('Temporary Slot Created');
      print('Updating Grid');
      updateGrid();
    } else {
      createTemporarySlot(context, ++length);
    }
  }

  Container buildGridContainer() {
    bool isStringAreaEmpty = _parkingArea.stringParkingArea.isEmpty;
    bool isStringLotEmpty = _parkingLot.stringParkingLotName.isEmpty;

    return Container(
      margin: EdgeInsets.only(top: 24.0, bottom: 35.0),
      width: 250.0,
      height: 720.0,
      child: showGridForAreaLot(isStringAreaEmpty, isStringLotEmpty),
    );
  }

  StatelessWidget showGridForAreaLot(
      bool isStringAreaEmpty, bool isStringLotEmpty) {
    print(
        'is Strin Area empty $isStringAreaEmpty and is Lot NAme Empty $isStringLotEmpty \n'
        'list PArking Slots length ${listParkingSlots.length} ');
    return (!isStringAreaEmpty && !isStringLotEmpty && listParkingSlots != null)
        ? GridView.count(
            crossAxisCount: 5,
            children: List.generate(listParkingSlots.length, (index) {
              //  print("Slots for ${_parkingLot.stringParkingLotName} are $index");
              return InkWell(
                onTap: () {
                  ParkingSlot parkingSlot = listParkingSlots[index];
                  var indexSlotStatus = parkingSlot.slotStatus;
                  print("Pressed $index with Parking slot ${parkingSlot.id}");
                  if (indexSlotStatus == SlotStatus.occupied) {
                    showOccupiedSlotDialog(parkingSlot, index);
                  } else if (indexSlotStatus == SlotStatus.vacant) {
                    showDialogQuickRegistration(parkingSlot, index);
                  } else if (indexSlotStatus == SlotStatus.reserved) {
                    // get Slot Bookings
                    showDialogReserved(parkingSlot, index);
                  } else if (indexSlotStatus == SlotStatus.immobilized) {
                    // get Slot Bookings
                    showDialogImmobilized(parkingSlot, index);
                  } else if (indexSlotStatus == SlotStatus.inactive) {
                    // get Slot Bookings
                    showDialogMakeActive(parkingSlot, index);
                  } else {
                    String toast =
                        "Slot Status ${fetchSlotStatus(indexSlotStatus)}";
                    showToast(toast);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: 30.0,
                  //      height: 72.0,
                  child: getColorForSlot(index),
                ),
              );
            }),
          )
        : Container();
  }

  Widget buildFormFields() {
    return Column(
      children: <Widget>[
        FormField(
          builder: buildParkingArea,
          validator: validateParkingArea,
        ),
        _parkingArea != null && listFinalParkingLots.length != 0
            ? FormField<ParkingLot>(
                builder: buildDropDownParkingLot,
                validator: validateParkingLot,
              )
            : Container(),
      ],
    );
  }

  Widget buildDropDownParkingLot(FormFieldState<ParkingLot> state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: _parkingArea.stringParkingArea == '' ? '' : 'Parking Lot',
          errorText: state.hasError ? state.errorText : null,
        ),
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<ParkingLot>(
            disabledHint: Text('Please select Parking Area'),
            value: _parkingLot,
            isDense: true,
            isExpanded: true,
            onChanged: (parkingLot) => onChangedParkingLot(parkingLot, state),
            items: generateDropMenuParkingLot(),
          ),
        ),
      ),
    );
  }

  Widget buildParkingArea(FormFieldState<ParkingArea> areaState) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Parking Area',
          errorText: areaState.hasError ? areaState.errorText : null,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ParkingArea>(
              isExpanded: true,
              value: _parkingArea,
              items: listParkingArea.map((parkingArea) {
                return DropdownMenuItem<ParkingArea>(
                  child: Text(parkingArea.stringParkingArea ?? ''),
                  value: parkingArea,
                );
              }).toList(),
              onChanged: (parkingAreaNew) {
                if (parkingAreaNew != _parkingArea) {
                  print('Parking Area Changed');
                  onChangedParkingArea(parkingAreaNew, areaState);
                } else {
                  print('Parking is SAME to Same');
                }
              }),
        ),
      ),
    );
  }

  List<DropdownMenuItem<ParkingLot>> generateDropMenuParkingLot() {
    return listFinalParkingLots.map((ParkingLot value) {
      var stringParkingLotName = value.stringParkingLotName;
      //    print('Lot Menu Item Name $stringParkingLotName');
      return new DropdownMenuItem<ParkingLot>(
        value: value,
        child: new Text(stringParkingLotName ?? ""),
      );
    }).toList();
  }

  String validateParkingLot(ParkingLot val) {
    if (val != null) {
      return val.stringParkingLotName != '' ? null : 'Select Parking Lot';
    } else {
      print('VAlidation val is null');
      return _parkingArea.stringParkingArea == ''
          ? 'Select Parking Area First'
          : 'Select Lot for ${_parkingArea.stringParkingArea}';
    }
  }

  String validateParkingArea(ParkingArea val) {
    if (val != null) {
      return val.stringParkingArea != '' ? null : 'Select Parking Area';
    } else {
      print('VAlidation val is null');
      return 'Select Area';
    }
  }

  void initEverything() async {
    print("InitsEverything");

    modelAgent = await getAgentFromPrefs();
    if(modelAgent.boolModelUpdated){
    listParkingArea = await getParkingAreas(modelAgent);

    setState(() {});
    } else {
      print(('Model agent returned not modified from prefs PLM initstate'));
    }

  }

  void updateTotalsIndex() {
    print(
        'Update Toatls before clearing Total $totalSlots, reserved $reservedSlots occupied '
        '$occupiedSlots available $availableSlots');
    clearTotals();

    listParkingSlots.forEach((slot) {
      //   print("Slot index ${listParkingSlots.indexOf(slot)} status ${slot.slotStatus} ");
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
        case SlotStatus.immobilized:
          {
            immobilized++;
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
        case SlotStatus.reserved:
          {
            reservedSlots++;
            break;
          }
      }

      totalSlots = inactive +
          occupiedSlots +
          pending +
          availableSlots +
          reservedSlots +
          immobilized;
    });
    print(
        'Update Toatls after adding Total $totalSlots, reserved $reservedSlots occupied '
        '$occupiedSlots available $availableSlots');
  }

  void clearTotals() {
    totalSlots = inactive =
        occupiedSlots = pending = availableSlots = reservedSlots = immobilized = 0;
    print('cleared Totals');
  }

  resetTotalsIndex() {
    print('reset Totals');
    _parkingLot.listParkingSlots.clear();

    clearTotals();
  }

  Widget getColorForSlot(int index) {
    Image widget;
    switch (listParkingSlots[index].slotStatus) {
      case SlotStatus.inactive:
        {
          widget = Image.asset(
            stringInactiveParking,
          );
          break;
        }
      case SlotStatus.occupied:
        {
          widget = Image.asset(stringRedParking);
          break;
        }
      case SlotStatus.immobilized:
        {
          widget = Image.asset(stringImmobParking);

          break;
        }
      case SlotStatus.pending:
        {
          widget = Image.asset(stringPendingParking);
          break;
        }
      case SlotStatus.vacant:
        {
          widget = Image.asset(
            stringGreenParking,
          );

          break;
        }
      case SlotStatus.reserved:
        {
          widget = Image.asset(
            stringOrangeParking,
          );

          break;
        }
    }
    return Column(
      children: <Widget>[
        Container(height: 20.0, child: widget),
        Flexible(
            child: Center(child: Text('${listParkingSlots[index].slotNumber}'))),
      ],
    );
  }

  void showOccupiedSlotDialog(ParkingSlot parkingSlot, int index) async {
    var mediaQuery = MediaQuery.of(context);

    parkingSlot = await getSlotDetails(parkingSlot);
    setState(() {});
    ParkingSlot parkingSlotReturned = await showDialog<ParkingSlot>(
        context: context,
        builder: (BuildContext context) {
          return AnimatedContainer(
            duration: Duration(
              milliseconds: 300,
            ),
            padding: mediaQuery.viewInsets,
            child: AlertDialog(
              content: DialogOccupied(parkingSlot),
            ),
          );
        });

    print('Slot retruned is $parkingSlotReturned');
    if (parkingSlotReturned != null &&
        parkingSlotReturned.vehicle.boolModelModified) {
      listParkingSlots[index] = parkingSlotReturned;
      updateGrid();
    } else {
      print('returned null from slot status dialog');
    }

    setState(() {});
  }

  void onChangedParkingArea(
      parkingArea, FormFieldState<ParkingArea> areaState) async {
    print('Area Selected ${parkingArea.stringParkingArea}');

    setState(() {
      _parkingArea = parkingArea;
      _parkingLot = null;
      listFinalParkingLots.clear();
      listParkingSlots?.clear();
      areaState.didChange(parkingArea);
    });

    listFinalParkingLots = await getParkingLots(_parkingArea.id, modelAgent);

    setState(() {});
  }

  void onChangedParkingLot(
      ParkingLot parkingLot, FormFieldState<ParkingLot> state) async {
    print(
        "On Changed Parkiung - Selected Parking Lot ${parkingLot.stringParkingLotName}");

    setState(() {
      _parkingLot = parkingLot;
      state.didChange(parkingLot);
    });
    if (_parkingLot.listParkingSlots != null) {
      resetTotalsIndex();
    }
    showloader(context);
    await fetchParkingSlots();
    removeloader();

    print(
        "OncHanges List PArking Slots for ${_parkingLot.stringParkingLotName} are ${listParkingSlots == null ? ' listParkingSlots is null' : listParkingSlots.length}");
  }

  Future fetchParkingSlots() async {
    print('Fetch Parking Slots');
    listParkingSlots =
        await getParkingSlots(_parkingArea.id, _parkingLot.id, boolDisabled);
    if (listParkingSlots.length > 0) {
      print('list parking slots length is ${listParkingSlots.length}');
      var stringParkingLotName = _parkingLot.stringParkingLotName;
      print('Parking lot string name is $stringParkingLotName');
      if (stringParkingLotName.isNotEmpty) {
        print('Parking lot String is not Empty now updating Totals ');
        updateTotalsIndex();
      } else {
        print('Not Updating Index');
      }

      setState(() {});
    } else {
      print('list parking slots length NOT > 0');
    }
  }

  //Shows Quick Regitration Dialog
  void showDialogQuickRegistration(ParkingSlot parkingSlot, int index) async {
    print('Show Dialog Quick Registration ');
    ParkingSlot tempParkingSlot = parkingSlot;
    print('Temp Slot Status ${tempParkingSlot.slotStatus}');
    ParkingSlot parkingSlotReturned = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: DialogQuickRegistration(tempParkingSlot),
          );
        });

    if (parkingSlotReturned != null) {
      print('After Closing Dialog $parkingSlotReturned and bool modifies '
          '${parkingSlotReturned.boolModified}');
      if (parkingSlotReturned.slotStatus == SlotStatus.reserved) {
        await Future.delayed(Duration(milliseconds: 900));
        parkingSlot = await showDialogForSlotBooking(context, parkingSlotReturned);

        parkingSlot.bookingId = null;
        parkingSlotReturned = await bookSlotAfterQuickReg(parkingSlot);

        if (parkingSlotReturned.bookingId != null) {
          parkingSlot = parkingSlotReturned;
          setState(() {});
        }
      } else if (parkingSlotReturned.slotStatus == SlotStatus.inactive &&
          parkingSlotReturned.boolModified) {
        setState(() {
          parkingSlot = parkingSlotReturned;
        });
      } else {
        parkingSlot = parkingSlotReturned;
      }
      setState(() {
        listParkingSlots[index] = parkingSlot;
      });

      updateGrid();
    } else {
      print('Dialog Quick Registration returned Null Slot - Agent Cancelled '
          'Bookiung Temp Slot ttus ${parkingSlot.slotStatus}');
      setState(() {
        parkingSlot.slotStatus = SlotStatus.vacant;
        listParkingSlots[index] = parkingSlot;
      });
    }
  }

  void showDialogReserved(ParkingSlot parkingSlot, int index) async {
    print('Show Dialog Reserved ');
    bool boolReserved = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Parking Slot ${parkingSlot.id}')),
            content: DialogReserved(parkingSlot),
          );
        });

    if (boolReserved != null && boolReserved) {
      showToast('Updating Slots');
    }

    updateGrid();
  }

  void updateGrid() async {
    await fetchParkingSlots();
  }

  void showDialogImmobilized(ParkingSlot parkingSlot, int index) async {
    showloader(context);
    ParkingSlot parkingSlotReturned = await getImmobilizedSlotDetails(parkingSlot);
    removeloader();

    if(parkingSlotReturned != null && parkingSlotReturned.vehicle
        .boolModelModified){

    setState(() {
      parkingSlot = parkingSlotReturned;
    });

    bool boolVacatedImmobilized = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Make Slot ${parkingSlot.id} active')),
            content: DialogImmobilized(parkingSlot),
          );
        });

    if (boolVacatedImmobilized != null && boolVacatedImmobilized) {
      showToast('Updating Slots');
      updateGrid();
    }

    } else {
      print('Parking slot details immobilesed null or not modified');
    }


  }

  void showDialogMakeActive(ParkingSlot parkingSlot, int index) async {
    print('Show Make Active Dialog');
    bool boolMadeChange = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text('Make Slot ${parkingSlot.slotNumber} '
                    'Active')),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () async {
                    showloader(context);
                    await makeInactiveCall(parkingSlot, 1);
                    removeloader();
                    showToast('Slot Made Active');
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'))
            ],
          );
        });

    if(boolMadeChange != null && boolMadeChange){
      updateGrid();
    }
  }
}

Future<ParkingSlot> showDialogForSlotBooking(
    BuildContext context, ParkingSlot parkingSlot) async {
  print('Show Dialog Vacant ');

  // Navigator.push(context, MaterialPageRoute(builder: (_)=> DialogOccupied(parkingSlot)));
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Book Slot')),
          content: DialogSlotBooking(parkingSlot),
        );
      });
}
