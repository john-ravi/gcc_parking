import 'model_vehicle.dart';

enum SlotStatus { occupied, vacant, inactive, pending, reserved, immobilized }

class ParkingSlot {
  SlotStatus slotStatus;
/*
* {
"all_slots": [
        {
            "slot_b_id": "22",
            "uname": "uue",
            "v_plate_no": "AP-08-EG-1038",
            "location": "Anna Nagar ",
            "Lot name": "lot-02",
            "p_slot_id": "112",
            "Start Date& Time": "2019-01-25 10:53:03",
            "Stop Date& Time": "2019-01-25 16:22:00",
            "Fee Amount": "0.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "3",
            "Penalty Amount": "0.00",
            "Due Amount": "0.00"
        },* */

  int id;
  String slotName = "";
  Vehicle vehicle;
  String slotNumber;
  DateTime dateTimeStart, dateTimeEnd;
  int bookingId;
  String location, lot;
  String fee, fine, paymentStatus, penalty, due;
  bool boolModified;

  ParkingSlot.named(
      {this.id,
      this.slotName,
      this.slotStatus,
      this.vehicle,
      this.slotNumber,
      this.dateTimeStart,
      this.dateTimeEnd, this.bookingId,
      this.location,
        this.lot,
        this.fee,
        this.fine,
        this.due,
        this.penalty,
        this.paymentStatus
      });

  @override
  String toString() {
    String plateNum = vehicle.vehiclePlateNumber;
    return plateNum ?? 'Nullifyd';
  }
}
