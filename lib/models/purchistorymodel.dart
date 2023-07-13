import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PurcHistoryModel {
  final String id;
  final double price;

  PurcHistoryModel({
    required this.id,
    required this.price,
  });

  factory PurcHistoryModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return PurcHistoryModel(
      id: data['id'] ?? '',
      price: data['price'] == null ? 0.0 : data['price'].toDouble(),
    );
  }
}
