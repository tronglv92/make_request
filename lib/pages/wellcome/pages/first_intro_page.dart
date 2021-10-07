import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_style.dart';

class FirstIntroPage extends StatefulWidget {
  @override
  _FirstIntroPageState createState() => _FirstIntroPageState();
}

class _FirstIntroPageState extends State<FirstIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 380.H,
          color: Colors.red,
        ),
         SizedBox(height: 60.H,),
        Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 50.W),
              child: Container(

                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                  children:  [
                    Text(
                       context.strings.titleSplash,
                      textAlign: TextAlign.center,
                      style: txt32BoldRoboto(color: Colors.black)),
                    SizedBox(height: 30.H,),
                    Text(
                      context.strings.messageLabel,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: txt18RegularRoboto(color: AppAssets.colorGrayOfText)


                    ),

                  ],
                ),
              ),
            ))
      ],
    );
  }
}
