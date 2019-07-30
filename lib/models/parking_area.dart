import 'package:gcc_parking/models/parking_lot.dart';

class ParkingArea {

  String stringParkingArea = "";
  int id;

  List<ParkingLot> listParkingLots;

  ParkingArea.named({this.stringParkingArea, this.listParkingLots, this.id});

  @override
  String toString() {

    return 'string PArking Area $stringParkingArea  with id $id and list Parking '
        'lots $listParkingLots';
  }
}
