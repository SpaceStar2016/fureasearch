import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:research/dd_dart.dart';
import 'package:research/shader_demo/ui/shaders_list.dart';
import 'package:research/vs_read/visibility_detector.dart';

import 'course_download_progress.dart';
import 'home_page.dart';

void main() {
  final dd = Entry.test();
  WidgetsBinding.instance.addPostFrameCallback((d){
    print('addPostFrameCallback ${d.inMilliseconds}');
  });
  WidgetsBinding.instance.addPersistentFrameCallback((d){
    print('addPersistentFrameCallback ${d.inMilliseconds}');
  });

  SchedulerBinding.instance.scheduleFrameCallback((d){
    print('scheduleFrameCallback ${d.inMilliseconds}');
  });
  SchedulerBinding.instance.scheduleTask<void>(
        (){
      print('scheduleTask');
    },
    Priority.touch,
  );

  runApp(HomePage());

  // runApp(VisibilityDetector(
  //     key: const Key('me_page_widget_key'),
  //     onVisibilityChanged: (VisibilityInfo info) {
  //       // 完全出现才刷新
  //       if (info.visibleFraction == 1.0) {}
  //     },
  //     child: Container(
  //       width: 100,
  //       height: 100,
  //       color: Colors.black,
  //       child: MaterialApp(home: Scaffold(body: ShadersList())),
  //     )));

  // WidgetsBinding.instance.addPersistentFrameCallback((d) {
  //   print('addPersistentFrameCallback ${d.inMilliseconds}');
  // });
  // WidgetsBinding.instance.addPostFrameCallback((d) {
  //   print('addPostFrameCallback ${d.inMilliseconds}');
  // });
  // SchedulerBinding.instance.scheduleFrameCallback((d) {
  //   print('scheduleFrameCallback ${d.inMilliseconds}');
  // });
  // SchedulerBinding.instance.scheduleTask<void>(
  //   () {
  //     print('scheduleTask');
  //   },
  //   Priority.touch,
  // );
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
