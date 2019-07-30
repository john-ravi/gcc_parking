import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_parking/models/model_vehicle.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/models/vehicle_type.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/stringUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'package:gcc_parking/widgets/dialog_slot_booking_reg.dart';

class DialogQuickRegistration extends StatefulWidget {
  final ParkingSlot parkingSlot;

  DialogQuickRegistration(this.parkingSlot);

  @override
  _DialogQuickRegistrationState createState() =>
      _DialogQuickRegistrationState(parkingSlot);
}

class _DialogQuickRegistrationState extends State<DialogQuickRegistration> {
  ParkingSlot parkingSlot;

  TextEditingController controllerPlateNumber1 = new TextEditingController();
  TextEditingController controllerPlateNumber2 = new TextEditingController();
  TextEditingController controllerPlateNumber3 = new TextEditingController();
  TextEditingController controllerPlateNumber4 = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerMobile = new TextEditingController();

  bool formValidated = false;
  var padding = const EdgeInsets.all(0.0);

  bool boolChangeToOccupied = false;
  bool slotStateChanged = false;
  SlotStatus _slotStatus;
  List<SlotStatus> listModifiedStatus;
  final stringRegisterUser = 'Register User';
  final stringCheckVehicle = 'Check Vehicle Number';
  final stringUpdateState = 'Update State';
  final stringContinueBooking = 'Continue to Booking';
  Vehicle vehicle;

  String stringButton;

  bool boolVehicleChecked;

  final formStateChangeKey = GlobalKey<FormState>();
  final formVehicleInputKey = GlobalKey<FormState>();
  VehicleTypeModel _vehicleTypeModel;

  _DialogQuickRegistrationState(this.parkingSlot);

  @override
  void initState() {
    List<SlotStatus> list = SlotStatus.values;
    print(' list $list');
    listModifiedStatus = list.toList(growable: true);
    listModifiedStatus.removeWhere((slotStatus) =>
        slotStatus == SlotStatus.pending ||
        slotStatus == SlotStatus.vacant ||
        slotStatus == SlotStatus.reserved ||
        slotStatus == SlotStatus.immobilized);
    print('removed pending list $listModifiedStatus');

    stringButton = stringUpdateState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Update State',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          buildStatusChangeForm(),
          boolChangeToOccupied ? buildVehiclAndUser() : Container(),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: RaisedButton(
              color: Colors.blueGrey,
              onPressed: onPressed,
              child: Center(child: Text(stringButton, textAlign: TextAlign.center,)),
            ),
          ),
        ],
      ),
    );
  }

  Form buildStatusChangeForm() {
    return Form(
      autovalidate: true,
      key: formStateChangeKey,
      child: FormField(
          validator: validateStatusChange,
          builder: (FormFieldState<SlotStatus> stateSlotStatus) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: 'Slot Status ',
                errorText: stateSlotStatus.errorText,
              ),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<SlotStatus>(
                      value: _slotStatus,
                      items: listModifiedStatus.map((slotStatus) {
                        return DropdownMenuItem<SlotStatus>(
                          value: slotStatus,
                          child: Text(fetchSlotStatus(slotStatus)),
                        );
                      }).toList(),
                      onChanged: (slotStatus) {
                        stateSlotStatus.didChange(slotStatus);
                        setState(() {
                          print('Slot status changed to $slotStatus');
                          slotStateChanged = true;

                          _slotStatus = slotStatus;
                          if (slotStatus == SlotStatus.occupied) {
                            boolChangeToOccupied = true;
                            stringButton = stringCheckVehicle;
                          } else {
                            boolChangeToOccupied = false;
                            stringButton = stringUpdateState;
                          }
                            parkingSlot.slotStatus = slotStatus;
                          print('bool Changed to Occupied $boolChangeToOccupied');
                        });
                      })),
            );
          }),
    );
  }

  String validateStatusChange(var value) {
    print('validate State change $value');
    if (value != null) {
      return null;
    } else {
      return 'Select New Slot Status';
    }
  }

  final _userName = FocusNode();
  final _userMob = FocusNode();
  final _vehicle1 = FocusNode();
  final _vehicle2 = FocusNode();
  final _vehicle3 = FocusNode();
  final _vehicle4 = FocusNode();

  Form buildVehiclAndUser() {
    return Form(
      autovalidate: true,
      key: formVehicleInputKey,
      child: Column(
        children: <Widget>[
          buildVehicleInputRow(),
          boolVehicleChecked != null ? buildUserAndMobile() : Container(),
        ],
      ),
    );
  }

  void onPressed() async {
    if (formStateChangeKey.currentState.validate()) {
      if (parkingSlot.slotStatus == SlotStatus.inactive) {
        showloader(context);
        bool name = await makeInactiveCall(parkingSlot, 5);
        removeloader();
        if (name) {
          showToast('Slot ${parkingSlot.id} Made Inactive');
          parkingSlot.boolModified = true;
        } else {
          parkingSlot.boolModified = false;
        }
        Navigator.of(context).pop(parkingSlot);
      } else { //Slot Stauts is Occupied
        if (formVehicleInputKey.currentState.validate()) {
          String vehicleNumber = getVehicleNumber();
          print('bool vehicle checked $boolVehicleChecked');
          if (boolVehicleChecked == null) {
            showloader(context);
             vehicle = await getUserFromVehicle(vehicleNumber);
             removeloader();
             print('Returned Get User From Vehicle $vehicle');
             if(vehicle != null) {
               setState(() {
                 boolVehicleChecked = true;
                 stringButton = stringContinueBooking;
                 parkingSlot.vehicle = vehicle;

               });
             } else {
               setState(() {
                 boolVehicleChecked = false;
                 stringButton = stringContinueBooking;

               });
             }

          } else if(boolVehicleChecked == true){
            showToast('Please Wait.. to Book');
            parkingSlot.slotStatus = SlotStatus.reserved;
            Navigator.of(context).pop(parkingSlot);

          } else {
            String userName =
                controllerName.text == '' ? '  ' : controllerName.text;
            String mobile = controllerMobile.text;

            var vehicle = await makeOccupiedCall(userName, mobile, vehicleNumber);
            if (vehicle.boolModelModified) {
              setState(() {
                if (parkingSlot.vehicle != null) {
                  parkingSlot.vehicle = vehicle;
                  setState(() {});
                } else {
                  print(
                      'Parking Slot Vehicle is null creating Vehicle number to add '
                          'Plate Number ');
                  parkingSlot.vehicle =
                      Vehicle.named(vehiclePlateNumber: vehicleNumber);
                }

                parkingSlot.slotStatus = SlotStatus.reserved;
              });
              print('printing parking slot from quick registration $parkingSlot');

              Navigator.of(context).pop(parkingSlot);
            } else {
              showToast('Error - Please Retry');
            }
          }
        }
      }
    } else {
      showToast('Select Slot Status');
    }
  }

  Row buildVehicleInputRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: padding,
            child: Container(
              width: 16.0,
              child: TextFormField(
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                controller: controllerPlateNumber1,
                focusNode: _vehicle1,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(hintText: 'AP'),
                validator: validatePlateNum,
                onSaved: (value) {
                  print(value.toUpperCase());
                },
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[A-Za-z]')),
                  LengthLimitingTextInputFormatter(2),
                ],
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_vehicle2);
                },
              ),
            ),
          ),
        ),
        Text("-"),
        Expanded(
          child: Padding(
            padding: padding,
            child: Container(
              width: 16.0,
              child: TextFormField(
                focusNode: _vehicle2,
                textAlign: TextAlign.center,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
                controller: controllerPlateNumber2,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(hintText: '08'),
                keyboardType: TextInputType.number,
                validator: validatePlateNum,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_vehicle3);
                },
              ),
            ),
          ),
        ),
        Text("-"),
        Expanded(
          child: Padding(
            padding: padding,
            child: Container(
              width: 16.0,
              child: TextFormField(
                focusNode: _vehicle3,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                controller: controllerPlateNumber3,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(hintText: 'EG'),
                validator: validatePlateNumMiddle,
                onSaved: (value) {
                  print(value.toUpperCase());
                },
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[A-Za-z]')),
                  LengthLimitingTextInputFormatter(2),
                ],
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_vehicle4);
                },
              ),
            ),
          ),
        ),
        Text("-"),
        Expanded(
          child: Padding(
            padding: padding,
            child: Container(
              width: 16.0,
              child: TextFormField(
                focusNode: _vehicle4,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5)
                ],
                controller: controllerPlateNumber4,
                decoration: new InputDecoration(hintText: '99999'),
                keyboardType: TextInputType.number,
                validator: validatePlateNumFour,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String validatePlateNum(value) {
    print('plane two length - $value');
    if (value.length != 2) {
      return "Enter";
    }
    return null;
  }

  String validatePlateNumMiddle(value) {
    print('plane two length - $value');
    if (value.length < 1) {
      return "Enter";
    }
    return null;
  }

  String validatePlateNumFour(String value) {
    print('four value - ${value.length}');
    if (value.length < 3) {
      return "enter";
    }
    return null;
  }

  Future<Vehicle> makeOccupiedCall(
      String userName, String mobile, String vehicleNumber) async {
    print('Make Occupied Call');
    Vehicle vehicle = Vehicle.named(
        userName: userName, mobile: mobile, vehiclePlateNumber: vehicleNumber);
    Vehicle vehicleReturned = await quickRegistration(vehicle);

    vehicle = vehicleReturned;
    print('Result Quick Regi ${vehicle.boolModelModified}');
    return vehicle;
  }

  String getVehicleNumber() {
    return controllerPlateNumber1.text +
        '-' +
        controllerPlateNumber2.text +
        '-' +
        controllerPlateNumber3.text +
        '-' +
        controllerPlateNumber4.text;
  }

  Widget buildUserAndMobile() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start  ,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: vehicle == null ?
                Container(
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: controllerName,
                    focusNode: _userName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      hintText: 'User Name',
                    ),
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(_userMob);
                    },
                  ),
                )
                    : Text('Name - ${vehicle.userName}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: vehicle == null ? Container(
                  child: TextFormField(
                    validator: (value) => value.length != 10 ? 'Enter 10 digit mobile' : null,
                    maxLines: 1,
                    autofocus: false,
                    controller: controllerMobile,
                    focusNode: _userMob,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Mobile',
                      hintText: 'Mobile',
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(_vehicle1);
                    },
                  ),
                )
                    : Text('Mobile - ${vehicle.mobile}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: vehicle == null
                    ? FormField(
                  builder: (FormFieldState<VehicleTypeModel> stateVehicleType) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Vehicle Type',
                        errorText: stateVehicleType.hasError
                            ? stateVehicleType.errorText
                            : null,
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<VehicleTypeModel>(
                              value: _vehicleTypeModel,
                              items:
                              listVehicleTypes.map((VehicleTypeModel vehicleType) {
                                return DropdownMenuItem<VehicleTypeModel>(
                                  value: vehicleType,
                                  child: Text(vehicleType.vehicleClass),
                                );
                              }).toList(),
                              onChanged: (VehicleTypeModel vehicleType) {
                                setState(() {
                                  _vehicleTypeModel = vehicleType;
                                });
                                stateVehicleType.didChange(_vehicleTypeModel);
                              })),
                    );
                  },
                  validator: (vehicleType) =>
                  vehicleType == null ? 'Please Select Vehicle Type' : null,
                )
                    : Text('Vehicle Type - ${vehicle.vehicleType}'),
              ),
            ],),
          ),
        ],
      ),
    );
  }
}
