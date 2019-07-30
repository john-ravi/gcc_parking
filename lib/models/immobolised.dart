
class Immobolised{
  /*{
    "all_slots": [
        {
            "id": "3",
            "uname": "leokanchana",
            "v_plate_no": "TN-00-EN-2345",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "slot number": "003",
            "Start Date& Time": "2018-12-28 16:07:00",
            "Stop Date& Time": "2018-12-28 22:00:00",
            "Fee Amount": "50.00",
            "Fine Amount": "0.00",
            "Payment Status": "1",
            "Slot status": "5",
            "Penalty Amount": "50.00",
            "Due Amount": "0.00"
        }
    ]
}*/
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
  var payment;
  var slotStatus;
  var penaltyAmount;
  var dueAmount;

  Immobolised.named({this.userID, this.userName, this.vehicleNumber, this.area,
      this.lotName, this.slotNumber, this.startTime, this.endTime, this.fee,
      this.fine, this.payment, this.slotStatus, this.penaltyAmount,
      this.dueAmount});
Immobolised.fromMap(Map map){
  this.userID=map['id'];
  this.userName=map['uname'];
  this.vehicleNumber=map['v_plate_no'];
  this.area=map['location'];
  this.lotName=map['Lot name'];
  this.slotNumber=map['slot_number'];
  this.startTime=map['Start Date& Time'];
  this.endTime=map['Stop Date& Time'];
  this.fee=map['Fee Amount'];
  this.fine=map['Fine Amount'];
  this.payment=map['Payment Status'];
  this.slotStatus=map['Slot status'];
  this.penaltyAmount=map['Penalty Amount'];
  this.dueAmount=map['Due Amount'];

}

  @override
  String toString() {
    return 'Immobolised{userName: $userName, vehicleNumber: $vehicleNumber, slotNumber: $slotNumber, dueAmount: $dueAmount}';
  }

}