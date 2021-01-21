import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _secureText = true;
  String email, password, name;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    debugPrint("Success");
    final response =
        await http.post("http://192.168.1.10/animeapp/register.php", body: {
      'email': email,
      'password': password,
      'name': name,
    });

    debugPrint(response.body.toString());
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    debugPrint(data.toString());
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      loginToast(message);
    } else {
      print(message);
      failedToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'You Have Sucessfully Register',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  failedToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Account Already Exists',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffb5171d),
        textColor: Colors.white);
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "Please insert Username";
                }
                return null;
              },
              onSaved: (e) => email = e,
              decoration: InputDecoration(labelText: "email"),
            ),
            TextFormField(
              obscureText: _secureText,
              validator: (e) {
                if (e.isEmpty) {
                  return "Please insert Password";
                }
                return null;
              },
              onSaved: (e) => password = e,
              decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: showHide,
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                  )),
            ),
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "Please insert Name";
                }
                return null;
              },
              onSaved: (e) => name = e,
              decoration: InputDecoration(labelText: "Name"),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
