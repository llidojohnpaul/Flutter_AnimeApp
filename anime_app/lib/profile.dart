import 'dart:convert';


import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  // final VoidCallback reload;
  // Profile(this.reload);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email, password, name, idUser;
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUser = preferences.getString("id");
    });
  }

  submit() async {
    final response =
        await http.post("http://192.168.1.10/animeapp/Profile.php", body: {
      'productname': email,
      'productdesc': password,
      'tradedesc': name,
      'idUser': idUser,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pop(context);
      addToast(message);
      print(message);
    } else {
      failedToast(message);
      print(message);
    }
  }

  addToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Successfully added Record',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  failedToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Failed to Add Record',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffb5171d),
        textColor: Colors.white);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    // var placeholder = Container(
    //   width: double.infinity,
    //   height: 50.0,
    //   child: Image.asset('assets/images/placeholder.png'),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Color(0xFFE65100),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            TextFormField(
              onSaved: (e) => email = e,
              decoration: InputDecoration(labelText: 'Email name'),
            ),
            TextFormField(
              onSaved: (e) => password = e,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              onSaved: (e) => name = e,
              decoration: InputDecoration(labelText: 'Full name'),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50.0,
              width: 50,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Color(0xff083663),
                color: Color(0xFFE65100),
                elevation: 7.0,
                child: MaterialButton(
                  onPressed: () {
                    check();
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Edit Profile',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
