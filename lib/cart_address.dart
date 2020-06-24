import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Add_Address.dart';
import 'DbHelper.dart';
import 'Featured.dart';
import 'HomeClient.dart';
import 'Orders.dart';
import 'Product.dart';

class cart_address extends StatefulWidget {
  @override
  _addressState createState() => _addressState();
}

class _addressState extends State<cart_address> {
  String input = "";
  int RaBValue = -1;
  String Address="";
  @override
  void initState(){
    super.initState();
    onStart();
  }
  void onStart() async {
   await Provider.of<Featured>(context, listen: false).setAllAddress();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
        child: StreamBuilder(
          stream: Provider.of<Featured>(context).address,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Text('Loading...');
              default:
                if(snapshot.data == null){
                  return Text('No data to show');
                }else{
                  return ListView.builder(
                      itemCount:((snapshot.data.documents.elementAt(0)[DbHelper.columnUserAddress])as List)?.length ?? 0,
                      itemExtent: 150,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                              alignment: Alignment.center,
                              child: RadioListTile(
                                title: Text("${((snapshot.data.documents.elementAt(0)[DbHelper.columnUserAddress])as List).elementAt(index)}"),
                                value: index,
                                groupValue: RaBValue,
                                onChanged: (value) {
                                  RaBValue = value;
                                  Address=((snapshot.data.documents.elementAt(0)[DbHelper.columnUserAddress])as List).elementAt(index);
                                  setState(() {});
                                },
                              )),
                        );
                      });
                }
            }
          },
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom:0 ,left:50 ,right:20 ,top:0 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ButtonTheme(
              minWidth: 400.0,
              height: 50.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>Add_Address()));
                },
                child: Text("Add Address", style: TextStyle(fontSize: 20),),),
            ),
            SizedBox(height: 20,),
            ButtonTheme(
              minWidth: 400.0,
              height: 50.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async{
                  List<Product>cart=Provider.of<Featured>(context, listen: false).cart;
                  var Map_cart =cart.asMap();
                  for(int i=0;i<Map_cart.length;i++){
                    String ProductMershantIdF= Map_cart[i].ProductMershantIdF;
                    String ProductId= Map_cart[i].ProductId;
                    String ProductName= Map_cart[i].ProductName;
                    int ProductPrice= Map_cart[i].ProductPrice;
                    String ProductCategory= Map_cart[i].ProductCategory;
                    String ProductImage= Map_cart[i].ProductImage;
                    String UserId_c=HomeClient.UserId_c;
                    int address_Id= RaBValue;
                    int Is_Accept=0;
                    String address=Address;
                    print(ProductPrice);
                    Orders order=Orders.fromJson({
                      DbHelper.columnOrderUserIdF: UserId_c,
                      DbHelper.columnOrderMershantIdF:ProductMershantIdF,
                      DbHelper.columnOrderProductIdF: ProductId,
                      DbHelper.columnOrderAddressIdF:address_Id,
                      DbHelper.columnOrderIsAccepted:Is_Accept,
                      DbHelper.columnOrderProductName: ProductName,
                      DbHelper.columnOrderProductPrice: ProductPrice,
                      DbHelper.columnOrderProductCategory: ProductCategory,
                      DbHelper.columnOrderProductImage: ProductImage,
                      DbHelper.columnOrderAddressDetails: address,
                    });
                    await DbHelper.insertNewOrders(order);
                    if(i==Map_cart.length-1){
                      Provider.of<Featured>(context, listen: false).cart.clear();
                      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomeClient(HomeClient.UserId_c,HomeClient.UserEmail_c)));
                    }
                  }

                },
                child: Text("Confirm", style: TextStyle(fontSize: 20),),),
            ),
          ],
        )
        ,
      ),
    );
  }
}
