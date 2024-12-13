import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
    const AColorWidget(),
  );
}

class AColorWidget extends StatefulWidget {
  const AColorWidget({super.key});

  @override
  State<AColorWidget> createState() => _AColorWidgetState();
}

class _AColorWidgetState extends State<AColorWidget> {
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isChange = !isChange;
        setState(() {});
      },
      child: Center(
        child: isChange ? const YellowContainer() : const BlackContainer(),
      ),
    );
  }

}

class YellowContainer extends StatefulWidget {
  const YellowContainer({super.key});

  @override
  State<YellowContainer> createState() => _YellowContainerState();
}

class _YellowContainerState extends State<YellowContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.yellow,
    );
  }
  @override
  void dispose() {
    super.dispose();
    print('YellowContainer dispose');
  }
}

class BlackContainer extends StatefulWidget {
  const BlackContainer({super.key});

  @override
  State<BlackContainer> createState() => _BlackContainerState();
}

class _BlackContainerState extends State<BlackContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }
  @override
  void dispose() {
    super.dispose();
    print('BlackContainer dispose');
  }
}


