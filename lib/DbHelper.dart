
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/HomeMershant.dart';
import 'package:project/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'HomeClient.dart';
import 'Orders.dart';
import 'Orders.dart';
import 'User.dart';
class DbHelper{
  DbHelper._();
  static final DbHelper dbHelper=DbHelper._();
  Database _database;
  String dbName='Project.db';

  String tableUsers='Users';
  static String columnUserId='UserId';
  static String columnUserName='UserName';
  static String columnUserEmail='UserEmail';
  static String columnUserPassword='UserPassword';
  static String columnUserIsMershant='UserIsMershant';
  static String columnUserAddress='UserAddress';


  String tableProducts='Products';
  static String columnProductId='ProductId';
  static String columnProductName='ProductName';
  static String columnProductPrice='ProductPrice';
  static String columnProductCategory='ProductCategory';
  static String columnProductDescription='ProductDescription';
  static String columnProductImage='ProductImage';
  static String columnProductMershantIdF='ProductMershantIdF';

  String tableOrders='Orders';
  static String columnOrderId='OrderId';
  static String columnOrderProductIdF='OrderProductIdF';
  static String columnOrderMershantIdF='OrderMershantIdF';
  static String columnOrderUserIdF='OrderUserIdF';
  static String columnOrderAddressIdF='OrderAddressIdF';
  static String columnOrderIsAccepted='OrderIsAccepted';
  static String columnOrderProductName='OrderProductName';
  static String columnOrderProductPrice='OrderProductPrice';
  static String columnOrderAddressDetails='OrderAddressDetails';
  static String columnOrderProductCategory='OrderProductCategory';
  static String columnOrderUserName='OrderUserName';
  static String columnOrderProductImage='OrderProductImage';




  String tableAddress='Address';
  static String columnAddressId='AddressId';
  static String columnAddressUserIdF='AddressUserIdF';
  static String columnAddressName='AddressName';
  static String columnAddressLane='AddressLane';
  static String columnAddressCity='AddressCity';
  static String columnAddressPostalCode='AddressPostalCode';
  static String columnAddressPhoneNumber='AddressPhoneNumber';


//  initDb()async{
//    Directory directory=await getApplicationDocumentsDirectory();
//    String path='${directory.path}/Project.db';
//    return await openDatabase(
//        path,
//        version: 1,
//        onCreate: (db,version) async {
//        await db.execute(
//                  '''
//                  CREATE TABLE $tableUsers(
//                  $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
//                  $columnUserName TEXT,
//                  $columnUserEmail TEXT,
//                  $columnUserPassword TEXT,
//                  $columnUserIsMershant INTEGER
//                  );
//                  ''');
//        await db.execute(
//                  '''
//                  CREATE TABLE $tableProducts(
//                  $columnProductId INTEGER PRIMARY KEY AUTOINCREMENT,
//                  $columnProductName TEXT,
//                  $columnProductPrice INTEGER,
//                  $columnProductCategory TEXT,
//                  $columnProductDescription TEXT,
//                  $columnProductImage TEXT,
//                  $columnProductMershantIdF INTEGER
//                  );
//                  ''');
//        await db.execute(
//                  '''
//                  CREATE TABLE $tableAddress(
//                  $columnAddressId INTEGER PRIMARY KEY AUTOINCREMENT,
//                  $columnAddressName TEXT,
//                  $columnAddressLane TEXT,
//                  $columnAddressCity TEXT,
//                  $columnAddressPostalCode TEXT,
//                  $columnAddressPhoneNumber TEXT,
//                  $columnAddressUserIdF INTEGER
//                  );
//                  ''');
//        await db.execute(
//                  '''
//                  CREATE TABLE $tableOrders(
//                  $columnOrderId INTEGER PRIMARY KEY AUTOINCREMENT,
//                  $columnOrderIsAccepted INTEGER,
//                  $columnOrderProductIdF INTEGER,
//                  $columnOrderMershantIdF INTEGER,
//                  $columnOrderUserIdF INTEGER,
//                  $columnOrderAddressIdF INTEGER
//                  );
//                  ''');
//        },
//        );
//  }

      //Users
  static insertNewUser(User user)async{
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.Email, password: user.Password);
      if(result != null)
      {
       user.UserId=result.user.uid;
       await Firestore.instance.collection('Users').document(result.user.uid).setData(user.toMap());
      }else{
        print('please try later');
      }
    }

  static Future<int> retrieveDataUserUserIsMershant(String Id)async{
      DocumentSnapshot document=await Firestore.instance.collection('Users').document(Id).get();
      int value=await document[columnUserIsMershant] as int;
      return value;
      }

  static UpdateUser(String Id,String Address)async{
    DocumentSnapshot document = await Firestore.instance.collection('Users').document(Id).get();
    List value=await document[columnUserAddress];
    if(value == null){
      value=[];
    }
    value.add(Address);
    await Firestore.instance.collection('Users').document(Id).updateData({
      '$columnUserAddress':value
    });
  }

  static retrieveDataUserUserAddress(String Id)async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Users').where("UserId",isEqualTo:Id).snapshots();
//    List value=await document[columnUserAddress] as List;
    return document;
  }




  //Products
  static insertNewProduct(Product product)async{
   product.ProductId=await Firestore.instance.collection('Products').document().documentID;
   await Firestore.instance.collection('Products').document(product.ProductId).setData(product.toMap());
  }

  static retrieveDataProductbyCategories(String Categories)async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Products').where("ProductCategory",isEqualTo: Categories).snapshots();
    return document;
  }

  static retrieveDataAllProduct()async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Products').snapshots();
    return document;
  }

  static retrieveDataProductCategories()async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Products').snapshots();
    return document;
  }



  static insertNewOrders(Orders orders)async{
    DocumentSnapshot document=await Firestore.instance.collection('Users').document(orders.UserId).get();
    String UserName=await document[columnUserName] as String;
    orders.NameClient=UserName;
    orders.OrderId=await Firestore.instance.collection('Orders').document().documentID;
    await Firestore.instance.collection('Orders').document(orders.OrderId).setData(orders.toMap());
  }

  static retrieveDataOrdersbyId(String Id)async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Orders').where("OrderUserIdF",isEqualTo: Id).snapshots();
    return document;
  }

  static retrieveDataProductbyMershantId(String Id)async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Orders').where("OrderMershantIdF",isEqualTo: Id).where("OrderIsAccepted",whereIn: [0]).snapshots();
    return document;
  }


  static retrieveDataProductbyIdUM(String MId,String UId)async{
    Stream<QuerySnapshot> document=await Firestore.instance.collection('Orders').where("OrderMershantIdF",isEqualTo: MId).where("OrderUserIdF",whereIn: [UId]).where("OrderIsAccepted",isGreaterThan: 0).snapshots();
    return document;
  }

  static UpdateOrder(String OId)async{
    await Firestore.instance.collection('Orders').document(OId).updateData({
      '$columnOrderIsAccepted':1
    });
  }

//  //Address
//
//  insertNewAddress(Address address)async{
//    Database db=await database;
//    var x=await db.insert(tableAddress, address.toMap());
//    print(x.toString());
//  }
//
//
//  retrieveDataAddressbyUser(int UserId)async{
//    Database db=await database;
//    List<Map<String,dynamic>>queryResults= await db.rawQuery('''SELECT * FROM $tableAddress WHERE $columnAddressUserIdF=?''',[UserId]);
//    try{
//      List<Address>address=queryResults.map((item)=>Address.fromJson(item)).toList();
//      return address;
//    }catch(error){
//      print(error);
//    }
//  }
//
//
//  //Orders
//
//  insertNewOrders(Orders orders)async{
//    Database db=await database;
//    var x=await db.insert(tableOrders, orders.toMap());
//    print(x.toString());
//  }
//
//
//  retrieveDataOrdersbyUser(int UserId)async{
//    Database db=await database;
//    List<Map<String,dynamic>>queryResults= await db.rawQuery('''SELECT * FROM $tableOrders WHERE $columnOrderUserIdF=?''',[UserId]);
//    try{
//      List<Orders>orders=queryResults.map((item)=>Orders.fromJson(item)).toList();
//      return orders;
//    }catch(error){
//      print(error);
//    }
//  }
//
//  UpdateOrdersbyUser(int OrderId)async{
//    Database db=await database;
//    await db.rawUpdate('UPDATE $tableOrders SET $columnOrderIsAccepted = ? WHERE $columnOrderId = ?', [1,OrderId]);
//  }

//  retrieveDataUser()async{
//    Database db=await database;
//    List<Map<String,dynamic>>queryResults=await db.query(tableUsers);
//    print(queryResults);
//  }

//  updateData(User user)async{
//    Database db=await database;
//    db.update(tableUsers, user.toMap(),where: null,whereArgs: null);
//  }
//
//  deleteData()async{
//    Database db=await database;
//    db.delete(tableUsers,where: null,whereArgs: null);
//  }
}