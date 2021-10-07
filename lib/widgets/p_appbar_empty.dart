import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_theme.dart';
import 'package:makerequest/widgets/p_material.dart';

class PAppBarEmpty extends StatelessWidget {
  const PAppBarEmpty({required this.child, this.actionBtn,this.bottomNavigationBar, Key? key}) : super(key: key);

  final Widget child;
  final Widget? actionBtn;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.appTheme();
    return PMaterial(
      child: Scaffold(
        backgroundColor: theme.backgroundColor ,
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            elevation: 0,
            brightness: theme.isDark ? Brightness.dark : Brightness.light,
            backgroundColor: theme.headerBgColor,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: child,
        ),
        bottomNavigationBar:bottomNavigationBar ,
        floatingActionButton: actionBtn,
      ),
    );
  }
}
