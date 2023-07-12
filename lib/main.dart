import 'package:NomNom/account/purchase_history_page.dart';

import 'package:NomNom/cart.dart';
import 'package:NomNom/home.dart';

import 'package:NomNom/login&signup/constant.dart';

import 'package:NomNom/shop/shop.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login&signup/user_login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Error connecting to the database.'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Montserrat',
                scaffoldBackgroundColor: Colors.white),
            title: 'Flutter Demo',
            home: UserLoginPage(),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(),
        );
      },
    );
  }
}
