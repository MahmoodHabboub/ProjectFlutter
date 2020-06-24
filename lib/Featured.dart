import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/HomeClient.dart';
import 'package:project/Orders.dart';

import 'DbHelper.dart';
import 'HomeMershant.dart';
import 'Orders.dart';
import 'Product.dart';

class Featured extends ChangeNotifier{
  Stream<QuerySnapshot>products;
  List<String> categories;
  List<Product>cart;
  Stream<QuerySnapshot>address;
  Stream<QuerySnapshot>orders_users;
  Stream<QuerySnapshot>orders_mershant;
  Stream<QuerySnapshot>product_list;

  Featured(){
    cart=List<Product>();
    categories=["Clothes","Shoes","Electronic Devices"];
  }

  setProducts(String Categories) async{
    Stream<QuerySnapshot>products=await DbHelper.retrieveDataProductbyCategories(Categories);
    this.products=products;
    notifyListeners();
  }

  setAllProducts() async{
    Stream<QuerySnapshot>products=await DbHelper.retrieveDataAllProduct();
    this.products=products;
    print(products.length);
    notifyListeners();
  }

//  setAllProductCategories()async{
//    Stream<QuerySnapshot> categories=await DbHelper.retrieveDataProductCategories();
//    this.categories=categories;
//    print(categories.length);
//    notifyListeners();
//  }

  addProductToCart(Product product){
    cart.add(product);
    notifyListeners();
  }

  removeProductFromCart(int index){
    cart.removeAt(index);
    notifyListeners();
  }

  setAllAddress() async{
    Stream<QuerySnapshot>address=await DbHelper.retrieveDataUserUserAddress(HomeClient.UserId_c);
    this.address=address;
    notifyListeners();
  }


  setAllOrders() async{
    Stream<QuerySnapshot>orders_users=await DbHelper.retrieveDataOrdersbyId(HomeClient.UserId_c);
    this.orders_users=orders_users;
    notifyListeners();
  }

  setAllOrders_Mershant() async{
    Stream<QuerySnapshot>orders_mershant=await DbHelper.retrieveDataProductbyMershantId(HomeMershant.MershantId_c);
    this.orders_mershant=orders_mershant;
    notifyListeners();
  }

  setAllProduct_List(String UId) async{
    Stream<QuerySnapshot>product_list=await DbHelper.retrieveDataProductbyIdUM(HomeMershant.MershantId_c,UId);
    this.product_list=product_list;
    notifyListeners();
  }


//
//  setAllOrdersByUser(int UId) async{
//    if(UId == HomeClient.UserId_c){
//      List<Orders_Users>orders_users=await DbHelper.dbHelper.retrieveDataProductbyId(HomeClient.UserId_c);
//      this.orders_users=orders_users;
//      notifyListeners();
//    }
//  }

}