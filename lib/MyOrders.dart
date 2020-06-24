import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Orders.dart';
import 'package:provider/provider.dart';

import 'DbHelper.dart';
import 'Featured.dart';
import 'Product.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  @override
  void initState(){
    super.initState();
    onStart();
  }
  void onStart() async {
   await Provider.of<Featured>(context, listen: false).setAllOrders();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MyOrders"),),
      body: Container(
        padding: EdgeInsets.only(top: 20,right: 10,left:10 ,bottom: 20),
        child: StreamBuilder(
          stream: Provider.of<Featured>(context).orders_users,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Text('Loading...');
              default:
                return ListView.builder(
                    itemCount: snapshot.data.documents.asMap().length,
                    itemExtent: 150,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Container(child: Image.memory(base64Decode(snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductImage]))),
                              Container(
                                padding: EdgeInsets.only(bottom: 0,left:10 ,right:0 ,top:10 ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductName]),
                                    SizedBox(height: 5,),
                                    Text(snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductCategory]),
                                    SizedBox(height: 5,),
                                    Text("\$${snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductPrice].toString()}",style: TextStyle(color: Colors.redAccent),),
                                    SizedBox(height: 5,),
                                    RaisedButton(
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      onPressed: (){},
                                      child: Text("${snapshot.data.documents.elementAt(index)[DbHelper.columnOrderIsAccepted]==0?"Unacceptable":"acceptable"}", style: TextStyle(fontSize: 20),),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
            }
          },
        ),
      ),
    );
  }
}
