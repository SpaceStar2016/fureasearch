import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  // runApp(
  //   Container(
  //     height: 50,
  //     width: 50,
  //     color: Colors.yellow,
  //   ),
  // );


  // runApp(
  //   Container(
  //     height: 50,
  //     width: 50,
  //     color: Colors.yellow,
  //   ),
  // );

  runApp(
    MyConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 50, height: 50),
      child: ColoredBox(
        color: Colors.yellow,
      ),
    ),
  );
}


class MyConstrainedBox extends SingleChildRenderObjectWidget {

  final BoxConstraints constraints;

  const MyConstrainedBox({required this.constraints, super.key, super.child});


  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyConstrainedBoxRenderObject();
  }

}

class MyConstrainedBoxRenderObject extends RenderBox {


}