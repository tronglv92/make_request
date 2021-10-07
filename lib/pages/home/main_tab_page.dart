import 'package:flutter/material.dart';
import 'package:makerequest/pages/home/home_provider.dart';
import 'package:makerequest/pages/home/pages/home/home_page.dart';
import 'package:makerequest/services/safety/page_stateful.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_log.dart';
import 'package:makerequest/utils/app_route.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/widgets/p_appbar_empty.dart';
import 'package:makerequest/widgets/p_appbar_transparency.dart';
import 'package:makerequest/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';

import 'bottom_tab/app_bottom_navigator.dart';
import 'bottom_tab/custom_bottom_navigation.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends PageStateful<MainTabPage>
    with WidgetsBindingObserver, RouteAware {
  late HomeProvider homeProvider;
  late PageController _pageController;
  bool _showBottomSheet=true;
  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    homeProvider = Provider.of(context, listen: false);
  }

  @override
  void afterFirstBuild(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRoute.I.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    /// Called when the current route has been pushed.
    logger.d('didPush');
  }

  @override
  void didPopNext() {
    /// Called when the top route has been popped off, and the current route
    /// shows up.
    logger.d('didPopNext');
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    AppRoute.I.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Log app life cycle state
    logger.d(state);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PAppBarTransparency(
      backgroundColor: AppAssets.colorGrayBackGround,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),

        children: [
          HomePage(),
          Container(
            color: Colors.orange,
            child: const Center(
                child: Text(
              'Page 2',
              style: TextStyle(color: Colors.white),
            )),
          ),
          Container(
            color: Colors.blue,
            child: const Center(
                child: Text(
              'Page 3',
              style: TextStyle(color: Colors.white),
            )),
          ),
          Container(
            color: Colors.green,
            child: const Center(
                child: Text(
              'Page 4',
              style: TextStyle(color: Colors.white),
            )),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigator(
        onPressTab: (int index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 100), curve: Curves.ease);
        },
        onPressAdd: () {},
      ),

    );
  }
}
