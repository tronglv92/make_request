import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/widgets/a_item_tab.dart';
import 'custom_bottom_navigation.dart';

class AppBottomNavigator extends StatefulWidget {
  const AppBottomNavigator({required this.onPressTab,required this.onPressAdd});

  final Function onPressTab;
  final Function onPressAdd;

  @override
  _AppBottomNavigatorState createState() => _AppBottomNavigatorState();
}

class _AppBottomNavigatorState extends State<AppBottomNavigator> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.H,
      width: 1.SW,
      color: AppAssets.colorGrayBackGround,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: CustomBottomNavigation(shadows: [
              Shadow(
                offset: const Offset(5, 5),
                blurRadius: 15.0,
                color: Colors.black.withOpacity(0.5),
              )
            ]),
            size: Size(1.SW, 90.H),
          ),
          Row(
            children: [
              Expanded(
                child: AItemTab(
                    label: 'Home',
                    iconData: Icons.home_outlined,
                    isSelected: indexSelected == 0,
                    index: 0,
                    onPress: (int index) {
                      if (indexSelected != index) {
                        setState(() {
                          indexSelected = index;
                        });
                        widget.onPressTab(index);
                      }
                    }),
              ),
              Expanded(
                child: AItemTab(
                    label: 'My Calendar',
                    iconData: Icons.call,
                    isSelected: indexSelected == 1,
                    index: 1,
                    onPress: (int index) {
                      if (indexSelected != index) {
                        setState(() {
                          indexSelected = index;
                        });
                        widget.onPressTab(index);
                      }
                    }),
              ),
              Expanded(
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 42.H,
                    ),
                    Text(
                      'Invite Guest',
                      style: txt10RegularRoboto(color: Colors.grey),
                    ),
                  ],
                )),
              ),
              Expanded(
                child: AItemTab(
                    label: 'My Request',
                    iconData: Icons.wb_sunny,
                    isSelected: indexSelected == 2,
                    index: 2,
                    onPress: (int index) {
                      if (indexSelected != index) {
                        setState(() {
                          indexSelected = index;
                        });
                        widget.onPressTab(index);
                      }
                    }),
              ),
              Expanded(
                child: AItemTab(
                    label: 'My Attendance',
                    iconData: Icons.alarm,
                    isSelected: indexSelected == 3,
                    index: 3,
                    onPress: (int index) {
                      if (indexSelected != index) {
                        setState(() {
                          indexSelected = index;
                        });
                        widget.onPressTab(index);
                      }
                    }),
              )
            ],
          ),
          Positioned(
            left: 1.SW / 2 - 55.W / 2,
            bottom: 80.H,
            child: SizedBox(
              width: 55.W,
              height: 55.W,
              child: FloatingActionButton(
                elevation: 5,
                onPressed: () {
                  widget.onPressAdd();
                },
                backgroundColor: Colors.deepOrange,
                child: const Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
