import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/models/parking_area.dart';
import 'package:gcc_parking/models/parking_lot.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/utilsPrefs.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'package:flutter_date_picker/flutter_date_picker.dart';

import 'package:gcc_parking/utils/utilsDate.dart';

class SlotReports extends StatefulWidget {
  @override
  _SlotReportsState createState() => _SlotReportsState();
}

class _SlotReportsState extends State<SlotReports> {
  final formKey = GlobalKey<FormState>();

  List<ParkingSlot> listParkingSlots = <ParkingSlot>[];
  List<ParkingLot> listFinalParkingLots = <ParkingLot>[];
  List<ParkingArea> listParkingArea;
  ModelAgent modelAgent;

  ParkingArea _parkingArea;
  ParkingLot _parkingLot;
  ParkingSlot parkingSlot;

  DateTime dateTimeStart = DateTime.now(), dateTimeEnd;

  List<ParkingSlot> listBookingsParkingSlot = <ParkingSlot>[];

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reports'),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            buildContainerAlert(context),
            Padding(
              padding: EdgeInsets.only(right: 27.0),
            ),
          ],
        ),
        body: listParkingArea != null
            ? ListView(
                children: <Widget>[
                  Form(
                    key: formKey,
                    autovalidate: true,
                    child: buildFormFields(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          dateTimeEnd = dateTimeStart.add(Duration(days: 1));
                          listBookingsParkingSlot = await getBookingsForTheDate(
                              dateTimeStart, dateTimeEnd, parkingSlot.id);
                          if(listBookingsParkingSlot.isEmpty){
                            showToast('Bookings are empty');
                          }
                          setState(() {

                          });
                        }
                      },
                      child: Text('Get Bookings'),
                    ),
                  )
                ]..addAll(iterableListBooking()))
            : Container(),
      ),
    );
  }

  Iterable<Widget> iterableListBooking() {
    return parkingSlot != null ?
    listBookingsParkingSlot != null
        ? listBookingsParkingSlot.map((parkingSlot) =>  buildListTile(parkingSlot))
        : [Container()]
    : [Container()];
  }

  Widget buildListTile(ParkingSlot parkingSlot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: ListTile(
  title: Text('${parkingSlot.vehicle.vehiclePlateNumber} - ${parkingSlot
        .vehicle.vehicleType}'??
        ''),
  subtitle: Text('Time In - ${dateFormat.format(parkingSlot.dateTimeStart)} \n'
  'Time Out - ${dateFormat.format(parkingSlot.dateTimeEnd)}'),

  ),
    );
  }

  Widget buildFormFields() {
    return Container(
      margin: EdgeInsets.all(24.0),
      child: Column(
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
          listParkingSlots != null && listParkingSlots.length != 0
              ? FormField<ParkingSlot>(
                  builder: buildDropDownParkingSlot,
                  validator: validateParkingSlot,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimePickerFormField(
              dateOnly: true,
              editable: false,
              initialDate: DateTime.now(),
              format: dateFormatDateOnly,
              decoration: InputDecoration(labelText: 'Start Date'),
              onChanged: (dt) {
                print('onChanged Start Date $dt');
                setState(() => dateTimeStart = dt);
              },
              validator: validateDate,
            ),
          )
        ],
      ),
    );
  }

  void _setDate() {
    Navigator.of(context).pop();

    dateTimeStart = showToast(dobKey.currentState.dobDate +
        ' ${dobKey.currentState.dobStrMonth}' +
        ' ${dobKey.currentState.dobYear}');
  }

  Widget buildDropDownParkingLot(FormFieldState<ParkingLot> state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: _parkingArea.stringParkingArea == '' ? '' : 'Parking Lot',
          labelStyle: TextStyle(color: Colors.blue),
          errorText: state.hasError ? state.errorText : null,
        ),
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<ParkingLot>(
            disabledHint: Text('Please select Parking Area'),
            value: _parkingLot,
            isDense: true,
            onChanged: (parkingLot) => onChangedParkingLot(parkingLot, state),
            items: generateDropMenuParkingLot(),
          ),
        ),
      ),
    );
  }

  Widget buildDropDownParkingSlot(FormFieldState<ParkingSlot> state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Parking Slot',
          labelStyle: TextStyle(color: Colors.blue),
          errorText: state.hasError ? state.errorText : null,
        ),
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<ParkingSlot>(
            disabledHint: Text('Please select Parking Slot'),
            value: parkingSlot,
            isDense: true,
            onChanged: (parkingSlot) => onChangedParkingSlot(parkingSlot, state),
            items: generateDropMenuParkingSlot(),
          ),
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

  List<DropdownMenuItem<ParkingSlot>> generateDropMenuParkingSlot() {
    return listParkingSlots.map((ParkingSlot value) {
      var stringParkingLotName = value.id;
      //    print('Lot Menu Item Name $stringParkingLotName');
      return new DropdownMenuItem<ParkingSlot>(
        value: value,
        child: new Text(stringParkingLotName.toString() ?? ""),
      );
    }).toList();
  }

  Widget buildParkingArea(FormFieldState<ParkingArea> areaState) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Parking Area',
          labelStyle: TextStyle(color: Colors.blue),
          errorText: areaState.hasError ? areaState.errorText : null,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ParkingArea>(
              value: _parkingArea,
              items: listParkingArea.map((parkingArea) {
                return DropdownMenuItem<ParkingArea>(
                  child: Text(parkingArea.stringParkingArea),
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

    if (_parkingLot != parkingLot) {
      setState(() {
        parkingSlot = null;
        _parkingLot = parkingLot;
        state.didChange(parkingLot);
      });
      if (_parkingLot.listParkingSlots != null) {}
      showloader(context);
      await fetchParkingSlots();
      removeloader();

      print(
          "OncHanges List PArking Slots for ${_parkingLot.stringParkingLotName} are ${listParkingSlots == null ? ' listParkingSlots is null' : listParkingSlots.length}");
    }
  }

  Future fetchParkingSlots() async {
    print('Fetch Parking Slots');
    listParkingSlots =
        await getParkingSlots(_parkingArea.id, _parkingLot.id, false);
    if (listParkingSlots.length > 0) {
      print('list parking slots length is ${listParkingSlots.length}');
      var stringParkingLotName = _parkingLot.stringParkingLotName;
      print('Parking lot string name is $stringParkingLotName');
      if (stringParkingLotName.isNotEmpty) {
        print('Parking lot String is not Empty now updating Totals ');
      } else {
        print('Not Updating Index');
      }

      setState(() {});
    } else {
      print('list parking slots length NOT > 0');
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

  String validateParkingSlot(ParkingSlot val) {
    if (val != null) {
      return val.id != null ? null : 'Select Parking Slot';
    } else {
      print('VAlidation val is null');
      return 'Select Slot';
    }
  }

  void initEverything() async {
    print("InitsEverything");

    modelAgent = await getAgentFromPrefs();
    listParkingArea = await getParkingAreas(modelAgent);

    setState(() {});
  }

  onChangedParkingSlot(ParkingSlot parkingSlot, FormFieldState<ParkingSlot> state) {
    setState(() {
      this.parkingSlot = parkingSlot;
      state.didChange(parkingSlot);
    });

    print('Onchanged Slot $parkingSlot');
  }
}
