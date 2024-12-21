
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
//1.创建绘制记录器和Canvas
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);
  //2.在指定位置区域绘制。
  var rect = Rect.fromLTWH(30, 200, 300, 300);
  // 定义画笔
  final paint = Paint()
    ..color = Colors.yellow // 设置颜色为黄色
    ..style = PaintingStyle.fill; // 填充模式
  // 绘制正方形
  const double squareSize = 100; // 正方形边长
  const Offset topLeft = Offset(
    squareSize * 0.5, squareSize * 0.5, // 居中计算 y 坐标
  );
  canvas.drawRect(
    Rect.fromLTWH(topLeft.dx, topLeft.dy, squareSize, squareSize),
    paint,
  );
  //3.创建layer，将绘制的产物保存在layer中
  var pictureLayer = PictureLayer(rect);
  //recorder.endRecording()获取绘制产物。
  pictureLayer.picture = recorder.endRecording();
  var rootLayer = OffsetLayer();
  rootLayer.append(pictureLayer);
  //4.上屏，将绘制的内容显示在屏幕上。
  final SceneBuilder builder = SceneBuilder();
  final Scene scene = rootLayer.buildScene(builder);
  PlatformDispatcher.instance.views.last.render(scene);
  // window.render(scene);
  // while(true);
}

abstract class PictureRecorderTow {
  factory PictureRecorderTow() = ANewA;
}

class ANewA implements PictureRecorderTow {
  void printA() {
    print('ANewA');
  }
}
