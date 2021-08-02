import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController cusername = new TextEditingController();
  TextEditingController cemail = new TextEditingController();
  TextEditingController cpassword = new TextEditingController();
  void addData() {
    var url = "http://192.168.1.35/php/myfolder/adddata.php";
    http.post(url, body: {
      "username": cusername.text,
      "email": cemail.text,
      "password":cpassword.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Data"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cusername,
              decoration: InputDecoration(hintText: 'Enter username',
              labelText: 'UserName',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cemail,
              decoration: InputDecoration(
                hintText: 'Enter email ',
                labelText: 'Email',
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: cpassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password '
                ),
              ),
          ),
          ElevatedButton(
            onPressed: () {
              if (cusername.text.isEmpty || cemail.text.isEmpty || cpassword.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "This field is requied",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
               addData();
               // route sau khi add xong thì quay về home
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );  
              }           
            },
            child: Text('ADD'),
          ),
        ],
      ),
    );
  }
}