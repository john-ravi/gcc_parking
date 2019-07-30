/*
* Vehicle Parking Slot Dimension ECS
Car 5 m x 2 m 1
Two Wheeler 2 m x 1.25 m 0.25
Auto rickshaw 3 m x 1.5-2 m 0.6
Cycle rickshaw 2.5 m x 1 m 0.5
Bus 15m x 2.6 m 3.9
HCV 2.4m x 9m 2.2
LCV 2 m x 5m 1
Mini Bus 2.6m x 8m 1.5
* */
class VehicleTypeModel {
  String vehicleClass;
  String vehicleDimensions;
  String vehicleECSValue;
  int parkingFee;
  int vid;

  VehicleTypeModel.named(
      {this.vehicleClass, this.vehicleDimensions, this.vehicleECSValue, this
          .parkingFee, this.vid});

}
