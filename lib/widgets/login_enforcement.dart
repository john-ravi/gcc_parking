import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_parking/enforcement.dart';
import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/screens/dashboard.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:gcc_parking/utils/utilsPrefs.dart';
import 'package:gcc_parking/utils/visualUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

class LoginEnforcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Enforcement(),
    );
  }
}

class Enforcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Login"),
      ),
      body: LoginForm(),
    );
  }
}

// Create a Form Widget
class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  static final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController control_loginId = new TextEditingController();
  TextEditingController control_password = new TextEditingController();
  TextEditingController control_passcode = new TextEditingController();
  TextEditingController controller_devicecode = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  autovalidate: _autoValidate,
                  key: _formKey,
                  child: buildColumnForm(context),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Powered By ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Image.asset(
                  "assets/images/nts.png",
                  height: 24.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column buildColumnForm(BuildContext context) {
    final _agentEmail = FocusNode();
    final _agentpassword = FocusNode();
    final _agentDeviceCode = FocusNode();
    final _agentPassCode = FocusNode();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/logo.png",
          height: 72.0,
        ),
        TextFormField(
            controller: control_loginId,
            focusNode: _agentEmail,
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: new InputDecoration(
              hintText: 'Agent Email ID',
              hintStyle: TextStyle(),
              labelText: 'Agent Email ID',
              labelStyle: TextStyle(),
            ),
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            validator: (value) {
              if (value.isNotEmpty) {
                try {
                  Validate.isEmail(value);
                } catch (e) {
                  return "Enter Email ID provided by Admin";
                }

                return null;
              } else {
                return "Please Enter Valid Email";
              }
            },
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_agentpassword);
            }),
        TextFormField(
          controller: control_password,
          focusNode: _agentpassword,
          textInputAction: TextInputAction.next,
          decoration: new InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(),
            labelText: 'Password',
            labelStyle: TextStyle(),
          ),
          keyboardType: TextInputType.text,
          maxLines: 1,
          obscureText: true,
          validator: validatePswd,
          onFieldSubmitted: (val) {
            FocusScope.of(context).requestFocus(_agentDeviceCode);
          },
        ),
        TextFormField(
          controller: controller_devicecode,
          focusNode: _agentDeviceCode,
          textInputAction: TextInputAction.next,
          decoration: new InputDecoration(
            hintText: 'Device Code',
            helperStyle: TextStyle(),
            labelText: 'Device Code',
            labelStyle: TextStyle(),
          ),
          keyboardType: TextInputType.text,
          maxLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(6)],
          validator: validateDevCode,
          onFieldSubmitted: (val) {
            FocusScope.of(context).requestFocus(_agentPassCode);
          },
        ),
        TextFormField(
          controller: control_passcode,
          focusNode: _agentPassCode,
          textInputAction: TextInputAction.done,
          decoration: new InputDecoration(
            hintText: 'Pass Code',
            hintStyle: TextStyle(),
            labelText: 'Pass Code',
            labelStyle: TextStyle(),
          ),
          keyboardType: TextInputType.text,
          maxLines: 1,
          obscureText: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
          ],
          validator: validatePsCode,
          onFieldSubmitted: (val) {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () async {
              //  FocusScope.of(context).requestFocus(new FocusNode());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState.validate()) {
                s(context, "Validating");

                // If the form is valid, we want to show a Snackbar
                showloader(context);
                await validateAndLogin(control_loginId.text, control_password.text,
                        controller_devicecode.text, control_passcode.text, context)
                    .then((modelUser) {
                  print("in then validateLogin");
                  removeloader();
                  if (modelUser.boolModelUpdated) {
                    gotoHome(context, modelUser);
                  }
                }).catchError((onError) {
                  print('Error Occured Login $onError');
                });
              } else {
                setState(() {
                  _autoValidate = true;
                });
              }
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }

  String validatePswd(value) {
    if (value.isEmpty || value.length < 6) {
      return 'Password Should Be Minimum 6 characters';
    } else {
      return null;
    }
  }

  String validatePsCode(value) {
    if (value.isEmpty || value.length != 6) {
      return 'Pass Code is 6 characters';
    } else {
      return null;
    }
  }

  String validateDevCode(value) {
    if (value.isEmpty || value.length != 6) {
      return 'Device Code is 6 characters';
    } else {
      return null;
    }
  }

  void gotoHome(BuildContext context, ModelAgent modelUser) async {
    await setUserPrefs(modelUser, control_loginId.text);
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => Dashboard(modelUser)));
  }
}
