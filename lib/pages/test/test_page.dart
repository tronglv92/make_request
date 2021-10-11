import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makerequest/widgets/w_button_rounded.dart';
import 'package:http/http.dart' as http;
import '../../widgets/image_viewer/image_viewer.dart';

class TestPage extends StatefulWidget {

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final String _token='dxDXDxa8RJexX3g472kUAX:APA91bHjY8UWsGaqMD6cDFR48--yxfBwcfSyhJVGFP_FiuyVk0np_71og4LTU_-JRw3ZPohjD01Frk3PI5VTYyc3mi1F3xoTLQ4JipVji_AyE1nPme9og0zRiEO-9wWRyLHOyIQV_v9I';
  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'key=AAAA6HGThNA:APA91bHaghZF6gE5E5KDudHbFTMpNz3kgJ67QaPIpXz3DhmgvE7Vp6kMN_qMWvWHGTTbEIBsy-GOKhoLXhU_VTlOgLwq8203mxnHTT8U2NHuM5vKO0IRCEdCLQf31WwTwrI0DLjRWYL8'
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(String? token) {

    return jsonEncode({
      'to': token,
      // 'message': {
      //   'token': token,
      //   'data': {
      //     'via': 'FlutterFire Cloud Messaging!!!',
      //     'count':'test',
      //   },
      //   'notification': {
      //     'title': 'Hello FlutterFire!',
      //     'body': 'This notification (#1) was created via FCM!',
      //   },
      // }
      "notification": {
        "body": "sample body",
        "OrganizationId": "2",
        "content_available": true,
        "mutable_content": true,
        "priority": "high",
        "subtitle": "sample sub-title",
        "Title": "hello"
      },
      "data": {
        "msgBody": "Body of your Notification",
        "msgTitle": "Title of your Notification",
        "msgId": "000001",
        "data": "This is sample payloadData"
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          sendPushMessage();
        },
      ),
    );
  }
}
