import 'package:flutter/material.dart';

import 'MyOrdersMe.dart';
import 'New_Product.dart';

class HomeMershant extends StatefulWidget {
  static String MershantId_c="";
  static String MershantEmail_c="";

  HomeMershant(String MershantId,String MershantEmail){
    MershantId_c=MershantId;
    MershantEmail_c=MershantEmail;
  }

  @override
  _HomeMershantState createState() => _HomeMershantState();
}

class _HomeMershantState extends State<HomeMershant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeMershant"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(height: 50,width: 350,
            child: RaisedButton(child: Text("New Product"),color: Colors.blue,textColor: Colors.white,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>New_Product()));
            },
            )),
        SizedBox(height: 50,),
          Container(height: 50,width: 350,
              child: RaisedButton(child: Text("Orders"),color: Colors.blue,textColor: Colors.white,
                onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder:(context)=>MyOrdersMe()));
                },
              )),
        ],),),
    );
  }
}
