import 'package:NomNom/account.dart';
import 'package:NomNom/cart.dart';
import 'package:NomNom/models/usersmodel.dart';
import 'package:NomNom/services/firebase_database.dart';
import 'package:NomNom/shop/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageNumber = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;

  bool isloggedin() {
    User user = auth.currentUser;
    if (user != null) {
      uid = user.uid;
      setState(() {});
      return true;
    } else {
      uid = null;
      setState(() {});
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    isloggedin();

    return (uid != null)
        ? Scaffold(
            body: StreamProvider<UsersModel>.value(
                initialData: null,
                value: FirebaseDatabase().getCurrentUser(uid),
                builder: (context, child) => body(pageNumber, goToHome)),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: pageNumber,
              onTap: (value) {
                setState(
                  () {
                    pageNumber = value;
                  },
                );
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'Account'),
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  void goToHome() {
    setState(
      () {
        pageNumber = 0;
      },
    );
  }
}

Widget body(int index, Function goToHome) {
  switch (index) {
    case 0:
      return Shop();
      break;
    case 1:
      return Cart();
      break;
    case 2:
      return Account();
      break;
    default:
      return Shop();
      break;
  }
}
