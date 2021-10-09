import 'package:flutter/cupertino.dart';

import '../../widgets/image_viewer/image_viewer.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('Open Image Viewer'),
          onPressed: () {
            showCupertinoDialog<void>(
              context: context,
              builder: (context) {

                return const ImageViewer(
                  imageProviders: [
                    NetworkImage('https://via.placeholder.com/800/0000FF/808080'),
                    NetworkImage('https://via.placeholder.com/800/FF0000/FFFFFF'),
                    NetworkImage('https://via.placeholder.com/800/FFFF00/000000'),
                    NetworkImage('https://via.placeholder.com/800/000000/FFFFFF'),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
