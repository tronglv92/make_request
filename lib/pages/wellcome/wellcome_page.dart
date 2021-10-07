import 'package:flutter/material.dart';

import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/widgets/p_appbar_empty.dart';
import 'package:makerequest/widgets/w_button_rounded_short.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:makerequest/utils/app_extension.dart';

import 'pages/first_intro_page.dart';

class WellComePage extends StatefulWidget {
  @override
  _WellComePageState createState() => _WellComePageState();
}

class _WellComePageState extends State<WellComePage> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PAppBarEmpty(
        child: Column(
      children: [
        Expanded(
          child: PageView(
            children: [
              FirstIntroPage(),
              FirstIntroPage(),
              FirstIntroPage(),
            ],
            scrollDirection: Axis.horizontal,
            controller: _pageController,
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 4.W,
            dotWidth: 4.W,
            dotColor: const Color.fromRGBO(127, 130, 138, 1),
            activeDotColor: const Color.fromRGBO(127, 130, 138, 1),
            strokeWidth: 7.W,
          ),
        ),
        SizedBox(
          height: 40.H,
        ),
        WButtonRoundedShort(
            child: Center(
              child: Icon(
                Icons.arrow_forward_sharp,
                color: Colors.white,
                size: 30.W,
              ),
            ),
            onPressed: () {}),
        SizedBox(
          height: 40.H,
        ),
      ],
    ));
  }
}
