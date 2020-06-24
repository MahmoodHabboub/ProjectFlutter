import 'dart:convert';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/Product.dart';
import 'package:provider/provider.dart';

import 'DbHelper.dart';
import 'Featured.dart';
import 'MyOrders.dart';
import 'Product_details.dart';

class HomeClient extends StatefulWidget {
  static String UserId_c="";
  static String UserEmail_c="";

  HomeClient(String UserId,String UserEmail){
    UserId_c=UserId;
    UserEmail_c=UserEmail;
  }

  @override
  _HomeClientState createState() => _HomeClientState();

}

class _HomeClientState extends State<HomeClient>{

  @override
  void initState(){
    super.initState();
      onStart();
  }
  void onStart() async {
    await Provider.of<Featured>(context, listen: false).setAllProducts();
//    await Provider.of<Featured>(context, listen: false).setAllProductCategories();
//    await DbHelper.dbHelper.retrieveDataProductbyId(HomeClient.UserId_c);
    print(Provider.of<Featured>(context, listen: false).products.length);
  }

  navigationProduct_details(Product product){
    Navigator.push(context,MaterialPageRoute(builder:(context)=>Product_details(product)));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("HomeClient"),
          actions: <Widget>[
            IconButton(
              icon: myAppBarIcon(),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>MyOrders()));
              },
            )
          ],
        ),
        body: Column(children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Container(
            height: 100,
            child:ListView.builder(
                        itemCount: Provider.of<Featured>(context).categories.length,
                        itemExtent: 200,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Provider.of<Featured>(context,listen: false).setProducts(Provider.of<Featured>(context,listen: false).categories.elementAt(index).toString());
                            },
                            child: Card(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(Provider.of<Featured>(context).categories.elementAt(index).toString()),
                              ),
                            ),
                          );
                        }),
          ),
          new Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Featured',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Flexible(
            child: StreamBuilder(
              stream: Provider.of<Featured>(context).products,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return new Text('Loading...');
                  default:
                    return Builder(
                      builder: (BuildContext context) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  print(snapshot.data.documents.elementAt(index)[DbHelper.columnProductMershantIdF]);
                                  navigationProduct_details(Product.fromJson(snapshot.data.documents.elementAt(index).data));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Column(children: <Widget>[
                                    Image.memory(base64Decode(snapshot.data.documents.elementAt(index)[DbHelper.columnProductImage]),width: 550,height: 150,),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30,left: 0,right:0 ,top: 30),
                                      child: Text(
                                        snapshot.data.documents.elementAt(index)[DbHelper.columnProductName],
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    Text(
                                      "\$${snapshot.data.documents.elementAt(index)[DbHelper.columnProductPrice].toString()}",
                                      style: TextStyle(fontSize: 25),
                                    )
                                  ],
                                  ),
                                ));
                          },
                          itemCount: snapshot.data.documents.asMap().length,
                        );
                      },
                    );
                }
              },
            ),
          )
        ]),
      );
    });
  }
}
Widget myAppBarIcon(){
  return Container(
    width: 30,
    height: 30,
    child: Stack(
      children: [
        Icon(
          Icons.update,
          color: Colors.white,
          size: 35,
        ),
      ],
    ),
  );
}