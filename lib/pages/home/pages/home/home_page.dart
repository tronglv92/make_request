import 'package:flutter/material.dart';
import 'package:makerequest/pages/home/pages/home/header_home.dart';
import 'package:makerequest/pages/home/pages/home/recent_tasks.dart';

import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_extension.dart';

import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/widgets/p_appbar_transparency.dart';
import 'package:makerequest/widgets/w_keyboard_dismiss.dart';

import 'current_task.dart';
import 'incoming_task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  void _showTask(BuildContext context) {
    showModalBottomSheet<void>(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.65,
            child: Container(
              decoration:const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.H),
                    height: 4.H,
                    width: 100.W,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(236, 236, 236, 1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.W),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.H,
                        ),
                        Text(
                          'Request info',
                          style: txt18BoldRoboto(),
                        ),
                        SizedBox(
                          height: 25.H,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 52.W,
                              width: 52.W,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 20.W,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mohammed Award',
                                    style: txt16RegularRoboto(),
                                  ),
                                  SizedBox(
                                    height: 6.H,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 15.W,
                                        width: 15.W,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5.W,
                                      ),
                                      Text(
                                        'General Manager',
                                        style: txt12RegularRoboto(
                                            color: AppAssets.colorGrayOfText),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.H,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 15.W,
                                        width: 15.W,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5.W,
                                      ),
                                      Text(
                                        'Mohamed-32@gmail.com',
                                        style: txt12RegularRoboto(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.H,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 15.W,
                                        width: 15.W,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5.W,
                                      ),
                                      Text(
                                        '+ 950 988 28477',
                                        style: txt12RegularRoboto(
                                            color: AppAssets.colorGrayOfText),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35.H,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.W, vertical: 10.H),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(248, 248, 248, 1)),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 35.W,
                                    height: 35.W,
                                    child: Center(
                                      child: Icon(Icons.person_outline,size: 25,),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.W,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nationallity',
                                        style: txt16RegularRoboto(),
                                      ),
                                      Text(
                                        'Palestinain',
                                        style: txt12RegularRoboto(
                                            color: AppAssets.colorGrayOfText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30.W,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.W, vertical: 10.H),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(248, 248, 248, 1)),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 35.W,
                                    height: 35.W,
                                    child: Center(
                                      child: Icon(Icons.person_outline,size: 25,),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.W,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nationallity',
                                        style: txt16RegularRoboto(),
                                      ),
                                      Text(
                                        'Palestinain',
                                        style: txt12RegularRoboto(
                                            color: AppAssets.colorGrayOfText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.H,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 140.H,
                              width: 140.W,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(250, 249, 249, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            SizedBox(width: 20.W,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Car model',
                                  style: txt14RegularRoboto(),
                                ),
                                Text(
                                  'BMW',
                                  style: txt10RegularRoboto(
                                      color: AppAssets.colorGrayOfText),
                                ),
                                SizedBox(height: 12.H,),
                                Text(
                                  'Car model',
                                  style: txt14RegularRoboto(),
                                ),
                                Text(
                                  'BMW',
                                  style: txt14RegularRoboto(
                                      color: AppAssets.colorGrayOfText),
                                ),
                                SizedBox(height: 12.H,),
                                Text(
                                  'Car model',
                                  style: txt14RegularRoboto(),
                                ),
                                Text(
                                  'BMW',
                                  style: txt14RegularRoboto(
                                      color: AppAssets.colorGrayOfText),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 15.H,),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                primary: Color.fromRGBO(230, 144, 83, 1),
                                padding: EdgeInsets.symmetric(horizontal: 5.W,vertical: 5.H),
                                elevation: 3),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.W,
                                  width: 40.W,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromRGBO(235, 166, 117, 1)),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.W,
                                        width: 5.W,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'One time | 2 guest',
                                        style: txt12RegularRoboto(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60.W,
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WKeyboardDismiss(
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.H,
              ),
              HeaderHome(),
              CurrentTask(),

              //First Item
              IncomingTask(
                onPress: () {
                  _showTask(context);
                },
              ),

              // Second item

              // three item
              Expanded(child: RecentTasks())
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
