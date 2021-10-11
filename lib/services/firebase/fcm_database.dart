import 'package:flutter/material.dart';
import 'package:makerequest/services/firebase/firestore_path.dart';

import 'firestore_service.dart';

class FcmDatabase {
  FcmDatabase();

  
  final FireStoreService _fireStoreService = FireStoreService.instance;
  Future<void> updateFcmUser(
      {required String userId, required String fcmToken}) async {
    await _fireStoreService.set(path: FireStorePath.fcmToken(userId), data: <String,dynamic>{'fcmToken':fcmToken});
    return;
  }
}
