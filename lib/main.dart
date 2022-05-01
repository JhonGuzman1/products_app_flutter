import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main(){
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>{


  Map data = {};
  List productsData = [];

  getProducts() async{
    
    Uri url = Uri.parse('http://192.168.1.103:4000/api/products');
    http.Response response= await http.get(url);
    data = jsonDecode(response.body);
    setState(() {
        productsData = data['data'];
    });

  }

  @override
  initState(){
    super.initState();
    getProducts();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Products')
      ),
      body: ListView.builder(
        itemCount: productsData.isEmpty ? 0 : productsData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text("Name: "+productsData[index]['Name']),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text("Description: "+productsData[index]['Description']),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text("Price: "+ productsData[index]['Price'].toString()),
                ),
               
              ],
          ),);
        },
       ),
    );
  }

}