import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:makerequest/models/remote/todo_response.dart';

import 'firestore_path.dart';
import 'firestore_service.dart';



String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in FirebaseFirestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.
Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.
 */
class FireStoreDatabase {
  FireStoreDatabase({required this.uid});
  final String uid;

  final FireStoreService _firestoreService = FireStoreService.instance;

  //Method to create/update todoModel
  Future<void> setTodo(TodoResponse todo) async => await _firestoreService.set(
    path: FireStorePath.todo(uid, todo.id),
    data: todo.toMap(),
  );

  //Method to delete todoModel entry
  Future<void> deleteTodo(TodoResponse todo) async {
    await _firestoreService.deleteData(path: FireStorePath.todo(uid, todo.id));
  }

  //Method to retrieve todoModel object based on the given todoId
  Stream<TodoResponse> todoStream({required String todoId}) =>
      _firestoreService.documentStream(
        path: FireStorePath.todo(uid, todoId),
        builder: (Map<String, dynamic> data, String documentId) => TodoResponse.fromMap(data, documentId),
      );

  //Method to retrieve all todos item from the same user based on uid
  Stream<List<TodoResponse>> todosStream() => _firestoreService.collectionStream(
    path: FireStorePath.todos(uid),
    builder: (Map<String, dynamic> data, String documentId) => TodoResponse.fromMap(data, documentId),
  );

  //Method to mark all todoModel to be complete
  Future<void> setAllTodoComplete() async {
    final WriteBatch batchUpdate = FirebaseFirestore.instance.batch();

    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(FireStorePath.todos(uid))
        .get();

    // ignore: always_specify_types
    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchUpdate.update(ds.reference, <String,dynamic>{'complete': true});
    }
    await batchUpdate.commit();
  }

  Future<void> deleteAllTodoWithComplete() async {
    final WriteBatch batchDelete = FirebaseFirestore.instance.batch();

    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(FireStorePath.todos(uid))
        .where('complete', isEqualTo: true)
        .get();

    // ignore: always_specify_types
    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }
}
