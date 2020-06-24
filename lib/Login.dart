import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/DbHelper.dart';

import 'HomeClient.dart';
import 'HomeMershant.dart';
import 'SignUp.dart';
import 'User.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
//        FirebaseAuth.instance.signOut();
  String email;
  String password;
    setEmail(String val){
    this.email=val;
  }

  setPassword(String val){
    this.password=val;
  }

  GlobalKey<FormState>formkey=GlobalKey();
    saveMyForm()async{
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      print(email);
      print(password);
      try{
        var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(result.user != null){
          final value=await DbHelper.retrieveDataUserUserIsMershant(result.user.uid.toString());
          if(value == 1){
            navigationHomeMershant(result.user.uid.toString(),result.user.email.toString());
          }else if(value == 0){
           navigationHomeClient(result.user.uid.toString(),result.user.email.toString());
          }
        }else{
          print('user not found');
          showDialog(context: context,child:AlertDialog(title:Text("Warning") ,content: Text("The password or e-mail is wrong!"),actions: <Widget>[
            RaisedButton(child: Text("Ok"),onPressed: (){
              Navigator.pop(context);
            }),
          ],));
        }
      }catch (e) {
        print(e.toString());
        showDialog(context: context,child:AlertDialog(title:Text("Warning") ,content: Text("The password or e-mail is wrong!"),actions: <Widget>[
          RaisedButton(child: Text("Ok"),onPressed: (){
            Navigator.pop(context);
          }),
        ],));
      }
    }
  }

   navigationHomeMershant(String MershantId,String MershantEmail){
  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomeMershant(MershantId,MershantEmail)));
  }

   navigationHomeClient(String UserId,String UserEmail){
    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomeClient(UserId,UserEmail)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("Login"),),
          body:Padding(padding: EdgeInsets.all(30),
              child:Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(decoration: InputDecoration(labelText: 'Enter Your Email'),
                      validator:(value){
                        if(value.isEmpty){
                          return "Email Required!";
                        }
                      },onSaved: (newvalue){
                        String result = newvalue.trim();
                        setEmail(result);
                      },
                    ),
                    SizedBox(height: 50,),
                    TextFormField(obscureText: true,decoration: InputDecoration(labelText: 'Enter Your password'),
                      validator:(value){
                        if(value.isEmpty){
                          return "password Required!";
                        }else if(value.length<3){
                          return "password Short!";
                        }
                      },onSaved: (newvalue){
                        String result = newvalue.trim();
                        setPassword(result);
                      },
                    ),
                    SizedBox(height: 50,),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: ()=>saveMyForm(),
                      child: Text("Login",
                        style: TextStyle(fontSize: 20),),),
                   SizedBox(height: 20,)
                   ,Row(
                      mainAxisAlignment: MainAxisAlignment.center
                      ,children: <Widget>[
                      Text("Don't have account ? ",style: TextStyle(color: Colors.blueGrey,fontSize: 15)),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>SignUp()));
                        }
                        ,child:
                      Text("SignUp",style: TextStyle(color: Colors.black,fontSize: 15)),),
                    ],)
                  ],),
              )
          )
    );
  }
}
