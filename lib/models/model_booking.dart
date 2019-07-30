import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/models/parking_slot.dart';

class ModelBooking{
  /*"uid": "11",
    "v_plate_no": "AP-09-TT-0987",
    "Current Booking": null,
    "all_slots": [
        {
            "user_id": "48",
            "user name": "dindora",
            "v_plate_no": "DD-22-WW-656",
            "vehicle type": "CAR",
            "slot_booking_id": "16",
            "slot_booking_Location": null,
            "slot_booking_Lot": null,
            "slot_booking_slot": "005",
            "location": null,
            "Lot name": null,
            "slot number": "005",
            "Start Data & Time": "0000-00-00 00:00:00",
            "Stop Data & Time": "2019-01-25 15:50:00",
            "arrivel Data & Time": "0000-00-00 00:00:00",
            "depar_time": "0000-00-00 00:00:00",
            "Fee": "0.00",
            "Fine": "0.00",
            "Penalty": "0.00",
            "Due": "0.00",
            "payment_status": "1",
            "booking status": "3"*/

  Vehicle modelVehicle;
  var currentBooking;
  var slotBookID;
  var slotBookingLoc;
  var lotBookingID;
  var slotBookingID;
  var area;
  var lotID;
  var slotNum;
  var startTime;
  var endTime;
  var arriveTime;
  var deparTime;
  var fee;
  var fine;
  var penalty;
  var due;
  var payStatus;
  var bookingStatus;


  ModelBooking.named( this.modelVehicle, this.currentBooking,
      this.slotBookID, this.slotBookingLoc, this.lotBookingID,
      this.slotBookingID, this.area, this.lotID,this.slotNum, this.startTime,
      this.endTime, this.arriveTime, this.deparTime, this.fee, this.fine,
      this.penalty, this.due, this.payStatus, this.bookingStatus);
  /*
  * "uid": "11",
    "v_plate_no": "AP-09-TT-0987",
    "Current Booking": null,
    "all_slots":  [
        {

            "user_id": "1",
            "user name": "lakan",
            "v_plate_no": "AP-09-AP-0123",
            "vehicle type": "CAR",
            "slot_booking_id": "13",
            "slot_booking_Location": null,
            "slot_booking_Lot": null,
            "slot_booking_slot": "009",
            "location": null,
            "Lot name": null,
            "slot number": "009",
            "Start Data & Time": "0000-00-00 00:00:00",
            "Stop Data & Time": "2019-01-25 14:46:00",
            "arrivel Data & Time": "2019-01-25 13:46:00",
            "depar_time": "0000-00-00 00:00:00",
            "Fee": "0.00",
            "Fine": "0.00",
            "Penalty": "0.00",
            "Due": "0.00",
            "payment_status": "1",
            "booking status": "3"
        },*/
  ModelBooking.fromMap(Map search){
    this.slotBookID=search['slot_booking_id'];
    this.area=search['location'];
    this.lotID=search['Lot name'];
    this.slotNum=search['slot number'];
    this.startTime=search['Start Data & Time'];
    this.endTime=search['Stop Data & Time'];
    this.arriveTime=search['arrivel Data & Time'];
    this.deparTime=search['depar_time'];
    this.fee=search['Fee'];
    this.fine=search['Fine'];
    this.penalty=search['Penalty'];
    this.due=search['Due'];
    this.payStatus=search['payment_status'];
    this.bookingStatus=search['booking status'];

  }

  @override
  String toString() {
    return 'ModelBooking{modelUser id: ${modelVehicle.userId}, modelVehicle: '
        '$modelVehicle, ''slotBookID: ''$slotBookID, area: $area}';
  }
}