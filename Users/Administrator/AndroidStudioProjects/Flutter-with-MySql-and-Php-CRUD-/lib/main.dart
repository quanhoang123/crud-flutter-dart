import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_mysql_crud/app/modules/home/views/addData.view.dart';
import 'package:flutter_mysql_crud/app/modules/home/views/detailDart.view.dart';


void main()=>runApp(MaterialApp(
  title: "Api Test",
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.red,

  ),
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Future<List> getData() async{
    final response = await http.get(Uri.parse("http://192.168.1.56/php/myfolder/getdata.php"));
    debugPrint('${response.statusCode}');
  //  final data = await json.decode(responce.body.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load list');
  }
  }

class _HomeState extends State<Home> {    
 Future<List> listGiDo;
  @override
  void initState() {
    super.initState();
    listGiDo= getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trung Quan'),
      actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData(),),);
          },
          icon: Icon(Icons.add),),   
        ],
      ),
      body:FutureBuilder<List>(
        future: getData(),
        builder: (context,ss) {
          if(ss.hasError){
            print("error");
          }
          if(ss.hasData){
            return Items(list:ss.data);
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {
  List list;
  Items({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //Kiểm tra nếu list == null thì trả về 0 còn ngược lại thì lấy hết dòng dữ liệu ra
      itemCount: list==null?0:list.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.people),
          title: Text(list[i]['username']),
          subtitle: Text(list[i]['email']),
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>DetailsUser(list:list,index:i),
          )),
        );
      }
    );
  }
}

