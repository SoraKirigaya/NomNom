import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UsersModel {
  final String email;
  final String userID;
  UsersModel({
    this.userID,
    @required this.email,
  });
  factory UsersModel.fromMap(Map data, String userID) {
    if (data == null) return null;

    return UsersModel(
      email: data['email'] as String,
      userID: userID,
    );
  }
  factory UsersModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return UsersModel(
      email: data['email'] ?? '',
    );
  }
}
