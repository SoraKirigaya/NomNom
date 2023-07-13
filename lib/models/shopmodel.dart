import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PromotionModel {
  final String location;
  final String name;
  final int weight;
  final double money;
  final String picture;

  PromotionModel({
    required this.name,
    required this.weight,
    required this.money,
    required this.picture,
    required this.location,
  });

  factory PromotionModel.fromFirestore(DocumentSnapshot? doc) {
    Map data = doc!.data() as Map;
    return PromotionModel(
      location: data['location'] ?? '',
      name: data['name'] ?? '',
      weight: data['weight'] ?? 0,
      money: data['money']  == null ? 0.0 : data['money'].toDouble(),
      picture: data['picture'] ?? '',
    );
  }
}