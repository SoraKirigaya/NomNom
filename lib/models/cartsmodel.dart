import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CartsModel {
  final String name;
  final double price;
  final int weight;
  final String picture;
  final int count;
  final String id;

  CartsModel({
    required this.name,
    required this.price,
    required this.weight,
    required this.picture,
    required this.count,
    required this.id,
  });

  factory CartsModel.fromFirestore(DocumentSnapshot? doc) {
    Map data = doc!.data() as Map;
    return CartsModel(
      name: data['name'] ?? '',
      price: data['price'] == null ? 0.0 : data['price'].toDouble(),
      weight: data['weight'],
      picture: data['picture'] ?? '',
      count: data['count'] ?? '',
      id: data['id'] ?? '',
    );
  }
}
