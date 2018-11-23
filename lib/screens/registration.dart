import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user.dart';
import 'alerts.dart';
import 'registration1.dart';
import 'task.dart';

class Registration extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ADMIN LOGIN',
      home: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            Icon(FontAwesomeIcons.envelope),
            Icon(FontAwesomeIcons.bell),
          ],

          //title: Text(widget.title),
        ),
        body: Row(
              children : <Widget>[
                new Expanded(child: new Container(decoration: const BoxDecoration(color: Colors.blueGrey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesomeIcons.users,color: Colors.white,size: 40.0),onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>User()));
                      },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.productHunt,color: Colors.white,size: 40.0),onPressed: (){
/*
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>Parking1()));
*/
                      },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.listUl,color: Colors.white,size: 40.0),onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) =>Task()));
                      },
                      ),

                      Icon(FontAwesomeIcons.registered,color: Colors.white,size: 40.0),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.exclamationTriangle,color: Colors.white,size: 40.0),onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) =>Alert()));
                      },
                      ),


                    ],

                  ),)),

                   Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: Colors.blue,
                            child: Text('submit'),
                            onPressed: (){},
                          ),
                        ),
                        TextFormField(decoration: InputDecoration(labelText: 'anusha'),),
                        TextFormField(decoration: InputDecoration(labelText: 'anu'),),
                        TextFormField(decoration: InputDecoration(labelText: 'anusha'),),
                        TextFormField(decoration: InputDecoration(labelText: 'anu'),),
                        TextFormField(decoration: InputDecoration(labelText: 'anusha'),),
                        TextFormField(decoration: InputDecoration(labelText: 'anu'),),


                      ],
                  ),

                






              ]),



      ),
    );
  }
}