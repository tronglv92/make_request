import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/*
This class represent all possible CRUD operation for FirebaseFirestore.
It contains all generic implementation needed based on the provided document
path and documentID,since most of the time in FirebaseFirestore design, we will have
documentID and path for any document and collections.
 */
class FireStoreService {
  FireStoreService._();
  static final FireStoreService instance = FireStoreService._();

  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final DocumentReference<Map<String, dynamic>> reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }

  Future<void> bulkSet({
    required String path,
    required List<Map<String, dynamic>> datas,
    bool merge = false,
  }) async {
    // final reference = FirebaseFirestore.instance.doc(path);
    // final batchSet = FirebaseFirestore.instance.batch();

//    for()
//    batchSet.

    print('$path: $datas');
  }

  Future<void> deleteData({required String path}) async {
    final DocumentReference<Map<String, dynamic>> reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
    // ignore: always_specify_types
    Query queryBuilder(Query query)?,
    int sort(T lhs, T rhs)?,
  }) {
    // ignore: always_specify_types
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    // ignore: always_specify_types
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((QuerySnapshot<Object?> snapshot) {
      final List<T> result = snapshot.docs
          .map((QueryDocumentSnapshot<Object?> snapshot) =>
          builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          // ignore: always_specify_types
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    // ignore: always_specify_types
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    // ignore: always_specify_types
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((DocumentSnapshot<Object?> snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}
