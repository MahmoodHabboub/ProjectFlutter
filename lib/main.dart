import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DbHelper.dart';
import 'Featured.dart';
import 'HomeClient.dart';
import 'HomeMershant.dart';
import 'Login.dart';
import 'New_Product.dart';
import 'Product.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider<Featured>(create:(context)=>Featured(),),
    ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login(),
      ),
    );
  }
}
