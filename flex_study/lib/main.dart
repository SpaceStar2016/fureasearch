import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Container(
      width: 50,
      height: 50,
      color: Colors.yellow,
    ),
  );
  // runApp(
  //   ConstrainedBox(
  //     constraints: const BoxConstraints.tightFor(width: 50, height: 50),
  //     child: ColoredBox(
  //       color: Colors.black,
  //     ),
  //   ),
  // );
}
