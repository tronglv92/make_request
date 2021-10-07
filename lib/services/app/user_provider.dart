import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makerequest/models/remote/user_response.dart';
import 'package:makerequest/services/app/auth_provider_firestore.dart';
import 'package:makerequest/services/firebase/user_database.dart';
import 'package:makerequest/services/safety/change_notifier_safety.dart';
import 'package:makerequest/utils/app_constant.dart';
import 'package:makerequest/utils/app_file.dart';
import 'package:makerequest/utils/app_log.dart';

class UserProvider extends ChangeNotifierSafety {
  UserProvider(AuthProviderFireStore auth) {
    _userDb = UserDatabase();
    _auth = auth;
    _picker = ImagePicker();
  }

  late UserDatabase _userDb;
  late AuthProviderFireStore _auth;
  late ImagePicker _picker;

  @override
  void resetState() {
    // TODO: implement resetState
  }

  Future<void> updateProfile(UserResponse userResponse) async {
    logger.e('updateProfile userResponse ', userResponse);
    await _userDb.setUser(user: userResponse, uid: userResponse.uid);
    _auth.setCurrentUser(userResponse);
    return;
  }

  Future<String?> updatePhotoUser(
      {required BuildContext context, required String uuid}) async {
    final XFile? pickedFileList = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFileList?.path == null) return null;
    final File? image = await _cropImage(pickedFileList!.path);
    if (image == null) return null;
    final String url = await AppFile.uploadFile(
        context: context, image: image, destination: PHOTO_PROFILE);
    final UserResponse? user = await _userDb.userStream(uuid).first;
    if(user==null) return null;
    user.photoUrl = url;
    await _userDb.updatePhoto(user: user, uuid: uuid);
    return url;
  }

  Future<File?> _cropImage(String path) async {
    final File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        maxHeight: 500,
        maxWidth: 500,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cropper',
        ));
    return croppedFile;
  }
}
