import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Admin'),),
      body: Column(children: <Widget>[
        Text("Ini Halaman Admin"),
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