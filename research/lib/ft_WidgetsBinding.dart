
/*
* WidgetsBinding 是 Flutter 框架中的一个类，主要用于连接 Flutter 框架与底层操作系统的输入事件和渲染周期。它的主要用途包括：
事件处理：管理输入事件（如触摸、键盘事件）并将它们传递给合适的 widget。
帧调度：控制应用程序的帧更新，确保 UI 在每一帧中得到渲染。
生命周期管理：提供对应用生命周期的回调，比如应用被挂起或恢复时的处理。
通常，开发者会使用 WidgetsBinding.instance 来访问实例，以执行一些初始化或状态更新操作。例如，可以在 WidgetsBinding.instance.addPostFrameCallback 中添加回调，以在每次帧绘制后执行特定操作。
*
* */
class FtWidgetsBinding {

}