import 'dart:async';
import 'dart:convert';

import 'package:pasarku_waku/pages/adminPage.dart';
import 'package:pasarku_waku/pages/userPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(PasarkuApp());

String username;

class PasarkuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pasarku Login',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/adminPage': (BuildContext context) => Admin(),
        '/userPage': (BuildContext context) => User(),
        '/LoginPage': (BuildContext context) => LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  String pesan = '';

  // get http => null;

  Future<List> _login() async {
    final response = await http.post("http://192.168.56.1/pasarku/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    // print(response.body);

  var datauser = json.decode(response.body);

  if(datauser.length == 0) {
    setState(() {
      pesan="Username atau password salah";
    });
  }else{
    if(datauser[0]['level']=='admin') {
      Navigator.pushReplacementNamed(context, '/adminPage');
    }else if(datauser[0]['level']=='user') {
      Navigator.pushReplacementNamed(context, '/userPage');
    }
    setState(() {
      username= datauser[0]['username'];
    });
  }
  return datauser;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/cover.jpg"),
              fit: BoxFit.cover
              ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 77.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xffFDCF09),
                  backgroundImage: AssetImage("assets/images/kopi.png"),
                  // child: Image(
                  //   width: 135,
                  //   height: 135,
                  //   image: AssetImage("assets/images/kopi.png"),
                  // ),
                ),
                width: 150.0,
                height: 235.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 93
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          ),
                        ]
                      ),
                      child: TextFormField(
                        controller: user,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                            ),
                            hintText: 'Username'
                        ),
                      ),
                    ),
                  Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 50,
                margin: EdgeInsets.only(
                  top: 32
                ),
                padding: EdgeInsets.only(
                  top: 4, left: 16, right: 16, bottom: 4
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5
                    )
                  ]
                ),
                child: TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.black,
                    ),
                    hintText: 'Password'
                  ),
                ),
              ),
              Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 6,
              right: 32,
            ),
            child: Text(
              'Remember Password',
              style: TextStyle(
                color: Colors.grey,
                ),
            ),
          ),
        ),
        Spacer(),
        RaisedButton(
          child: Text("SUBMIT"),
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          onPressed: () {
            _login();
          },
        ),
        Text(pesan,
        style: TextStyle(fontSize: 25.0, color: Colors.red),
        )
            ],
          ),
        ),
      ],
      ),
    ),
    ),
  );
  }
}