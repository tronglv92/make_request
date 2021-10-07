import 'dart:math';

import 'package:flutter/material.dart';
class CustomBottomNavigation extends CustomPainter{
  CustomBottomNavigation({required this.shadows});
  final List<Shadow> shadows;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint_0 = new Paint()
      ..color =Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.lineTo(size.width*0.375, 0);


    path_0.quadraticBezierTo(0.40625 *size.width, 0*size.height, 0.4375*size.width, 0.1875*size.height);

    path_0.quadraticBezierTo(size.width*0.5,size.height*(0.5-(0.0625)),size.width*0.5625,size.height*0.1875);

    path_0.quadraticBezierTo(size.width*0.59375
        ,0*size.height,size.width*0.625,0);
    path_0.lineTo(size.width,0);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(0,size.height);
    // path_0.lineTo(size.width*0.0013000,size.height);
    // canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    // shadows.forEach((s) {
    //   canvas.save();
    //   canvas.translate(s.offset.dx, s.offset.dy);
    //   canvas.drawShadow(path_0, s.color, sqrt(s.blurRadius), false);
    //   canvas.restore();
    // });
    canvas.drawShadow(path_0, Colors.black,15, false);
    canvas.drawPath(path_0, paint_0);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
   return true;
  }

}
