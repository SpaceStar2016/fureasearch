import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../vs_read/visibility_detector.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: VisibilityDetector(
            key: const Key('me_page_widget_key'),
            onVisibilityChanged: (VisibilityInfo info) {
              print('VisibilityInfo---${info.size}---${info.visibleFraction}');
              // 完全出现才刷新
              if (info.visibleFraction == 1.0) {}
            },
            child: Container(color: Colors.green, child: Text('Page Two'))),
      ),
    );
  }
}
