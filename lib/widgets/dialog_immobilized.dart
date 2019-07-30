import 'package:flutter/material.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';

class DialogImmobilized extends StatefulWidget {
  final ParkingSlot parkingSlot;

  DialogImmobilized(this.parkingSlot);

  @override
  _DialogImmobilizedState createState() => _DialogImmobilizedState(parkingSlot);
}

class _DialogImmobilizedState extends State<DialogImmobilized> {
  ParkingSlot parkingSlot;
  final controllerComments = TextEditingController();
  bool inProgress = false;

  _DialogImmobilizedState(this.parkingSlot);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration(labelText: 'Comments'),
                maxLines: 3,
                controller: controllerComments,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(child: FlatButton(onPressed: inProgress ? null : () {
                Navigator.of(context).pop(false);
              }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No'),
              ))),
              Flexible(child: FlatButton(onPressed: inProgress ? null : () async {
                if(controllerComments.text.isNotEmpty){
                  showloader(context);
                  await vacateSlot(parkingSlot, controllerComments.text);
                  removeloader();
                  Navigator.of(context).pop(true);

                } else {
                  showToast('Comments Cannot be Empty');
                }
              }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Yes'),
              )))
            ],
          ),
        )
      ],
    );
  }
}
