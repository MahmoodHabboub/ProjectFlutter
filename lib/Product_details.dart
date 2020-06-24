import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Featured.dart';
import 'Product.dart';
import 'ShoppingCart.dart';

class Product_details extends StatefulWidget {

  Product product;
  Product_details(Product product){
    this.product=product;
  }

  @override
  _Product_detailsState createState() => _Product_detailsState(product);
}

class _Product_detailsState extends State<Product_details> {
  Product product;
  String length_Map_Cart="";
  _Product_detailsState(Product product){
    this.product=product;
  }

  navigationProduct_cart(){
    Navigator.push(context,MaterialPageRoute(builder:(context)=>ShoppingCart()));
  }

  @override
  Widget build(BuildContext context) {
    length_Map_Cart=Provider.of<Featured>(context).cart.length.toString();
    return Scaffold(
      appBar: AppBar(title: Text("Product details"),
      actions: <Widget>[
        IconButton(
          icon: myAppBarIcon(length_Map_Cart),
          onPressed: () {
            navigationProduct_cart();
          },
        )
      ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Image.memory(base64Decode(product.ProductImage)),width: 550,height: 150,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30,left: 0,right:0 ,top: 30),
            child: Text(
              product.ProductName,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30,left: 0,right:0 ,top: 30),
            child: Text(
              product.ProductPrice.toString(),
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30,left: 0,right:0 ,top: 30),
            child: Text(
              product.ProductDescription.toString(),
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            width: 350,
            height: 50,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                Provider.of<Featured>(context,listen: false).addProductToCart(product);
              },
              child: Text("Buy Now !",
                style: TextStyle(fontSize: 20),),),
          )
        ],
      ),
    );
  }
}

Widget myAppBarIcon(length_Map_Cart){
  return Container(
    width: 30,
    height: 30,
    child: Stack(
      children: [
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 35,
        ),
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 0),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFF5555),
                border: Border.all(color: Colors.white, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: Text(
                  length_Map_Cart,
                  style: TextStyle(fontSize: 9),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}