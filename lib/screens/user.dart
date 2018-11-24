import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_parking/utils/actionUtils.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'registration.dart';
import 'task.dart';
import 'alerts.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class User extends StatefulWidget {
  @override
  UserState createState() {
    return new UserState();
  }
}

class UserState extends State<User> {
  bool serachActive = true;
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> keySearchVehicle =
      new GlobalKey();
  List<String> suggestions = new List();

  AutoCompleteTextField textField;

  void populateList() async {
    await Future.delayed(Duration(seconds: 7));

    setState(() {
      suggestions = [
        "Apple",
        "Armidillo",
        "Actual",
        "Actuary",
        "America",
        "Argentina",
        "Australia",
        "Antarctica",
        "Blueberry",
        "Cheese",
        "Danish",
        "Eclair",
        "Fudge",
        "Granola",
        "Hazelnut",
        "Ice Cream",
        "Jely",
        "Kiwi Fruit",
        "Lamb",
        "Macadamia",
        "Nachos",
        "Oatmeal",
        "Palm Oil",
        "Quail",
        "Rabbit",
        "Salad",
        "T-Bone Steak",
        "Urid Dal",
        "Vanilla",
        "Waffles",
        "Yam",
        "Zest"
      ];
    });

    textField.updateSuggestions(suggestions);
  }

  @override
  void initState() {
    populateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textField = new AutoCompleteTextField<String>(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Ex:TN01eh1234",
        ),
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        key: keySearchVehicle,
        //    suggestionsAmount: 7,
        submitOnSuggestionTap: true,
        clearOnSubmit: false,
        suggestions: suggestions,
        textInputAction: TextInputAction.go,
        textChanged: (item) {
          currentText = item;

          if(item.length < 2) {
    //        keySearchVehicle.currentState.textField;
          } else if(item.length == 2) {
           /* item += item + " ";*/


          }
          print("currwent $currentText");
          print("list ${suggestions.toString()}");
        },
        textSubmitted: (item) {
          print("Submitteed");
          setState(() {
            currentText = item;
          });
        },
        itemBuilder: (context, item) {
          return new Padding(
              padding: EdgeInsets.all(8.0), child: new Text(item));
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        });

    return new MaterialApp(
      title: 'AGENT LOGIN',
      home: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            serachActive ? buildAutoSearch() : Icon(FontAwesomeIcons.search),
            Padding(
              padding: EdgeInsets.only(right: 24.0),
            ),
          ],
        ),

        drawer: Drawer(
          child: Container(
            color: Colors.blueGrey,
            child: ListView(children: <Widget>[
              DrawerHeader(
                  child: Icon(
                    FontAwesomeIcons.bars,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(color: Colors.blueGrey)),
              //Icon(FontAwesomeIcons.search,size: 20.0,),

              new ListTile(
                title: Text(
                  'User Management',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new User()));
                },
              ),
              new ListTile(
                title: Text(
                  'Parking lot Management',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.productHunt,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
/*
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Parking1()));
*/
                },
              ),
              new ListTile(
                title: Text(
                  'Task and Activity',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.listUl,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Task()));
                },
              ),
              new ListTile(
                title: Text(
                  'Quick Registration',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.registered,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Registration()));
                },
              ),
              new ListTile(
                title: Text(
                  'Alerts',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Alert()));
                },
              ),
              new ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
                leading: new Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  logout(context);
                },
              ),
            ]),
          ),
        ),
        //Icon(FontAwesomeIcons.search,size: 20.0,),

        body: UserManagemementBody(),
      ),
    );
  }

  Widget buildAutoSearch() {
    return Container(
      width: 250.0,
      child: ListTile(
          title: textField,
          trailing: new IconButton(
              icon: new Icon(Icons.clear),
              onPressed: () {
                print("pressed reset");
                setState(() {
                  if (currentText != "") {
                    textField.clear();
                    currentText = "";
                  }
                });
              })),
    );
  }
}

class AppBarActionsWidget extends StatefulWidget {
  @override
  _AppBarActionsWidgetState createState() => _AppBarActionsWidgetState();
}

class _AppBarActionsWidgetState extends State<AppBarActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UserManagemementBody extends StatefulWidget {
  @override
  _UserManagemementBodyState createState() => _UserManagemementBodyState();
}

class _UserManagemementBodyState extends State<UserManagemementBody> {
  bool isBlacklisted = false;

  Widget buildRow(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      children: <Widget>[
        Row(children: <Widget>[
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(right: 10.0),
            child: new Container(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.users,
                        color: selectionIconColor,
                        size: DRAWER_ICON_SIZE * 1.16,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.productHunt,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
                    onPressed: () {
/*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Parking1()));
*/
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.listUl,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Task()));
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.registered,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registration()));
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.exclamationTriangle,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (Alert())));
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.signOutAlt,
                        color: Colors.white, size: DRAWER_ICON_SIZE),
                    onPressed: () {
                      logout(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Plate # TS 01 CH 2019',
                    style: new TextStyle(color: Colors.black, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          isBlacklisted ? stringBlackList : "",
                          style: new TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Vehicle type:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                'Vehicle type:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'User Id:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                'User Id:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'Start time:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                'Start time:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'End time:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                'End time:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'Parking slot:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                'Parking slot:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'Applicable fees:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                'Applicable fees:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'Payment status:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              Text(
                                'Applicable fines:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                'Applicable fines:',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(                            mainAxisAlignment: MainAxisAlignment.end,

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Due's",
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Container(
                                color: Colors.grey,
                                child: new Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: new Text("0",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "",
                            // "Send Reminder",
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "",
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(                            mainAxisAlignment: MainAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Penalty",
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      width: 48.0,
                      child: TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(color: Colors.black, fontSize: 24.0),
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(7),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.orangeAccent,
                            onPressed: (){},
                            child: Text(
                              "Charge",
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "Blacklist",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 24.0),
                        ),
                      )
                    ],
                  ),
                  Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          new Container(
                            color: Colors.blueGrey,
                            child: new Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: InkWell(onTap: (){

                                },
                                  child: new Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            color: Colors.grey,
                            child: new Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: InkWell(onTap: (){

                                },
                                  child: new Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])
                ]),
              ])
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildRow(context);
  }
}
