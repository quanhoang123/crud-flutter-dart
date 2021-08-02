import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_mysql_crud/app/modules/home/views/editData.view.dart';
import 'package:flutter_mysql_crud/main.dart';

class DetailsUser extends StatefulWidget {
  final List list;
  final int index;
  DetailsUser({this.list, this.index});
  @override
  _DetailsUserState createState() => _DetailsUserState();
}

class _DetailsUserState extends State<DetailsUser> {
  void delete() {
    var url = "http://192.168.1.56/php/myfolder/deletedata.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
    });
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Bạn có thực sự muốn xóa?"),
      actions: [
        MaterialButton(
          child: Text("OK DELETE"),
          onPressed: () {
            delete();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
        ),
        MaterialButton(
          child: Text("CANCEL"),
          onPressed: () {},
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['username']}'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                widget.list[widget.index]['username'],
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                widget.list[widget.index]['email'],
              ),
              Text(
                widget.list[widget.index]['password'],
              ),          
              MaterialButton(
                child: Text("Edit"),
                color: Colors.orange,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditUser(list: widget.list, index: widget.index)),
                ),
              ),
              MaterialButton(
                  child: Text("Delete"),
                  color: Colors.orange,
                  onPressed: () {
                    confirm();
                  })
            ],
          ),
        ),
      ),
    );
  }
}


