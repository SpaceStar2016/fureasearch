

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((d){
    //   print('addPostFrameCallback ${d.inMilliseconds}');
    // });
    // WidgetsBinding.instance.addPersistentFrameCallback((d){
    //   print('addPersistentFrameCallback ${d.inMilliseconds}');
    // });
    //
    // SchedulerBinding.instance.scheduleFrameCallback((d){
    //   print('scheduleFrameCallback ${d.inMilliseconds}');
    // });
    // SchedulerBinding.instance.scheduleTask<void>(
    //       (){
    //     print('scheduleTask');
    //   },
    //   Priority.touch,
    // );
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text('count${count}'),
            GestureDetector(
              onTap: (){
                count++;
                setState(() {});
              },
              child: Text(
                '点我'
              ),
            )
          ],
        ),
      ),
    );
  }
}

