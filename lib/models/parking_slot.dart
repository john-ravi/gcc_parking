import 'model_vehicle.dart';

enum SlotStatus { occupied, vacant, inactive, pending }

class ParkingSlot {

  SlotStatus slotStatus;

  String slotName = "";
  Vehicle vehicle;

  ParkingSlot.named({this.slotName, this.slotStatus, this.vehicle});

}
