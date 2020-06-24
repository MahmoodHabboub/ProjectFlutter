
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Featured.dart';
import 'package:project/Product.dart';
import 'package:provider/provider.dart';

import 'DbHelper.dart';
import 'MyOrdersMe.dart';
import 'Orders.dart';

class Orders_details extends StatefulWidget {
  Orders orders_mershant;

  Orders_details(orders_mershant){
    this.orders_mershant=orders_mershant;
  }
  @override
  _Orders_detailsState createState() => _Orders_detailsState(orders_mershant);
}

class _Orders_detailsState extends State<Orders_details> {

  Orders orders_mershant;

  _Orders_detailsState(orders_mershant){
    this.orders_mershant=orders_mershant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Orders details"),),
      body: Container(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(right:20 ,left:20 ,bottom:5 ,top:20 ),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Client Name',
                    style: TextStyle(fontSize: 15,color: Colors.blueGrey),
                  )),
            ),
            new Padding(
              padding: const EdgeInsets.only(right:20 ,left:20 ,bottom:5 ,top:10 ),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${orders_mershant.ProductName}',
                    style: TextStyle(fontSize: 15,color: Colors.black),
                  )),
            ),
            SizedBox(height: 10,),
            new Padding(
              padding: const EdgeInsets.only(right:20 ,left:20 ,bottom:5 ,top:20 ),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Address Lane',
                    style: TextStyle(fontSize: 15,color: Colors.blueGrey),
                  )),
            ),
            new Padding(
              padding: const EdgeInsets.only(right:20 ,left:20 ,bottom:5 ,top:10 ),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${orders_mershant.AddressDetails.split(",").toList().elementAt(1)}',
                    style: TextStyle(fontSize: 15,color: Colors.black),
                  )),
            ),
            SizedBox(height: 10,),
            new Padding(
              padding: const EdgeInsets.only(right:20 ,left:20 ,bottom:5 ,top:20 ),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Product List',
                    style: TextStyle(fontSize: 15,color: Colors.blueGrey),
                  )),
            ),
            Flexible(
              child: StreamBuilder(
                stream: Provider.of<Featured>(context).product_list,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return new Text('Loading...');
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.documents.asMap().length,
                          itemExtent: 20,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("${snapshot.data.documents.elementAt(index)[DbHelper.columnOrderProductName]}"),
                                ));
                          });
                  }
                },
              ),
            ),
            Container(
              width: 350,
              padding: EdgeInsets.only(bottom: 20),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: ()async{
                  await DbHelper.UpdateOrder(orders_mershant.OrderId);
//                  await Provider.of<Featured>(context, listen: false).setAllOrdersByUser(orders_mershant.UserId);
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>MyOrdersMe()));
                },
                child: Text("Accept", style: TextStyle(fontSize: 20),),),
            )
          ],
        ),
      ),
    );
  }
}
