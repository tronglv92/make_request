import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'app_bar.dart';

class DialogExample extends StatefulWidget {
  @override
  _DialogExampleState createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {


  void openBottomSheet(BuildContext context) => showBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const ContinuousRectangleBorder(),
    builder: (BuildContext context) {
      return PhotoViewGestureDetectorScope(
        axis: Axis.vertical,
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Colors.black.withAlpha(240),
          ),
          imageProvider:   NetworkImage('https://via.placeholder.com/800/0000FF/808080'),
          heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
        ),
      );
    },
  );



  @override
  Widget build(BuildContext context) {
    return ExampleAppBarLayout(
      title: "Dialogs integration",
      showGoBack: true,
      child: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: Colors.red),
            ),

            ElevatedButton(
              child: const Text("Bottom sheet"),
              onPressed: () => openBottomSheet(context),
            ),
            const Divider(),

          ],
        ),
      ),
    );
  }
}
