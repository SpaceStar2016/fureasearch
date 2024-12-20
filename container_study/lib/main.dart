import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  final ww = Center(
    child: Container(
      height: 300,
      width: 300,
      color: Colors.yellow,
    ),
  );
  const bb = BeautyWidget();
  Widget bbb = Center(
    child: BeautyRenderObjectWidget(child: Container(
      width: 50,
      height: 50,
      color: Colors.red,
    ),),
  );
  runApp(bbb);
  print('run end');
}

class BeautyWidget extends StatefulWidget {
  const BeautyWidget({super.key});

  @override
  State<BeautyWidget> createState() => _BeautyWidgetState();
}

class _BeautyWidgetState extends State<BeautyWidget> {
  bool showYellowContainer = false;

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     showYellowContainer = !showYellowContainer;
    //     setState(() {});
    //   },
    //   child: showYellowContainer
    //       ? Container(
    //           width: 100,
    //           height: 100,
    //           color: Colors.yellow,
    //         )
    //       : Container(
    //           width: 100,
    //           height: 100,
    //           color: Colors.green,
    //         ),
    // );

    // Center(
    //   child: Container(
    //     child: Center(
    //       child: Container(
    //         child: Text('12312'),
    //       ),
    //     ),
    //   ),
    // );

    // return showYellowContainer
    //     ? GestureDetector(
    //         onTap: () {
    //           showYellowContainer = !showYellowContainer;
    //           setState(() {});
    //         },
    //         child: Container(
    //           width: 100,
    //           height: 100,
    //           color: Colors.yellow,
    //         ),
    //       )
    //     : GestureDetector(
    //         onTap: () {
    //           showYellowContainer = !showYellowContainer;
    //           setState(() {});
    //         },
    //         child: Container(
    //           width: 100,
    //           height: 100,
    //           color: Colors.green,
    //         ),
    //       );

    return Center(
      child: Container(
        child: Text('12312'),
      ),
    );

    return showYellowContainer
        ? GestureDetector(
            key: const ValueKey('00'),
            onTap: () {
              showYellowContainer = !showYellowContainer;
              setState(() {});
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
            ),
          )
        : GestureDetector(
            key: const ValueKey('01'),
            onTap: () {
              showYellowContainer = !showYellowContainer;
              setState(() {});
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          );
  }

  @override
  void didUpdateWidget(covariant BeautyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }
}

class BeautyRenderObjectWidget extends SingleChildRenderObjectWidget {
  const BeautyRenderObjectWidget({super.key,super.child});
  @override
  RenderObject createRenderObject(BuildContext context) {
    return BeautyRenderObjectRenderBox();
  }
}

class BeautyRenderObjectRenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints);
      BoxParentData boxData = child!.parentData as BoxParentData;
      boxData.offset = const Offset(30, 120);
      size = child!.size;
    }  else {
      size = const Size(50, 50);
    }
  }
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      BoxParentData boxData = child!.parentData as BoxParentData;
      context.paintChild(child!, offset+boxData.offset);
    }
  }
}


