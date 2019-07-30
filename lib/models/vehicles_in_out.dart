
class CheckedVehiclesIn_Out{
  /*{
"all_slots": [
        {
            "slot_b_id": "2",
            "uid": "1",
            "uname": "lakan",
            "v_plate_no": "AP-09-AP-0123",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "p_slot_id": "1",
            "slot_number": "001",
            "Start Date& Time": "2019-01-24 05:00:00",
            "Stop Date& Time": "2019-01-24 06:37:00",
            "Fee Amount": "50.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "4",
            "Penalty Amount": "0.00",
            "Due Amount": "0.00"
        }
    ]}*/
  var userID;
  var userName;
  var vehicleNumber;
  var area;
  var lotName;
  var slotNumber;
  var startTime;
  var endTime;
  var fee;
  var fine;
  var paymentStatus;
  var slotStatus;
  var penalty;
  var due;
  var slotId;

  CheckedVehiclesIn_Out.name(this.userID, this.userName, this.vehicleNumber, this.area,
      this.lotName, this.slotNumber, this.startTime, this.endTime, this.fee,
      this.fine, this.paymentStatus, this.slotStatus, this.penalty, this.due);
  /*"{
    "all_slots": [
        {
            "slot_b_id": "2",
            "uid": "1",
            "uname": "lakan",
            "v_plate_no": "AP-09-AP-0123",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "p_slot_id": "1",
            "slot_number": "001",
            "Start Date& Time": "2019-01-24 05:00:00",
            "Stop Date& Time": "2019-01-24 06:37:00",
            "Fee Amount": "50.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "4",
            "Penalty Amount": "0.00",
            "Due Amount": "0.00"
        }
    ]
}
    ]*/
  CheckedVehiclesIn_Out.fromMap(Map map){
    this.userID=map['uid'];
    this.userName=map['uname'];
    this.vehicleNumber=map['v_plate_no'];
    this.area=map['location'];
    this.lotName=map['Lot name'];
    this.slotNumber=map['p_slot_id'];
    this.startTime=map['Start Date& Time'];
    this.endTime=map['Stop Date& Time'];
    this.fee=map['Fee Amount'];
    this.fine=map['Fine Amount'];
    this.paymentStatus=map['Payment Status'];
    this.slotStatus=map['Slot status'];
    this.penalty=map['Penalty Amount'];
    this.due=map['Due Amount'];
    this.slotId=map['p_slot_id'];
  }
  @override
  String toString() {
    return 'Checked In Vehicles{user Name:$userName, user ID:$userID, Vehicle number:$vehicleNumber, '
        'Loction:$area, Slot Number:$slotNumber, Start Date&Time:$startTime, EndDate&Time:$endTime, '
        'fee Amount:$fee, Fine Amount:$fine, Payment Status:$paymentStatus, Slot status:$slotStatus, '
        'Penalty Amount:$penalty, Due Amount:$due}';
  }

}