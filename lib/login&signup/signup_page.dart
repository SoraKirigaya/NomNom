import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:NomNom/login&signup/user_login_page.dart';

import 'package:NomNom/login&signup/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'constant.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> idKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: idKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Flexible(
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/grocery2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: kPrimaryLightColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  onSaved: (value) {
                    email = value;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: kPrimaryLightColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                RoundedButton(
                  text: 'SIGN UP',
                  press: () async {
                    bool registerUser = true;
                    idKey.currentState.save();
                    if (idKey.currentState.validate() == true) {
                      UserCredential userCredential;
                      try {
                        userCredential =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.trim(), password: password);
                      } catch (signUpError) {
                        registerUser = false;
                        context.showToast(
                            msg: 'Error registering user',
                            bgColor: Colors.red,
                            position: VxToastPosition.top);
                      }
                      final User user = userCredential.user;
                      if (registerUser == true) {
                        final userPath = 'users/${user.uid}';
                        final userReference =
                            FirebaseFirestore.instance.doc(userPath);
                        await userReference.set({
                          'password': password,
                          'email': email.trim(),
                        });
                        context.showToast(
                            msg: 'Account registered successfully',
                            bgColor: Colors.green,
                            position: VxToastPosition.top);
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserLoginPage();
                          },
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
