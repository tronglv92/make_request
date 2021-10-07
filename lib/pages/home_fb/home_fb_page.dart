import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makerequest/services/app/auth_provider_firestore.dart';
import 'package:makerequest/services/safety/page_stateful.dart';
import 'package:makerequest/utils/app_route.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:provider/provider.dart';
class HomeFbPage extends StatefulWidget {
  @override
  _HomeFbPageState createState() => _HomeFbPageState();
}

class _HomeFbPageState extends PageStateful<HomeFbPage> {





  late AuthProviderFireStore _authProvider;

  @override
  void initState()
  {
    super.initState();
    _authProvider=context.read();
  }

  Future<void> onPressLogout() async{
    await _authProvider.signOut();
    Navigator.pushNamedAndRemoveUntil(context, AppRoute.routeLogin, (route) => false);
  }

@override
  void initDependencies(BuildContext context) {
    // TODO: implement initDependencies
    super.initDependencies(context);

  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Kindacode.com'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: Center(
        child: Text(_authProvider.currentUser?.phoneNumber??'',style: txt32BoldRoboto(),),
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: onPressLogout,
        child:const Icon(Icons.add),
      ),
    );
  }
}
