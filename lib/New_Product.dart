import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/HomeMershant.dart';
import 'package:provider/provider.dart';

import 'DbHelper.dart';
import 'Featured.dart';
import 'Product.dart';

class New_Product extends StatefulWidget {
  @override
  _New_ProductState createState() => _New_ProductState();
}

class _New_ProductState extends State<New_Product> {
  int value=0;
  int MershantId;
  String ProductName;
  String ProductPrice;
  String ProductCategory;
  String ProductDuscription;


  setProductName(String val){
    this.ProductName=val;
  }

  setProductPrice(String val){
    this.ProductPrice=val;
  }

  setProductCategory(String val){
    this.ProductCategory=val;
  }

  setProductDuscription(String val){
    this.ProductDuscription=val;
  }
  GlobalKey<FormState>formkey=GlobalKey();
  saveMyForm(String imageB64) async{
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      Product product=Product.fromJson({
        DbHelper.columnProductName:ProductName,
        DbHelper.columnProductPrice:int.parse(ProductPrice),
        DbHelper.columnProductCategory:ProductCategory,
        DbHelper.columnProductDescription:ProductDuscription,
        DbHelper.columnProductMershantIdF:HomeMershant.MershantId_c,
        DbHelper.columnProductImage:imageB64,
      });
      print(HomeMershant.MershantId_c);
      await DbHelper.insertNewProduct(product);
      Scaffold.of(formkey.currentContext).showSnackBar(SnackBar(content: Text("Done !"),));
    }
  }
  @override
  Widget build(BuildContext context) {
    String imageB64;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("New Product"),),
        body:Padding(padding: EdgeInsets.all(30),
            child:Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(decoration: InputDecoration(labelText: 'Enter Product Name'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Product Name Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setProductName(result);
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(decoration: InputDecoration(labelText: 'Enter Product Price'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Product Price Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setProductPrice(result);
                    },
                  ),
                  SizedBox(height: 30,),
                  Text("Enter Product Category",style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w400),),
                  SizedBox(height: 5,),
                  DropdownButton(
                    isExpanded: true,
                    value: value,
                    items: [
                      DropdownMenuItem(child: Text("Clothes"),value: 0,),
                      DropdownMenuItem(child: Text("Shoes"),value: 1,),
                      DropdownMenuItem(child: Text("Electronic Devices"),value: 2,),
                    ],
                    onChanged: (value){
                      this.value=value;
                      setProductCategory(Provider.of<Featured>(context,listen: false).categories.elementAt(value));
                      setState(() {
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(decoration: InputDecoration(labelText: 'Enter Product Duscription'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Product Duscription Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setProductDuscription(result);
                    },
                  ),
                  SizedBox(height: 30,),
                Container(height: 40,width: 350,
                  child: RaisedButton(child: Text("Pick Image"),color: Colors.blue,textColor: Colors.white,
                    onPressed: () async{
                        File _imagenTemporal = await ImagePicker.pickImage(source: ImageSource.gallery);
                        List<int> imageBytes = _imagenTemporal.readAsBytesSync();
                        imageB64= base64Encode(imageBytes);
                    },)),
                  SizedBox(height: 30,),
                  Container(height: 40,width: 350,
                      child: RaisedButton(child: Text("Add Product"),color: Colors.blue,textColor: Colors.white,
                        onPressed: ()=>saveMyForm(imageB64),)),
                ],),
            )
        )
    );
  }
}
//Image.memory(binaryIntList);
//List<int> imageBytes = pickedImage.readAsBytesSync();
//String imageB64 = base64Encode(imageBytes);
//Uint8List decoded = base64Decode(imageB64);
//File.fromRawPath(Uint8List uint8List);
