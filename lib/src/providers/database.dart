import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class Database {
  Future<void> addRating(Map<String, dynamic> ratingData);
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> addRating(Map<String, dynamic> ratingData) async {
    final path = 'users/$uid/rating/rating_abc';
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(ratingData);
  }
}
