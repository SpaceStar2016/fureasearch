// 运行runApp 基本之后，会在你传递给runApp 方法的widget添加两层RootWidget 和 View，
// RootWidget 和 View 都是继承自StatelessWidget,结构如下：
RootWidget{
    child:View{
        child:(your widget)
        }
    }

/// * [The Event Loop and Dart](https://dart.dev/articles/event-loop/):
/// Learn how Dart handles the event queue and microtask queue, so you can write
/// better asynchronous code with fewer surprises.