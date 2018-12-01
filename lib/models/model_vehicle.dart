
class Vehicle {
  String vehiclePlateNumber="";
  String vehicleType="";
  String userId="";
  String startTime="";
  String endTime="";
  String parkingSlot="";
  String applicableFee="";
  String payementStatus="";
  String applicableFine="";
  String penalty="";
  String due="";
  bool blacklisted= false;

  Vehicle();

  Vehicle.named({
    this.vehiclePlateNumber,
    this.vehicleType,
    this.userId,
    this.startTime,
    this.endTime,
    this.parkingSlot,
    this.applicableFee,
    this.payementStatus,
    this.applicableFine,
    this.penalty,
    this.due,
    this.blacklisted
  });
/*
*
* "Vehicle Plate Number": "TN-09-PN-0000",
            "Vehicle Type": "bus",
            "User Id": "1",
            "Start Time": "02:00:00",
            "End Time": "00:30:00",
            "Parking Slot": "slot2",
            "Applicable Fee": "20",
            "Payement Status": "1",
            "Applicable Fine": "20",
            "Penalty": "10",
            "Due": "30",
            "Profile": "http://18.191.190.195/gccparking/admin/"
*
*
*/


  Vehicle.fromMap(Map map){
    this.vehiclePlateNumber = map["Vehicle Plate Number"].toString().replaceAll("-", "");
    this.vehicleType = map["Vehicle Type"];
    this.userId = map["User Id"];
    this.startTime = map["Start Time"];
    this.endTime = map["End Time"];
    this.parkingSlot = map["Parking Slot"];
    this.applicableFee = map["Applicable Fee"];
    this.payementStatus = map["Payement Status"];
    this.applicableFine = map["Applicable Fine"];
    this.due = map["Due"];
    this.penalty = map["Penalty"];
    this.blacklisted = map["Black List"] != 0 ? true : false;
  }

  @override
  String toString() {

    return vehiclePlateNumber;
  }
}
