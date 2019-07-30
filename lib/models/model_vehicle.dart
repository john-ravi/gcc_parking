

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
  String area = "";
  String parkingLot= "";
  String userName= "";
  String mobile;
  bool boolModelModified;
  String userVehicleId;


  Vehicle();

  Vehicle.named({
    this.userVehicleId,
    this.mobile,
    this.vehiclePlateNumber,
    this.vehicleType,
    this.area,
    this.userId,
    this.startTime,
    this.endTime,
    this.parkingSlot,
    this.applicableFee,
    this.payementStatus,
    this.applicableFine,
    this.penalty,
    this.due,
    this.blacklisted,
    this.parkingLot,
    this.userName
  });

/*
*     /*
    * "all_slots": [
        {
            "id": "3",
            "user name": "leokanchana",
            "v_plate_no": "TN-00-EN-2345",
            "location": "Anna Nagar ",
            "Lot name": "lot-01",
            "slot number": "003",
            "Start Data & Time": "2018-12-28 16:07:00",
            "Stop Data & Time": "2018-12-28 22:00:00",
            "Applicable Fees": "50.00",
            "Payment Status": "1",
            "Applicable Fine": "0.00",
            "slot booking status": "1",
            "Profile": "http://18.191.190.195/gccparking/admin/userimg/15458928792.jpg",
            "black_list": "0"
        },
    * */

* */

  Vehicle.fromMap(Map map){
    this.vehiclePlateNumber = map["v_plate_no"].toString().replaceAll("-", "");
    this.vehicleType = map["Vehicle Type"] ?? '';
    this.userId = map["User Id"] ?? '';
    this.startTime = map["Start Data & Time"];
    this.endTime = map["Stop Data & Time"];
    this.parkingSlot = map["slot number"];
    this.applicableFee = map["Applicable Fees"];
    this.payementStatus = map["Payment Status"];
    this.applicableFine = map["Applicable Fine"];
    this.due = map["Due"] ?? '0';
    this.penalty = map["Penalty"] ?? '0';
    this.blacklisted = map["black_list"] != 0 ? true : false;
    this.parkingLot = map['Lot name'];
    this.userName = map['user name'];

  }

  @override
  String toString() {

    return vehiclePlateNumber;
  }
}
