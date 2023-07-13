import 'package:NomNom/home.dart';
import 'package:NomNom/login&signup/constant.dart';
import 'package:NomNom/login&signup/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'round_button.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<UserLoginPage> {
  final GlobalKey<FormState> idKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  bool isloggedin() {
    User user = _auth.currentUser!;
    if (user != null) {
      uid = user.uid;
      return true;
    } else {
      uid = null;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String? email;
    String? password;
    isloggedin();
    return (uid == null)
        ? Scaffold(
            body: SafeArea(
            child: Form(
              key: idKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome to NomNom!',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
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
                          borderSide: BorderSide(color: kPrimaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                      onSaved: (value) {
                        email = value!;
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
                        password = value!;
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RoundedButton(
                      text: 'LOGIN',
                      press: () async {
                        idKey.currentState!.save();
                        if (idKey.currentState!.validate() == true) {
                          UserCredential userCredential;
                          try {
                            userCredential =
                                await _auth.signInWithEmailAndPassword(
                              email: email!.trim(),
                              password: password!,
                            );
                            print(userCredential);
                            context.showToast(
                                msg: "Logged in succesfully.",
                                bgColor: Colors.green,
                                textColor: Colors.white,
                                position: VxToastPosition.top);
                            setState(() {});
                            return 'success';
                          } catch (e) {
                            print(e);
                            context.showToast(
                                msg: "Incorrect Email / Password.",
                                bgColor: Colors.red,
                                textColor: Colors.white,
                                position: VxToastPosition.top);
                            return e;
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account ? ",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUp();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ))
        : Home();
  }
}
