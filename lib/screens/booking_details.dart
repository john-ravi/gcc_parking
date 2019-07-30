import 'package:flutter/material.dart';
import 'package:gcc_parking/models/model_booking.dart';

class BookingDetails extends StatefulWidget {
  List<ModelBooking> userDetail;
  BookingDetails(this.userDetail);

  @override
  _BookingDetailsState createState() => _BookingDetailsState(userDetail);
}

class _BookingDetailsState extends State<BookingDetails> {
  List<ModelBooking> userDetail;

  _BookingDetailsState(this.userDetail);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(shrinkWrap: true,
          children: <Widget>[
            ListView.builder(shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Column(
                      children: <Widget>[
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:<Widget>[
                            Flexible(child: Text('User ID :')),
                            Flexible(child: Text('${userDetail[index].modelVehicle.userId}'))
                          ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text('User Name :')),
                            Flexible(child: Text('${userDetail[index].modelVehicle.userName}'))
                          ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child:Text('Vehicle Number :') ),
                            Flexible(child: Text('${userDetail[index]
                                .modelVehicle.vehiclePlateNumber}'))
                          ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text('Vehicle Type :')),
                            Flexible(child: Text('${userDetail[index].modelVehicle.vehicleType}'))
                          ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text('Location :')),
                            Flexible(child: Text('${userDetail[index].area}'))
                          ],),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(child: Text('Lot Name :')),
                              Flexible(child: Text('${userDetail[index].lotID}',textAlign: TextAlign.end,))
                            ],),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text('Slot Number :')),
                            Flexible(child: Text('${userDetail[index].slotNum}'))
                          ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text('Start Date& Time :')),
                            Flexible(child: Text('${userDetail[index].startTime}',textAlign: TextAlign.end,))
                          ],),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text('End Date& Time :')),
                            Flexible(child: Text('${userDetail[index].endTime}',textAlign: TextAlign.end,))
                          ],),
                      ],
                    ),
                  ),
                );
              },
              controller: ScrollController(),
              itemCount: userDetail.length,
            ),
          ],
        ),
      ),
    );
  }
}
