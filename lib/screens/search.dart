import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/screens/booking_details.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'package:validate/validate.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controllerPlateNumber01 = new TextEditingController();
  TextEditingController controllerPlateNumber02 = new TextEditingController();
  TextEditingController controllerPlateNumber03 = new TextEditingController();
  TextEditingController controllerPlateNumber04 = new TextEditingController();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  String uid;
  bool _validate = false;
  final _vehicle01 = FocusNode();
  final _vehicle02 = FocusNode();
  final _vehicle03 = FocusNode();
  final _vehicle04 = FocusNode();
  String getVechNum() {
    return controllerPlateNumber01.text +
        '-' +
        controllerPlateNumber02.text +
        '-' +
        controllerPlateNumber03.text +
        '-' +
        controllerPlateNumber04.text;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: true,
          title: Center(child: Text('Search'), ),
          actions: <Widget>[
            buildContainerAlert(context),
            Padding(padding: EdgeInsets.only(right: 24.0))
          ],

        ),
        body: BuildBody(context),),
    );
  }

  Widget BuildBody(BuildContext context){
    return Center(
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formkey2,
                  child: Container(
                    height: 100.0,
                    color: Colors.black12,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        filled: true,
                        hintText: 'Enter user ID',
                      ),
                      validator: (val){
                        uid=val;
                        if(val.isEmpty){
                          return 'plese enter user ID';
                        }
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter
                            .digitsOnly,
                        LengthLimitingTextInputFormatter(
                            4)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Or',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formkey1,
                  child: Container(
                    height: 80.0,
                    color: Colors.black12,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0),
                            child: Container(
                              width: 16.0,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                textCapitalization:
                                TextCapitalization.characters,
                                controller: controllerPlateNumber01,
                                focusNode: _vehicle01,
                                textInputAction:
                                TextInputAction.next,
                                decoration: new InputDecoration(
                                    hintText: 'TN'),
                                validator: validatePlateNum,
                                onSaved: (value) {
                                  print(value.toUpperCase());
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp('[A-Za-z]')),
                                  LengthLimitingTextInputFormatter(
                                      2),
                                ],
                                onFieldSubmitted: (val)
                                {FocusScope.of(context).requestFocus(_vehicle02);
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("-"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 16.0,
                              child: TextFormField(
                                focusNode: _vehicle02,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter
                                      .digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                      2)
                                ],
                                controller: controllerPlateNumber02,
                                textInputAction:
                                TextInputAction.next,
                                decoration: new InputDecoration(
                                    hintText: '08'),
                                keyboardType: TextInputType.number,
                                validator: validatePlateNum,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(_vehicle03);
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("-"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 16.0,
                              child: TextFormField(
                                focusNode: _vehicle03,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                TextCapitalization.characters,
                                controller: controllerPlateNumber03,
                                textInputAction:
                                TextInputAction.next,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(_vehicle04);
                                },
                                decoration: new InputDecoration(
                                    hintText: 'EG'),
                                validator: validatePlateNum,
                                onSaved: (value) {
                                  print(value.toUpperCase());
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp('[A-Za-z]')),
                                  LengthLimitingTextInputFormatter(
                                      2),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text("-"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 16.0,
                              child: TextFormField(
                                focusNode: _vehicle04,
                                textAlign: TextAlign.center,
                                textInputAction:
                                TextInputAction.done,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter
                                      .digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                      5)
                                ],
                                controller: controllerPlateNumber04,
                                decoration: new InputDecoration(
                                    hintText: '9999'),
                                keyboardType: TextInputType.number,
                                validator: validatePlateNumFour,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.teal,
                onPressed: () async{
                  if(_formkey1.currentState.validate()){
                    print('vehicle');
                    var vehList = await getVehicleDetails(getVechNum());
                    print('vehicles list:$vehList');
                    if (vehList.length > 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => BookingDetails(vehList)));

                    } else {
                      showToast('No Bookings With this User id');

                    };
                  } else if(_formkey2.currentState.validate()){
                    print('userid:${uid}');
                    var userDetail=await getUserDetails('$uid');
                    print('userDetails:$userDetail');
                    if (userDetail.length > 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => BookingDetails(userDetail)));
                    } else {
                      showToast('No Bookings With this Vehicle Number');

                    };
                  }
                },
                child: Text('Search',style: TextStyle(fontSize: 19.0),),)
            ],
          ),
        ],
      ),
    );
  }
  String validatePlateNum(value) {
    print('plane two length - $value');
    if (value.length != 2) {
      return "Enter";
    }
    return null;
  }
  String validatePlateNumOne(value) {
    print('plane two length - $value');
    if (value.length < 1) {
      return "Enter";
    }
    return null;
  }

  String validatePlateNumFour(String value) {
    print('four value - ${value.length}');
    if (value.length < 3) {
      return "Enter";
    }
    return null;
  }
}
