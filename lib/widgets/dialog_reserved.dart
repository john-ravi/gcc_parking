import 'package:flutter/material.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';

class DialogReserved extends StatefulWidget {
  final ParkingSlot parkingSlot;

  DialogReserved(this.parkingSlot);

  @override
  _DialogReservedState createState() => _DialogReservedState();
}

class _DialogReservedState extends State<DialogReserved> {
  List<ParkingSlot> listSlotBookings = [];

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  initEverything() async {
    listSlotBookings = await getReservedBooking(widget.parkingSlot);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return listSlotBookings.length == 0
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[CircularProgressIndicator()],
          )
        : ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              //  var startDate = dateFormat.format(widget.parkingSlot.dateTimeStart);
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('${listSlotBookings[index].vehicle}'),
                    ),
                    Text(
                      'Start Time ${dateFormat.format(listSlotBookings[index].dateTimeStart)}',
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Center(
                          child: RaisedButton(
                        onPressed: () async {
                          await logVehicleIn(listSlotBookings[index]);
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Confirm Booking'),
                      )),
                    )
                  ],
                ),
              );
            },
            itemCount: listSlotBookings.length,
          );
  }
}
