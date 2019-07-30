import 'package:gcc_parking/models/parking_slot.dart';

class ParkingLot {

  String stringParkingLotName = "";

  List<ParkingSlot> listParkingSlots;
  int id;

  ParkingLot.named({this.stringParkingLotName, this.listParkingSlots, this.id});

  @override
  String toString() {

    return 'string PArking Lot NAme $stringParkingLotName and list Parking slots $listParkingSlots';
  }
}
