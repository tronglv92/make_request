import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/utils/app_extension.dart';
class CurrentTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20.W, right: 20.W, top: 30.H, bottom: 10.H),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset:const Offset(0, 4),
                blurRadius: 5.0)
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              Color.fromRGBO(239, 142, 82, 1),
              Color.fromRGBO(241, 149, 86, 1),
            ],
          ),
        ),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              padding: EdgeInsets.only(
                  left: 15.W, top: 20.H, bottom: 15.H),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.W,
                    width: 50.W,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(241, 149, 86, 1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.white,
                        size: 30.W,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.W,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aldohr Prayer",
                          style:
                          txt18BoldRoboto(color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.H,
                        ),
                        Row(
                          children: [
                            Text(
                              "Next Prayer AlAser 04:28 PM",
                              style: txt12RegularRoboto(
                                  color: Colors.white60),
                            ),
                            SizedBox(
                              width: 15.W,
                            ),
                            Text(
                              "Gaza Strip - July 2, 2021",
                              style: txt10RegularRoboto(
                                  color: Colors.white60),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.H,
                        ),
                        Container(
                          height: 30.H,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (BuildContext context,
                                  int index) {
                                return Padding(
                                  padding:
                                  EdgeInsets.only(right: 15.W),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Alfajer",
                                        style: txt10RegularRoboto(
                                            color: Colors.white60),
                                      ),
                                      SizedBox(
                                        height: 4.H,
                                      ),
                                      Text(
                                        "04:28 PM",
                                        style: txt10RegularRoboto(
                                            color: Colors.white60),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
