# research

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




// runApp -> _runWidget -> scheduleAttachRootWidget(WidgetsBinding) -> scheduleWarmUpFrame(WidgetsBinding)


调用WidgetsBinding 的 wrapWithDefaultView方法 
生一个View对象，这个对象持有一个FlutterView对象，
PipelineOwner 对象_ReusableRenderView(RenderView) 对象和 Your_Widget;