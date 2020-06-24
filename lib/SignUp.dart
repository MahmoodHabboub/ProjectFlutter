import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'DbHelper.dart';
import 'Login.dart';
import 'User.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int value=0;
  String Name;
  String email;
  String password;

  setEmail(String val){
    this.email=val;
  }
  setPassword(String val){
    this.password=val;
  }
  setName(String val){
    this.Name=val;
  }
  GlobalKey<FormState>formkey=GlobalKey();
  saveMyForm()async{
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      if(value == 0){
          User user=User.fromJson({
          DbHelper.columnUserName:Name,
          DbHelper.columnUserEmail:email,
          DbHelper.columnUserPassword:password,
          DbHelper.columnUserIsMershant:0,
          DbHelper.columnUserAddress:null,
          });
        await DbHelper.insertNewUser(user);
        navigationMethod();
      }else if(value == 1){
        User user=User.fromJson({
          DbHelper.columnUserName:Name,
          DbHelper.columnUserEmail:email,
          DbHelper.columnUserPassword:password,
          DbHelper.columnUserIsMershant:1,
          DbHelper.columnUserAddress:null,
        });
        await DbHelper.insertNewUser(user);
        navigationMethod();
      }
    }
  }

  navigationMethod(){
    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("SignUp"),),
        body:Padding(padding: EdgeInsets.all(30),
            child:Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(decoration: InputDecoration(labelText: 'Enter Your Name'),
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
                  DropdownButton(
                    value: value,
                    items: [
                      DropdownMenuItem(child: Text("Client"),value: 0,),
                      DropdownMenuItem(child: Text("Mershant"),value: 1,),
                    ],
                    onChanged: (value){
                      this.value=value;
                      setState(() {
                      });
                    },
                  ),
                  SizedBox(height: 50,),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: ()=>saveMyForm(),
                    child: Text("SignUp",
                      style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,)
                  ,Row(
                    mainAxisAlignment: MainAxisAlignment.center
                    ,children: <Widget>[
                    Text("Already have an account ? ",style: TextStyle(color: Colors.blueGrey,fontSize: 15)),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>Login()));
                      }
                      ,child:
                    Text("SignIn",style: TextStyle(color: Colors.black,fontSize: 15)),),
                  ],)
                ],),
            )
        )
    );
  }
}
