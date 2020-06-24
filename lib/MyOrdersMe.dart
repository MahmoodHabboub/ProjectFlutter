
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/DbHelper.dart';
import 'package:project/Orders.dart';
import 'package:provider/provider.dart';

import 'Featured.dart';
import 'Orders_details.dart';

class MyOrdersMe extends StatefulWidget {
  @override
  _MyOrdersMeState createState() => _MyOrdersMeState();
}

class _MyOrdersMeState extends State<MyOrdersMe> {

  @override
  void initState(){
    super.initState();
    onStart();
  }
  void onStart() async {
  await Provider.of<Featured>(context, listen: false).setAllOrders_Mershant();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Orders"),),
      body: Container(
        padding: EdgeInsets.only(top: 20,right: 10,left:10 ,bottom: 20),
        child: StreamBuilder(
          stream:  Provider.of<Featured>(context).orders_mershant,
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
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 0,left:60 ,right:0 ,top:10 ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductName]),
                                    SizedBox(height: 5,),
                                    Text(snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductCategory]),
                                    SizedBox(height: 5,),
                                    Text("\$${snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductPrice].toString()}",style: TextStyle(color: Colors.redAccent),),
                                    SizedBox(height: 5,),
                                    Text("${snapshot.data.documents.elementAt(index)[DbHelper.columnOrderUserName]}"),
                                    SizedBox(height: 5,),
                                    Text("${snapshot.data.documents.elementAt(index)[DbHelper.columnOrderAddressDetails].toString().split(",").elementAt(2)}"),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                              Container(padding: EdgeInsets.only(bottom: 0,left:120 ,right:0 ,top:10 ),
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  onPressed: ()async{
                                    await Provider.of<Featured>(context, listen: false).setAllProduct_List(snapshot.data.documents.elementAt(index)[DbHelper.columnOrderUserIdF]);
                                    Navigator.push(context,MaterialPageRoute(builder:(context)=>Orders_details(Orders.fromJson(snapshot.data.documents.elementAt(index).data))));
                                  },
                                  child: Text("Details", style: TextStyle(fontSize: 20),),),
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
