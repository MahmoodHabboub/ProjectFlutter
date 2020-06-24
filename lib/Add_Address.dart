
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DbHelper.dart';
import 'Featured.dart';
import 'HomeClient.dart';
import 'cart_address.dart';
class Add_Address extends StatefulWidget {
  @override
  _Add_AddressState createState() => _Add_AddressState();
}

class _Add_AddressState extends State<Add_Address> {
  String Name;
  String Address_Lane;
  String City;
  String Postal_Code;
  String Phone_Number;

  setName(String val){
    this.Name=val;
  }
  setAddress_Lane(String val){
    this.Address_Lane=val;
  }
  setCity(String val){
    this.City=val;
  }
  setPostal_Code(String val){
    this.Postal_Code=val;
  }
  setPhone_Number(String val){
    this.Phone_Number=val;
  }

  GlobalKey<FormState>formkey=GlobalKey();
  saveMyForm()async{
    if(formkey.currentState.validate()){
      formkey.currentState.save();
          String address="${Name},${Address_Lane},${City},${Postal_Code},${Phone_Number}";
          await DbHelper.UpdateUser(HomeClient.UserId_c,address);
          navigation_cart_address();
      }
    }
  navigation_cart_address(){
    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>cart_address()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("Add Address"),),
        body:Padding(padding: EdgeInsets.all(30),
            child:Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(decoration: InputDecoration(labelText: 'Name'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Name Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setName(result);
                    },
                  ),
                  SizedBox(height: 50,),
                  TextFormField(decoration: InputDecoration(labelText: 'Address Lane'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Address Lane Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setAddress_Lane(result);
                    },
                  ),
                  SizedBox(height: 50,),
                  TextFormField(decoration: InputDecoration(labelText: 'City'),
                    validator:(value){
                      if(value.isEmpty){
                        return "City Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setCity(result);
                    },
                  ),
                  SizedBox(height: 50,),
                  TextFormField(decoration: InputDecoration(labelText: 'Postal Code'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Postal Code Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setPostal_Code(result);
                    },
                  ),
                  SizedBox(height: 50,),
                  TextFormField(decoration: InputDecoration(labelText: 'Phone Number'),
                    validator:(value){
                      if(value.isEmpty){
                        return "Phone Number Required!";
                      }
                    },onSaved: (newvalue){
                      String result = newvalue.trim();
                      setPhone_Number(result);
                    },
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: ()=>saveMyForm(),
                    child: Text("Add Address",
                      style: TextStyle(fontSize: 20),),),
                ],),
            )
        )
    );
  }
}
