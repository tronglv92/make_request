import 'package:flutter/material.dart';

class AppAssets {
  AppAssets._();

  /// Default theme
  factory AppAssets.origin() {
    return AppAssets._();
  }

  ///#region FONTS
  /// -----------------
  static String fontRoboto = 'Roboto';
  static String fontLato = 'Lato';
  static String fontIOSDisplay = '.SF UI Display';
  static String fontIOSDefault = '.SF UI Text';

  ///#endregion


  ///#region COLORS
  /// -----------------
  static Color colorGrayOfText= const Color.fromRGBO(107, 104, 112, 1);
  static Color colorGrayIcon= const Color.fromRGBO(235,	235,	235, 1);
  static Color colorGrayBackGround= const Color.fromRGBO(244, 244, 247, 1);
  static Color colorOrange=const Color.fromRGBO(222, 78, 42, 1);

  ///#endregion

  ///#region IMAGES, ICONS
  /// -----------------
  String icAppIcon = 'assets/base/icons/app_icon_ad.png';
  String icEmpty = 'assets/base/icons/ic_empty.png';

  ///#endregion

  ///#region VIDEOS
  /// -----------------
  ///#endregion


}
