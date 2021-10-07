import 'dart:async';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:makerequest/models/remote/todo_response.dart';
import 'package:makerequest/models/remote/user_response.dart';

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
class UserDatabase {
  UserDatabase() ;

  final FireStoreService _fireStoreService = FireStoreService.instance;

  //Method to create/update user
  Future<void> setUser({required UserResponse user,required String uid}) async => await _fireStoreService.set(

    path: FireStorePath.user(uid),
    data: user.toJson(),
  );
  Future<void> updatePhoto({required UserResponse user,required String uuid}) async {
    return _fireStoreService.set(path: FireStorePath.user(uuid), data:user.toJson());
  }
  Stream<UserResponse?> userStream(String uid) {
    return _fireStoreService.documentStream(
      path: FireStorePath.user(uid),
      builder: (Map<String, dynamic> data, String documentId) => data!=null?UserResponse.fromJson(data):null,
    );
  }



}
