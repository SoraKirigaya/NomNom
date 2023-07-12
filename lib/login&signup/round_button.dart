import 'package:NomNom/login&signup/constant.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor = Vx.orange900,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: 55,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: TextButton(
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: Vx.white, fontSize: 20),
          ),
          style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
        ),
      ),
    );
  }
}
