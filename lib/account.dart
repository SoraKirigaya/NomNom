import 'package:NomNom/account/purchase_history_page.dart';

import 'package:NomNom/login&signup/constant.dart';
import 'package:NomNom/login&signup/user_login_page.dart';
import 'package:NomNom/models/usersmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersModel>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            user != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    width: size.width,
                    height: 55,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PurchaseHistory(user: user);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Purchase History',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Vx.orange200,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  )
                : CircularProgressIndicator(),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              width: size.width,
              height: 55,
              child: TextButton(
                onPressed: () async {
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserLoginPage();
                      },
                    ),
                  );
                  context.showToast(
                      msg: 'You have logged out',
                      bgColor: Colors.green,
                      position: VxToastPosition.top);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
