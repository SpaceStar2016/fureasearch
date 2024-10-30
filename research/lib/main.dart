import 'dart:async';

import 'package:flutter/material.dart';
import 'package:research/dd_dart.dart';
import 'package:research/vs_read/visibility_detector.dart';

import 'course_download_progress.dart';
import 'home_page.dart';

void main() {
  final dd = Entry.test();
  runApp(VisibilityDetector(
      key: const Key('me_page_widget_key'),
      onVisibilityChanged: (VisibilityInfo info) {
        // 完全出现才刷新
        if (info.visibleFraction == 1.0) {}
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.black,
      )));
}

void queueTest() {
  Timer.run(() {
    print("executed");
  }); // Will never be executed.
  foo() {
    scheduleMicrotask(foo); // Schedules [foo] in front of other events.
  }

  foo();
  Future.delayed(Duration.zero).then((onValue) {
    print('Future0000');
  });
  Timer(Duration.zero, () {
    print('0001');
  });
  Timer.run(() {
    print('run0000');
  });
  Timer.run(() {
    print('run0001');
  });
  scheduleMicrotask(() {
    print('scheduleMicrotask');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? progressTimer;
  ValueNotifier<double> pv = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
      // home: ValueListenableBuilder(
      //   valueListenable: pv,
      //   builder: (BuildContext context, double value, Widget? child) {
      //     return CourseDownloadPage(progress: value,);
      //   }
      // ),
    );
  }

  void _startTimer() {
    progressTimer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      pv.value = pv.value + 0.01;
      print('${pv.value}');
      if (pv.value >= 1) {
        print('???${pv.value}');
        pv.value = 0;
      }
    });
  }
}
