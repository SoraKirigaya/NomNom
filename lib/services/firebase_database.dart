import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:NomNom/models/cartsmodel.dart';
import 'package:NomNom/models/itemsmodel.dart';
import 'package:NomNom/models/purchistorymodel.dart';
import 'package:NomNom/models/shopmodel.dart';
import 'package:NomNom/models/usersmodel.dart';

class FirebaseDatabase {
  final CollectionReference shopCollectionReference =
      FirebaseFirestore.instance.collection('shop');

  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<PromotionModel>> getPromotionDetails() {
    return shopCollectionReference
        .doc('products')
        .collection('details')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => PromotionModel.fromFirestore(doc)).toList());
  }

  Stream<List<ItemsModel>> getItemsDetails(String category) {
    return shopCollectionReference
        .doc('category')
        .collection(category)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => ItemsModel.fromFirestore(doc)).toList());
  }

  Stream<List<CartsModel>> getCartsDetails(String userID) {
    return userCollectionReference
        .doc(userID)
        .collection('cart')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => CartsModel.fromFirestore(doc)).toList());
  }

  Stream<List<PurcHistoryModel>> getPurchHistoryDetails(String userID) {
    return userCollectionReference
        .doc(userID)
        .collection('history')
        .snapshots()
        .map((list) => 
            list.docs.map((doc) => PurcHistoryModel.fromFirestore(doc)).toList());
  }

  Stream<UsersModel> getCurrentUser(String usersID) {
    try {
      final ref = db.doc('users/$usersID').snapshots();
      return ref.map((snapshot) => UsersModel.fromMap(
            snapshot.data(),
            usersID,
          ));
    } catch (e) {
      rethrow;
    }
  }
}
