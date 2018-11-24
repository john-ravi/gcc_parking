
import 'package:flutter/material.dart';
import 'package:gcc_parking/screens/dashboard_anusha.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

import 'utils/visualUtils.dart';
import 'utils/networkUtils.dart';
import 'screens/admin_dashboard.dart';
import 'utils/appConstants.dart';

void main() => runWhat();

void runWhat() async{
  await initBillingPrefs().then((bool) {
    if(bool) {
      runApp(Dashboard());
    } else {
      runApp(Enforcement());

    }
  });
}

Future<bool> initBillingPrefs() async{

  SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();
  print(prefs.getBool(LOGGED_IN) ?? false);
  print(prefs.getString(CURRENT_USER));

  if(prefs.getBool(LOGGED_IN) ?? false){
    if(prefs.getString(CURRENT_USER) != null){

      return true;
    }

  }
  return false;
}


class Enforcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Agent Login"),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController control_loginId = new TextEditingController();
  TextEditingController control_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Padding(
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
    );
  }

  Column buildColumnForm(BuildContext context) {
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
          autofocus: true,
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
        ),
        TextFormField(
          controller: control_password,
          autofocus: true,
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () async {

              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState.validate()) {
                s(context, "Validating");

                // If the form is valid, we want to show a Snackbar
                showloader(context);
                await validateAndLogin(
                    control_loginId.text, control_password.text, context)
                    .then((boolValid) {
                  removeloader();
                  if (boolValid) {
                    gotoHome(context);
                  }
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

  void gotoHome(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN, true);
    print(prefs.getBool(LOGGED_IN) ?? false);

    prefs.setString(CURRENT_USER, control_loginId.text);
    print(prefs.getString(CURRENT_USER));
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Dashboard()));
  }
}
