import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Additem extends StatefulWidget {
  // final VoidCallback reload;
  // Additem(this.reload);
  @override
  _AdditemState createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  String name, artist, price, clientid;
  final _key = new GlobalKey<FormState>();
  File _imageFile;

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
      clientid = preferences.getString("id");
    });
  }

  submit() async {
    final response =
        await http.post("http://192.168.1.10/animeapp/additem.php", body: {
      'name': name,
      'artist': artist,
      'price': price,
      'clientid': clientid,
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
        msg: 'Item Successfully  Added',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Colors.blue,
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
              onSaved: (e) => name = e,
              decoration: InputDecoration(labelText: 'Anime Name'),
            ),
            TextFormField(
              onSaved: (e) => artist = e,
              decoration: InputDecoration(labelText: 'Artist'),
            ),
            TextFormField(
              onSaved: (e) => price = e,
              decoration: InputDecoration(labelText: 'Price'),
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
                color: Colors.blue,
                elevation: 7.0,
                child: MaterialButton(
                  onPressed: () {
                    check();
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Add Item',
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
