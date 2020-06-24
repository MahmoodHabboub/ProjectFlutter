import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Featured.dart';
import 'cart_address.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  navigationcart_address(){
    Navigator.push(context,MaterialPageRoute(builder:(context)=>cart_address()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShoppingCart"),),
      body: Container(
        padding: EdgeInsets.only(top: 20,right: 10,left:10 ,bottom: 20),
        child: ListView.builder(
            itemCount: Provider.of<Featured>(context).cart.length,
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
                      Container(child: Image.memory(base64Decode(Provider.of<Featured>(context).cart.asMap()[index].ProductImage))),
                      Container(
                        padding: EdgeInsets.only(bottom: 0,left:40 ,right:0 ,top:10 ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(Provider.of<Featured>(context,listen: false).cart.asMap()[index].ProductName),
                            SizedBox(height: 5,),
                            Text(Provider.of<Featured>(context,listen: false).cart.asMap()[index].ProductCategory),
                            SizedBox(height: 5,),
                            Text("\$${Provider.of<Featured>(context,listen: false).cart.asMap()[index].ProductPrice.toString()}",style: TextStyle(color: Colors.redAccent),),
                            SizedBox(height: 5,),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: (){
                                Provider.of<Featured>(context,listen: false).removeProductFromCart(index);
                                print(Provider.of<Featured>(context,listen: false).cart.length);
                              },
                              child: Text("Remove", style: TextStyle(fontSize: 20),),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom:0 ,left:50 ,right:20 ,top:0 ),
        child: ButtonTheme(
          minWidth: 400.0,
          height: 50.0,
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: (){
              navigationcart_address();
            },
            child: Text("Continue", style: TextStyle(fontSize: 20),),),
        )
        ,
      ),
    );
  }
}
