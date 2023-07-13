import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ItemsModel {
  final String name;
  final double price;
  final int weight;
  final String picture;
  final String? id;

  ItemsModel({
    required this.name,
    required this.price,
    required this.weight,
    required this.picture,
    this.id,
  });

  factory ItemsModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    return ItemsModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: data['price'] == null ? 0.0 : data['price'].toDouble(),
      weight: data['weight'],
      picture: data['picture'] ?? '',
    );
  }
}
