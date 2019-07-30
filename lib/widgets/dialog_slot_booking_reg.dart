import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/models/vehicle_type.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/stringUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';

import 'package:gcc_parking/widgets/ensure_focus.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class DialogSlotBooking extends StatefulWidget {
  final ParkingSlot parkingSlot;

  DialogSlotBooking(this.parkingSlot);

  @override
  _DialogSlotBookingState createState() => _DialogSlotBookingState(parkingSlot);
}

class _DialogSlotBookingState extends State<DialogSlotBooking> {
  final ParkingSlot parkingSlot;

  final keyAddBookingDetails = GlobalKey<FormState>();

  _DialogSlotBookingState(this.parkingSlot);

  List<SlotStatus> listModifiedStatus;

  FocusNode focusVehicleNumber1 = FocusNode();
  final controllerFee = TextEditingController();

  final dateFormat = DateFormat("d/M/yyyy h:mm a");
  DateTime dateTimeStart, dateTimeEnd;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildForm(),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: RaisedButton(
              onPressed: updateSlotState,
              child: Text('Book Slot'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Form(
          autovalidate: true,
          key: keyAddBookingDetails,
          child: Column(
            children: <Widget>[
              Table(
                children: tableChildren(),
              ),
            ],
          )),
    );
  }

  List<TableRow> tableChildren() {
    return [
      TableRow(
        children: [
          DateTimePickerFormField(
            editable: false,
            firstDate: DateTime.now(),
            initialDate: DateTime.now().add(Duration(seconds: 1)),
            lastDate: DateTime.now().add(Duration(hours: 3)),
            initialTime:
                TimeOfDay.fromDateTime(DateTime.now().add(Duration(seconds: 1))),
            format: dateFormat,
            decoration: InputDecoration(labelText: 'Start Date Time'),
            onChanged: (dt) {
              print('onChanged Start Date $dt');
              setState(() => dateTimeStart = dt);
            },
            validator: validateStartDate,
          ),
        ],
      ),
      TableRow(
        children: [
          dateTimeStart != null
              ? DateTimePickerFormField(
                  editable: false,
                  firstDate: dateTimeStart,
                  initialDate: dateTimeStart,
                  initialTime:
                      TimeOfDay.fromDateTime(dateTimeStart.add(Duration(hours: 1))),
                  format: dateFormat,
                  decoration: InputDecoration(labelText: 'End Date Time'),
                  onChanged: (dt) => setState(() => dateTimeEnd = dt),
                  validator: validateDate,
                )
              : Container(),
        ],
      ),
      TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Fee:',
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controllerFee,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) => value.length < 2 ? 'Enter Fee' : null,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }

  String validateStartDate(DateTime date) {
    try {
      print('printing stat Date  $date');
      var difference = date.difference(DateTime.now());
      print('Difference $difference');
      var duration = Duration(hours: 3);
      print('Duration 3 hours $duration');
      var compareTo = difference.compareTo(duration);
      print('Compare to $compareTo');
      if (compareTo > 0) {
        return 'Start Time longer than 3 hours from now';
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return 'Select Date Time';
    }
  }

  String validateDate(DateTime date) {
    try {
      print('printing Date  $date');
      if (date.isAfter(dateTimeStart)) {
        return null;
      } else {
        return 'End Date Time should be after Start Time';
      }
    } catch (e) {
      print(e);
      return 'Select Date Time';
    }
  }

  updateSlotState() {
    if (keyAddBookingDetails.currentState.validate()) {
      setState(() {
        parkingSlot.dateTimeStart = dateTimeStart;
        parkingSlot.dateTimeEnd = dateTimeEnd;
        parkingSlot.vehicle.due = '0';
        parkingSlot.vehicle.applicableFee = controllerFee.text;
      });
      print('printing parking slot from add details $parkingSlot');
      Navigator.of(context).pop(parkingSlot);
    }
  }
}
