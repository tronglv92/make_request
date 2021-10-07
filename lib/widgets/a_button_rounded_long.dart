import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_style.dart';

class AButtonRoundedLong extends StatelessWidget {
  const AButtonRoundedLong({required this.child,required this.onPress});
  final Widget child;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          primary: AppAssets.colorOrange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 15.H,horizontal: 20.W),
        ),
        child:Center(child: child)



    );
  }
}
