import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class AppFile{
  static Future<String> uploadFile({required BuildContext context,required  File image,required String destination}) {
    return context.read<AppFile>().upload(image,destination);

  }
  static Future<List<String>> uploadFiles({required BuildContext context,required List<File> images, required String destination}) {
    return context.read<AppFile>().uploads(images,destination);
  }
  Future<List<String>> uploads(List<File> _images,String destination) async {
    final List<String> imageUrls = await Future.wait(_images.map((_image) => upload(_image, destination)));
    print(imageUrls);
    return imageUrls;
  }

  Future<String> upload(File _image,String destination) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child(destination);
    final UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete((){});

    return await storageReference.getDownloadURL();
  }
}
