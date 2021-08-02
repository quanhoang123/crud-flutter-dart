import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  final List list;
  final int index;
  EditUser({this.list, this.index});
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController cusername;
  TextEditingController cpassword;
  TextEditingController cemail;
  void editData() {
    var url = "http://192.168.1.56/php/myfolder/editdata.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'username': cusername.text,
      'email': cemail.text,
      'password': cpassword.text,
    });
  }

  @override
  void initState() {
    cusername =TextEditingController(text: widget.list[widget.index]['username']);
    cemail = TextEditingController(text: widget.list[widget.index]['email']);
    cpassword =TextEditingController(text: widget.list[widget.index]['password']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data ${widget.list[widget.index]['username']}"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cusername,
              decoration: InputDecoration(
                  hintText: "Enter username", labelText: "Enter username"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cemail,
              decoration: InputDecoration(
                  hintText: "Enter password", labelText: "Enter email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cpassword,
              decoration: InputDecoration(
                  hintText: "Enter password", labelText: "Enter password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (cusername.text.isEmpty ||
                    cemail.text.isEmpty ||
                    cpassword.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "This field is requied",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 10.0);
                } else {
                  editData();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => Home()),
                  );
                }
              },
              child: Text("Edit"),
            ),
          ),
          // MaterialButton(
          //   child: Text("Edit Data"),
          //   onPressed: () {
          //     editData();
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (BuildContext context) => Home()),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
