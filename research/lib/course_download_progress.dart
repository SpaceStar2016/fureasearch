import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseDownloadPage extends StatefulWidget {

  final double progress;
  const CourseDownloadPage({super.key, required this.progress});

  @override
  State<StatefulWidget> createState() {
    return _CourseDownloadPageState();
  }
}

class _CourseDownloadPageState extends State<CourseDownloadPage>{

  String word = 'I love Space';

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('正在加载 ${(widget.progress * 100 ).toInt()}%',style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 48/3
          ),),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: CourseDownloadProgressBar(progress: widget.progress,),
          ),
          SizedBox(height: 12,),
          Text(word,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.5),
                fontSize: 48/3
            ),)
        ],
      ),
    );
  }

}

class CourseDownloadProgressBar extends LeafRenderObjectWidget {


  final double progress;

  const CourseDownloadProgressBar({required this.progress, super.key});


  @override
  RenderObject createRenderObject(BuildContext context) {
    return CourseProgressBarRender(backgroundColor: Color(0XFFDFE1E7),progressColor: Color(0xFF00C87E),borderRadius: 10,progress: progress);
  }

  @override
  void updateRenderObject(BuildContext context, covariant CourseProgressBarRender renderObject) {
    // 更新进度，注意这里为什么不需要的调用markNeedsPaint 也能刷新，
    // 貌似这两段代码效果一样
    // renderObject.progress = progress;
    print('-----');
    renderObject.updateProgress(progress);
  }

}

class CourseProgressBarRender extends RenderBox {

  Color backgroundColor;

  Color progressColor;

  double borderRadius;

  double progress;

  CourseProgressBarRender({
    required this.backgroundColor,
    required this.progressColor,
    required this.borderRadius,
    required this.progress,
  });

  updateProgress(double value){
    if (progress != value) {
      progress = value;
      markNeedsPaint(); // 标记需要重新绘制
    }
  }

  // 布局阶段
  @override
  void performLayout() {
    size = constraints.constrain(const Size(double.infinity, 40.0 / 3)); // 固定高度，宽度取决于父布局
  }


  // 绘制阶段：布局完成后，进入绘制阶段。
  // 在这个阶段，父组件负责告诉子组件应该在父组件的哪个位置进行绘制。
  // 这时，位置信息（Offset）会作为参数传递给子组件的 paint 方法。
  // 这个时候，位置信息和大小都已经确定了
  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Paint backgroundPaint = Paint();
    backgroundPaint.color = backgroundColor;
    final Paint progressPaint = Paint();
    progressPaint.color = progressColor;

    // Dart 语法糖 相当于Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    final Rect backgroundRect = offset & size;

    final RRect backgroundRRect = RRect.fromRectAndRadius(
      backgroundRect,
      Radius.circular(borderRadius),
    );

    // 绘制背景
    canvas.drawRRect(backgroundRRect, backgroundPaint);

    final double progressWidth = size.width * progress;

    // 绘制进度条
    final Rect progressRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      progressWidth,
      size.height,
    );

    final RRect progressRRect = RRect.fromRectAndRadius(
      progressRect,
      Radius.circular(borderRadius),
    );
    // 绘制背景
    canvas.drawRRect(progressRRect, progressPaint);
  }
}





// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Chat message RenderBox',
//       home: ChatAppConversationView(),
//     );
//   }
// }
//
// /// A full-screen widget which vaguely resembles a chat app's conversation view.
// ///
// /// The main purpose of the [ChatAppConversationView] class is to feed the value
// /// from a [TextEditingController] into a [TimestampedChatMessage] widget. The
// /// [TimestampedChatMessage] is the real star of the show.
// class ChatAppConversationView extends StatefulWidget {
//   const ChatAppConversationView({super.key});
//
//   @override
//   State<ChatAppConversationView> createState() =>
//       _ChatAppConversationViewState();
// }
//
// class _ChatAppConversationViewState extends State<ChatAppConversationView> {
//   final TextEditingController _controller = TextEditingController();
//   final String sentAt = '3 seconds ago';
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.text =
//     'Hello?! this is a message! If you read it for long enough, '
//         'your brain will grow';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: 220,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               (_controller.text != '')
//                   ? Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   color: Colors.blue[100]!,
//                   padding: const EdgeInsets.all(15),
//                   // ListenableBuilder is available in Flutter 3.10
//                   child: ListenableBuilder(
//                     listenable: _controller,
//                     builder: (context, widget) {
//                       return TimestampedChatMessage(
//                         text: _controller.text,
//                         sentAt: sentAt,
//                         style: const TextStyle(color: Colors.red),
//                       );
//                     },
//                   ),
//                 ),
//               )
//                   : Container(),
//               const SizedBox(height: 50),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 25),
//                 child: TextField(
//                   controller: _controller,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Simplified variant of the [Text] widget which accepts both a primary string
// /// for the raw text body, and a secondary `sentAt` string which annotates the
// /// former with a timestamp, similar to how popular chat apps like WhatsApp
// /// render individual messages.
// ///
// /// The [TimestampedChatMessage] extends [LeafRenderObjectWidget], which means
// /// it has no children and instead creates a [TimestampedChatMessageRenderObject],
// /// which handles all layout and painting itself.
// class TimestampedChatMessage extends LeafRenderObjectWidget {
//   const TimestampedChatMessage({
//     super.key,
//     required this.text,
//     required this.sentAt,
//     this.style,
//   });
//
//   final String text;
//   final String sentAt;
//   final TextStyle? style;
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
//     TextStyle? effectiveTextStyle = style;
//     if (style == null || style!.inherit) {
//       effectiveTextStyle = defaultTextStyle.style.merge(style);
//     }
//     return TimestampedChatMessageRenderObject(
//       text: text,
//       sentAt: sentAt,
//       textDirection: Directionality.of(context),
//       textStyle: effectiveTextStyle!,
//       sentAtStyle: effectiveTextStyle.copyWith(color: Colors.grey),
//     );
//   }
//
//   @override
//   void updateRenderObject(
//       BuildContext context,
//       TimestampedChatMessageRenderObject renderObject,
//       ) {
//     final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
//     TextStyle? effectiveTextStyle = style;
//     if (style == null || style!.inherit) {
//       effectiveTextStyle = defaultTextStyle.style.merge(style);
//     }
//     renderObject.text = text;
//     renderObject.textStyle = effectiveTextStyle!;
//
//     renderObject.sentAt = sentAt;
//     renderObject.sentAtStyle = effectiveTextStyle.copyWith(color: Colors.grey);
//
//     renderObject.textDirection = Directionality.of(context);
//   }
// }
//
// /// Simplified variant of [RenderParagraph] which supports the
// /// [TimestampedChatMessage] widget.
// ///
// /// Like the [Text] widget and its inner [RenderParagraph], the
// /// [TimestampedChatMessageRenderObject] makes heavy use of the [TextPainter]
// /// class.
// class TimestampedChatMessageRenderObject extends RenderBox {
//   TimestampedChatMessageRenderObject({
//     required String sentAt,
//     required String text,
//     required TextStyle sentAtStyle,
//     required TextStyle textStyle,
//     required TextDirection textDirection,
//   }) {
//     _text = text;
//     _sentAt = sentAt;
//     _textStyle = textStyle;
//     _sentAtStyle = sentAtStyle;
//     _textDirection = textDirection;
//     _textPainter = TextPainter(
//       text: textTextSpan,
//       textDirection: _textDirection,
//     );
//     _sentAtTextPainter = TextPainter(
//       text: sentAtTextSpan,
//       textDirection: _textDirection,
//     );
//   }
//
//   late TextDirection _textDirection;
//   late String _text;
//   late String _sentAt;
//   late TextPainter _textPainter;
//   late TextPainter _sentAtTextPainter;
//   late TextStyle _sentAtStyle;
//   late TextStyle _textStyle;
//   late bool _sentAtFitsOnLastLine;
//   late double _lineHeight;
//   late double _lastMessageLineWidth;
//   double _longestLineWidth = 0;
//   late double _sentAtLineWidth;
//   late int _numMessageLines;
//
//   set sentAt(String val) {
//     if (val == _sentAt) return;
//     _sentAt = val;
//     // `sentAtTextSpan` is a computed property that incorporates both the raw
//     // string value and the [TextStyle], so we have to update the whole [TextSpan]
//     // any time either value is updated.
//     _sentAtTextPainter.text = sentAtTextSpan;
//     markNeedsLayout();
//
//     // Because changing any text in our widget will definitely change the
//     // semantic meaning of this piece of our UI, we need to call
//     markNeedsSemanticsUpdate();
//   }
//
//   set sentAtStyle(TextStyle val) {
//     if (val == _sentAtStyle) return;
//     _sentAtStyle = val;
//     // `sentAtTextSpan` is a computed property that incorporates both the raw
//     // string value and the [TextStyle], so we have to update the whole [TextSpan]
//     // any time either value is updated.
//     _sentAtTextPainter.text = sentAtTextSpan;
//     markNeedsLayout();
//   }
//
//   String get text => _text;
//   set text(String val) {
//     if (val == _text) return;
//     _text = val;
//     _textPainter.text = textTextSpan;
//     markNeedsLayout();
//     // Because changing any text in our widget will definitely change the
//     // semantic meaning of this piece of our UI, we need to call
//     markNeedsSemanticsUpdate();
//   }
//
//   TextStyle get textStyle => _textStyle;
//   set textStyle(TextStyle val) {
//     if (val == _textStyle) return;
//     _textStyle = val;
//     _textPainter.text = textTextSpan;
//
//     // If we knew that the new [TextStyle] had only changed in certain ways (e.g.
//     // color) then we could be more performant and call `markNeedsPaint()` instead.
//     // However, without carefully making that assessment, it is safer to call
//     // the more generic method, `markNeedsLayout()` instead (which also implies
//     // a repaint).
//     markNeedsLayout();
//   }
//
//   set textDirection(TextDirection val) {
//     if (_textDirection == val) {
//       return;
//     }
//     _textDirection = val;
//     _textPainter.textDirection = val;
//     _sentAtTextPainter.textDirection = val;
//     markNeedsSemanticsUpdate();
//     markNeedsLayout();
//   }
//
//   TextSpan get textTextSpan => TextSpan(text: _text, style: _textStyle);
//   TextSpan get sentAtTextSpan => TextSpan(text: _sentAt, style: _sentAtStyle);
//
//   @override
//   void describeSemanticsConfiguration(SemanticsConfiguration config) {
//     super.describeSemanticsConfiguration(config);
//     // Set this to `true` because individual chat bubbles are perfectly
//     // self-contained semantic objects.
//     config.isSemanticBoundary = true;
//
//     config.label = '$_text, sent $_sentAt';
//     config.textDirection = _textDirection;
//   }
//
//   @override
//   double computeMinIntrinsicWidth(double height) {
//     // Ignore `height` parameter because chat bubbles' height grows as a
//     // function of available width and text length.
//
//     _layoutText(double.infinity);
//     return _longestLineWidth;
//   }
//
//   @override
//   double computeMinIntrinsicHeight(double width) =>
//       computeMaxIntrinsicHeight(width);
//
//   @override
//   double computeMaxIntrinsicHeight(double width) {
//     final computedSize = _layoutText(width);
//     return computedSize.height;
//   }
//
//   @override
//   void performLayout() {
//     final unconstrainedSize = _layoutText(constraints.maxWidth);
//     size = constraints.constrain(
//       Size(unconstrainedSize.width, unconstrainedSize.height),
//     );
//   }
//
//   /// Lays out the text within a given width constraint and returns its [Size].
//   ///
//   /// Because [_layoutText] is called from multiple places with multiple concerns,
//   /// like intrinsics which could have different width parameters than a typical
//   /// layout, this logic is moved out of `performLayout` and into a dedicated
//   /// method which accepts and works with any width constraint.
//   Size _layoutText(double maxWidth) {
//     // Draw nothing (requiring no size) if the string doesn't exist. This is one
//     // of many opinionated choices we could make here if the text is empty.
//     if (_textPainter.text?.toPlainText() == '') {
//       return Size.zero;
//     }
//     assert(
//     maxWidth > 0,
//     'You must allocate SOME space to layout a TimestampedChatMessageRenderObject. Received a '
//         '`maxWidth` value of $maxWidth.',
//     );
//
//     // Layout the raw message, which saves expected high-level sizing values
//     // to the painter itself.
//     _textPainter.layout(maxWidth: maxWidth);
//     final textLines = _textPainter.computeLineMetrics();
//
//     // Now make similar calculations for `sentAt`.
//     _sentAtTextPainter.layout(maxWidth: maxWidth);
//     _sentAtLineWidth = _sentAtTextPainter.computeLineMetrics().first.width;
//
//     // Reset cached values from the last frame if they're assumed to start at 0.
//     // (Because this is used in `max`, if it opens a new frame still holding the
//     // value from a previous frame, we could fail to accurately calculate the
//     // longest line.)
//     _longestLineWidth = 0;
//
//     // Next, we calculate a few metrics for the height and width of the message.
//
//     // First, chat messages don't actually grow to their full available width
//     // if their longest line does not require it. Thus, we need to note the
//     // longest line in the message.
//     for (final line in textLines) {
//       _longestLineWidth = max(_longestLineWidth, line.width);
//     }
//     // If the message is very short, it's possible that the longest line is
//     // is actually the date.
//     _longestLineWidth = max(_longestLineWidth, _sentAtTextPainter.width);
//
//     // Because [_textPainter.width] can be the maximum width we passed to it,
//     // even if the longest line is shorter, we use this logic to determine its
//     // real size, for our purposes.
//     final sizeOfMessage = Size(_longestLineWidth, _textPainter.height);
//
//     // Cache additional variables used both in the rest of this method and in
//     // `paint` later on.
//     _lastMessageLineWidth = textLines.last.width;
//     _lineHeight = textLines.last.height;
//     _numMessageLines = textLines.length;
//
//     // Determine whether the message's last line and the date can share a
//     // horizontal row together.
//     final lastLineWithDate = _lastMessageLineWidth + (_sentAtLineWidth * 1.08);
//     if (textLines.length == 1) {
//       _sentAtFitsOnLastLine = lastLineWithDate < maxWidth;
//     } else {
//       _sentAtFitsOnLastLine =
//           lastLineWithDate < min(_longestLineWidth, maxWidth);
//     }
//
//     late Size computedSize;
//     if (!_sentAtFitsOnLastLine) {
//       computedSize = Size(
//         // If `sentAt` does not fit on the longest line, then we know the
//         // message contains a long line, making this a safe value for `width`.
//         sizeOfMessage.width,
//         // And similarly, if `sentAt` does not fit, we know to add its height
//         // to the overall size of just-the-message.
//         sizeOfMessage.height + _sentAtTextPainter.height,
//       );
//     } else {
//       // Moving forward, of course, we know that `sentAt` DOES fit into the last
//       // line.
//
//       if (textLines.length == 1) {
//         computedSize = Size(
//           // When there is only 1 line, our width calculations are in a special
//           // case of needing as many pixels as our line plus the date, as opposed
//           // to the full size of the longest line.
//           lastLineWithDate,
//           sizeOfMessage.height,
//         );
//       } else {
//         computedSize = Size(
//           // But when there's more than 1 line, our width should be equal to the
//           // longest line.
//           _longestLineWidth,
//           sizeOfMessage.height,
//         );
//       }
//     }
//     return computedSize;
//   }
//
//   @override
//   void paint(PaintingContext context, Offset offset) {
//     // Draw nothing (requiring no paint calls) if the string doesn't exist. This
//     // is one of many opinionated choices we could make here if the text is empty.
//     if (_textPainter.text?.toPlainText() == '') {
//       return;
//     }
//
//     // This line writes the actual message to the screen. Because we use the
//     // same offset we were passed, the text will appear in the upper-left corner
//     // of our available space.
//     _textPainter.paint(context.canvas, offset);
//
//     late Offset sentAtOffset;
//     if (_sentAtFitsOnLastLine) {
//       sentAtOffset = Offset(
//         offset.dx + (size.width - _sentAtLineWidth),
//         offset.dy + (_lineHeight * (_numMessageLines - 1)),
//       );
//     } else {
//       sentAtOffset = Offset(
//         offset.dx + (size.width - _sentAtLineWidth),
//         offset.dy + _lineHeight * _numMessageLines,
//       );
//     }
//
//     // Finally, place the `sentAt` value accordingly.
//     _sentAtTextPainter.paint(context.canvas, sentAtOffset);
//   }
// }