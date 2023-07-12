import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final String name;
  final Color color;
  const RowItem({
    @required this.name,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color ?? Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              bottomRight: Radius.circular(9),
              bottomLeft: Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            color: color ?? Colors.green,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}