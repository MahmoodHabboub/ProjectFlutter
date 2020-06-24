import 'package:project/DbHelper.dart';

import 'DbHelper.dart';

class User{
  String UserId;
  String Name;
  String Email;
  List Address;
  String Password;
  bool UserIsMershant;
  User({
    this.UserId,
    this.Name,
    this.Email,
    this.Password,
    this.UserIsMershant,
    this.Address,
  });
  factory User.fromJson(Map<String,dynamic>json)=>User(
      UserId:json[DbHelper.columnUserId],
      Name:json[DbHelper.columnUserName],
      Email:json[DbHelper.columnUserEmail],
      Password:json[DbHelper.columnUserPassword],
      Address:json[DbHelper.columnUserAddress],
      UserIsMershant:json[DbHelper.columnUserIsMershant]==1?true:false);

  Map<String,dynamic>toMap(){
    return{
      DbHelper.columnUserId:UserId,
      DbHelper.columnUserName:Name,
      DbHelper.columnUserEmail:Email,
      DbHelper.columnUserPassword:Password,
      DbHelper.columnUserAddress:Address,
      DbHelper.columnUserIsMershant:UserIsMershant?1:0,
    };
  }
}