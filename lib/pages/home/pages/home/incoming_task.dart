import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_style.dart';
class IncomingTask extends StatelessWidget {
  const IncomingTask({required this.onPress});
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.W),
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 1,
          shadowColor: Colors.white.withOpacity(0.5),
          padding: EdgeInsets.only(
              left: 20.W, top: 15.H, bottom: 15.H, right: 15.W),
        ),
        child: Row(

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcomming meeting',
                    style: txt18BoldRoboto(),
                  ),
                  SizedBox(
                    height: 6.H,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8.W,
                      ),
                      Text(
                        '20 My 2021 | 04:28 PM',
                        style: txt12RegularRoboto(),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 40.W,
              width: 40.W,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
