

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

