import 'dart:async';

import 'package:flutter/material.dart';

import 'course_download_progress.dart';
import 'home_page.dart';

void main() {
  runApp( MyApp());
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
    progressTimer ??= Timer.periodic(const Duration(seconds: 1), (timer){
      pv.value  = pv.value + 0.01;
      print('${pv.value}');
      if (pv.value >= 1) {
        print('???${pv.value}');
        pv.value = 0;
      }
    });
  }
}

