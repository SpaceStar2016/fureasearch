import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  // runApp(
  //   Container(
  //     width: 50,
  //     height: 50,
  //     color: Colors.yellow,
  //   ),
  // );

  runApp(
    ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 50, height: 50),
      child: ColoredBox(
        color: Colors.black,
      ),
    ),
  );

  // runApp(
  //   MyConstrainedBox(
  //     constraints: const BoxConstraints.tightFor(width: 50, height: 50),
  //     child: ColoredBox(
  //       color: Colors.black,
  //     ),
  //   ),
  // );
}

class MyConstrainedBox extends SingleChildRenderObjectWidget {
  final BoxConstraints constraints;
  const MyConstrainedBox({super.key, super.child, required this.constraints});
  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyConstrainedBoxRenderBox();
  }
}

class MyConstrainedBoxRenderBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {

  // @override
  // final BoxConstraints constraints;

  MyConstrainedBoxRenderBox();
  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints);
      size = child!.size;
    } else {
      size = const Size(50, 50);
    }
  }
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }
}
