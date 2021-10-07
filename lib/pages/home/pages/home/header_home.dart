import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/utils/app_extension.dart';
class HeaderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.W),
      child: Row(
        children: [
          Container(
            height: 50.W,
            width: 50.W,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 15.W,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wesam Shama',
                  style: txt18BoldRoboto(),
                ),
                SizedBox(
                  height: 2.H,
                ),
                Text(
                  'General Manager',
                  style: txt14RegularRoboto(
                      color: AppAssets.colorGrayOfText),
                )
              ],
            ),
          ),
          Stack(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: AppAssets.colorGrayIcon,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    fixedSize: Size(40.W, 40.W),
                    minimumSize: Size(40.W, 40.W),
                    padding: const EdgeInsets.all(0),
                    elevation: 0),
                child: const Center(
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 8.W,
                    width: 8.W,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(8.W / 2),
                        color: Colors.deepOrange),
                  ))
            ],
          ),
          SizedBox(
            width: 10.W,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: AppAssets.colorGrayIcon,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                fixedSize: Size(40.W, 40.W),
                minimumSize: Size(40.W, 40.W),
                padding: const EdgeInsets.all(0),
                elevation: 0),
            child: const Center(
              child: Icon(
                Icons.menu,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
