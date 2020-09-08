import 'package:flutter/material.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page User'),),
      body: Column(children: <Widget>[
        Text("Ini Halaman User"),
        RaisedButton(
          child: Text("Logout"),
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/LoginPage');
          },
        )
      ],
      ),
    );
  }
}