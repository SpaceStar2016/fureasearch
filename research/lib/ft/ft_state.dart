// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
//
// // state 是一个抽象类，他带有一个泛型，T 必须要继承与 StatefulWidget
// abstract class FtState<T extends StatefulWidget> with Diagnosticable {
//   /// The current configuration.
//   ///
//   /// A [FtState] object's configuration is the corresponding [StatefulWidget]
//   /// instance. This property is initialized by the framework before calling
//   /// [initState]. If the parent updates this location in the tree to a new
//   /// widget with the same [runtimeType] and [Widget.key] as the current
//   /// configuration, the framework will update this property to refer to the new
//   /// widget and then call [didUpdateWidget], passing the old configuration as
//   /// an argument.
//   T get widget => _widget!;
//   T? _widget;
//
//   /// The current stage in the lifecycle for this state object.
//   ///
//   /// This field is used by the framework when asserts are enabled to verify
//   /// that [FtState] objects move through their lifecycle in an orderly fashion.
//   _StateLifecycle _debugLifecycleState = _StateLifecycle.created;
//
//   /// Verifies that the [FtState] that was created is one that expects to be
//   /// created for that particular [Widget].
//   bool _debugTypesAreRight(Widget widget) => widget is T;
//
//   /// The location in the tree where this widget builds.
//   ///
//   /// The framework associates [FtState] objects with a [BuildContext] after
//   /// creating them with [StatefulWidget.createState] and before calling
//   /// [initState]. The association is permanent: the [FtState] object will never
//   /// change its [BuildContext]. However, the [BuildContext] itself can be moved
//   /// around the tree.
//   ///
//   /// After calling [dispose], the framework severs the [FtState] object's
//   /// connection with the [BuildContext].
//   BuildContext get context {
//     assert(() {
//       if (_element == null) {
//         throw FlutterError(
//           'This widget has been unmounted, so the State no longer has a context (and should be considered defunct). \n'
//               'Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.',
//         );
//       }
//       return true;
//     }());
//     return _element!;
//   }
//   StatefulElement? _element;
//
//   /// Whether this [FtState] object is currently in a tree.
//   ///
//   /// After creating a [FtState] object and before calling [initState], the
//   /// framework "mounts" the [FtState] object by associating it with a
//   /// [BuildContext]. The [FtState] object remains mounted until the framework
//   /// calls [dispose], after which time the framework will never ask the [FtState]
//   /// object to [build] again.
//   ///
//   /// It is an error to call [setState] unless [mounted] is true.
//   bool get mounted => _element != null;
//
//   /// Called when this object is inserted into the tree.
//   ///
//   /// The framework will call this method exactly once for each [FtState] object
//   /// it creates.
//   ///
//   /// Override this method to perform initialization that depends on the
//   /// location at which this object was inserted into the tree (i.e., [context])
//   /// or on the widget used to configure this object (i.e., [widget]).
//   ///
//   /// {@template flutter.widgets.State.initState}
//   /// If a [FtState]'s [build] method depends on an object that can itself
//   /// change state, for example a [ChangeNotifier] or [Stream], or some
//   /// other object to which one can subscribe to receive notifications, then
//   /// be sure to subscribe and unsubscribe properly in [initState],
//   /// [didUpdateWidget], and [dispose]:
//   ///
//   ///  * In [initState], subscribe to the object.
//   ///  * In [didUpdateWidget] unsubscribe from the old object and subscribe
//   ///    to the new one if the updated widget configuration requires
//   ///    replacing the object.
//   ///  * In [dispose], unsubscribe from the object.
//   ///
//   /// {@endtemplate}
//   ///
//   /// You should not use [BuildContext.dependOnInheritedWidgetOfExactType] from this
//   /// method. However, [didChangeDependencies] will be called immediately
//   /// following this method, and [BuildContext.dependOnInheritedWidgetOfExactType] can
//   /// be used there.
//   ///
//   /// Implementations of this method should start with a call to the inherited
//   /// method, as in `super.initState()`.
//   @protected
//   @mustCallSuper
//   void initState() {
//     assert(_debugLifecycleState == _StateLifecycle.created);
//     if (kFlutterMemoryAllocationsEnabled) {
//       FlutterMemoryAllocations.instance.dispatchObjectCreated(
//         library: _flutterWidgetsLibrary,
//         className: '$FtState',
//         object: this,
//       );
//     }
//   }
//
//   /// Called whenever the widget configuration changes.
//   ///
//   /// If the parent widget rebuilds and requests that this location in the tree
//   /// update to display a new widget with the same [runtimeType] and
//   /// [Widget.key], the framework will update the [widget] property of this
//   /// [FtState] object to refer to the new widget and then call this method
//   /// with the previous widget as an argument.
//   ///
//   /// Override this method to respond when the [widget] changes (e.g., to start
//   /// implicit animations).
//   ///
//   /// The framework always calls [build] after calling [didUpdateWidget], which
//   /// means any calls to [setState] in [didUpdateWidget] are redundant.
//   ///
//   /// {@macro flutter.widgets.State.initState}
//   ///
//   /// Implementations of this method should start with a call to the inherited
//   /// method, as in `super.didUpdateWidget(oldWidget)`.
//   ///
//   /// _See the discussion at [Element.rebuild] for more information on when this
//   /// method is called._
//   @mustCallSuper
//   @protected
//   void didUpdateWidget(covariant T oldWidget) { }
//
//   /// {@macro flutter.widgets.Element.reassemble}
//   ///
//   /// In addition to this method being invoked, it is guaranteed that the
//   /// [build] method will be invoked when a reassemble is signaled. Most
//   /// widgets therefore do not need to do anything in the [reassemble] method.
//   ///
//   /// See also:
//   ///
//   ///  * [Element.reassemble]
//   ///  * [BindingBase.reassembleApplication]
//   ///  * [Image], which uses this to reload images.
//   @protected
//   @mustCallSuper
//   void reassemble() { }
//
//   /// Notify the framework that the internal state of this object has changed.
//   ///
//   /// Whenever you change the internal state of a [FtState] object, make the
//   /// change in a function that you pass to [setState]:
//   ///
//   /// ```dart
//   /// setState(() { _myState = newValue; });
//   /// ```
//   ///
//   /// The provided callback is immediately called synchronously. It must not
//   /// return a future (the callback cannot be `async`), since then it would be
//   /// unclear when the state was actually being set.
//   ///
//   /// Calling [setState] notifies the framework that the internal state of this
//   /// object has changed in a way that might impact the user interface in this
//   /// subtree, which causes the framework to schedule a [build] for this [FtState]
//   /// object.
//   ///
//   /// If you just change the state directly without calling [setState], the
//   /// framework might not schedule a [build] and the user interface for this
//   /// subtree might not be updated to reflect the new state.
//   ///
//   /// Generally it is recommended that the [setState] method only be used to
//   /// wrap the actual changes to the state, not any computation that might be
//   /// associated with the change. For example, here a value used by the [build]
//   /// function is incremented, and then the change is written to disk, but only
//   /// the increment is wrapped in the [setState]:
//   ///
//   /// ```dart
//   /// Future<void> _incrementCounter() async {
//   ///   setState(() {
//   ///     _counter++;
//   ///   });
//   ///   Directory directory = await getApplicationDocumentsDirectory(); // from path_provider package
//   ///   final String dirName = directory.path;
//   ///   await File('$dirName/counter.txt').writeAsString('$_counter');
//   /// }
//   /// ```
//   ///
//   /// Sometimes, the changed state is in some other object not owned by the
//   /// widget [FtState], but the widget nonetheless needs to be updated to react to
//   /// the new state. This is especially common with [Listenable]s, such as
//   /// [AnimationController]s.
//   ///
//   /// In such cases, it is good practice to leave a comment in the callback
//   /// passed to [setState] that explains what state changed:
//   ///
//   /// ```dart
//   /// void _update() {
//   ///   setState(() { /* The animation changed. */ });
//   /// }
//   /// //...
//   /// animation.addListener(_update);
//   /// ```
//   ///
//   /// It is an error to call this method after the framework calls [dispose].
//   /// You can determine whether it is legal to call this method by checking
//   /// whether the [mounted] property is true. That said, it is better practice
//   /// to cancel whatever work might trigger the [setState] rather than merely
//   /// checking for [mounted] before calling [setState], as otherwise CPU cycles
//   /// will be wasted.
//   ///
//   /// ## Design discussion
//   ///
//   /// The original version of this API was a method called `markNeedsBuild`, for
//   /// consistency with [RenderObject.markNeedsLayout],
//   /// [RenderObject.markNeedsPaint], _et al_.
//   ///
//   /// However, early user testing of the Flutter framework revealed that people
//   /// would call `markNeedsBuild()` much more often than necessary. Essentially,
//   /// people used it like a good luck charm, any time they weren't sure if they
//   /// needed to call it, they would call it, just in case.
//   ///
//   /// Naturally, this led to performance issues in applications.
//   ///
//   /// When the API was changed to take a callback instead, this practice was
//   /// greatly reduced. One hypothesis is that prompting developers to actually
//   /// update their state in a callback caused developers to think more carefully
//   /// about what exactly was being updated, and thus improved their understanding
//   /// of the appropriate times to call the method.
//   ///
//   /// In practice, the [setState] method's implementation is trivial: it calls
//   /// the provided callback synchronously, then calls [Element.markNeedsBuild].
//   ///
//   /// ## Performance considerations
//   ///
//   /// There is minimal _direct_ overhead to calling this function, and as it is
//   /// expected to be called at most once per frame, the overhead is irrelevant
//   /// anyway. Nonetheless, it is best to avoid calling this function redundantly
//   /// (e.g. in a tight loop), as it does involve creating a closure and calling
//   /// it. The method is idempotent, there is no benefit to calling it more than
//   /// once per [FtState] per frame.
//   ///
//   /// The _indirect_ cost of causing this function, however, is high: it causes
//   /// the widget to rebuild, possibly triggering rebuilds for the entire subtree
//   /// rooted at this widget, and further triggering a relayout and repaint of
//   /// the entire corresponding [RenderObject] subtree.
//   ///
//   /// For this reason, this method should only be called when the [build] method
//   /// will, as a result of whatever state change was detected, change its result
//   /// meaningfully.
//   ///
//   /// See also:
//   ///
//   ///  * [StatefulWidget], the API documentation for which has a section on
//   ///    performance considerations that are relevant here.
//   @protected
//   void setState(VoidCallback fn) {
//     assert(() {
//       if (_debugLifecycleState == _StateLifecycle.defunct) {
//         throw FlutterError.fromParts(<DiagnosticsNode>[
//           ErrorSummary('setState() called after dispose(): $this'),
//           ErrorDescription(
//             'This error happens if you call setState() on a State object for a widget that '
//                 'no longer appears in the widget tree (e.g., whose parent widget no longer '
//                 'includes the widget in its build). This error can occur when code calls '
//                 'setState() from a timer or an animation callback.',
//           ),
//           ErrorHint(
//             'The preferred solution is '
//                 'to cancel the timer or stop listening to the animation in the dispose() '
//                 'callback. Another solution is to check the "mounted" property of this '
//                 'object before calling setState() to ensure the object is still in the '
//                 'tree.',
//           ),
//           ErrorHint(
//             'This error might indicate a memory leak if setState() is being called '
//                 'because another object is retaining a reference to this State object '
//                 'after it has been removed from the tree. To avoid memory leaks, '
//                 'consider breaking the reference to this object during dispose().',
//           ),
//         ]);
//       }
//       if (_debugLifecycleState == _StateLifecycle.created && !mounted) {
//         throw FlutterError.fromParts(<DiagnosticsNode>[
//           ErrorSummary('setState() called in constructor: $this'),
//           ErrorHint(
//             'This happens when you call setState() on a State object for a widget that '
//                 "hasn't been inserted into the widget tree yet. It is not necessary to call "
//                 'setState() in the constructor, since the state is already assumed to be dirty '
//                 'when it is initially created.',
//           ),
//         ]);
//       }
//       return true;
//     }());
//     final Object? result = fn() as dynamic;
//     assert(() {
//       if (result is Future) {
//         throw FlutterError.fromParts(<DiagnosticsNode>[
//           ErrorSummary('setState() callback argument returned a Future.'),
//           ErrorDescription(
//             'The setState() method on $this was called with a closure or method that '
//                 'returned a Future. Maybe it is marked as "async".',
//           ),
//           ErrorHint(
//             'Instead of performing asynchronous work inside a call to setState(), first '
//                 'execute the work (without updating the widget state), and then synchronously '
//                 'update the state inside a call to setState().',
//           ),
//         ]);
//       }
//       // We ignore other types of return values so that you can do things like:
//       //   setState(() => x = 3);
//       return true;
//     }());
//     _element!.markNeedsBuild();
//   }
//
//   /// Called when this object is removed from the tree.
//   ///
//   /// The framework calls this method whenever it removes this [FtState] object
//   /// from the tree. In some cases, the framework will reinsert the [FtState]
//   /// object into another part of the tree (e.g., if the subtree containing this
//   /// [FtState] object is grafted from one location in the tree to another due to
//   /// the use of a [GlobalKey]). If that happens, the framework will call
//   /// [activate] to give the [FtState] object a chance to reacquire any resources
//   /// that it released in [deactivate]. It will then also call [build] to give
//   /// the [FtState] object a chance to adapt to its new location in the tree. If
//   /// the framework does reinsert this subtree, it will do so before the end of
//   /// the animation frame in which the subtree was removed from the tree. For
//   /// this reason, [FtState] objects can defer releasing most resources until the
//   /// framework calls their [dispose] method.
//   ///
//   /// Subclasses should override this method to clean up any links between
//   /// this object and other elements in the tree (e.g. if you have provided an
//   /// ancestor with a pointer to a descendant's [RenderObject]).
//   ///
//   /// Implementations of this method should end with a call to the inherited
//   /// method, as in `super.deactivate()`.
//   ///
//   /// See also:
//   ///
//   ///  * [dispose], which is called after [deactivate] if the widget is removed
//   ///    from the tree permanently.
//   @protected
//   @mustCallSuper
//   void deactivate() { }
//
//   /// Called when this object is reinserted into the tree after having been
//   /// removed via [deactivate].
//   ///
//   /// In most cases, after a [FtState] object has been deactivated, it is _not_
//   /// reinserted into the tree, and its [dispose] method will be called to
//   /// signal that it is ready to be garbage collected.
//   ///
//   /// In some cases, however, after a [FtState] object has been deactivated, the
//   /// framework will reinsert it into another part of the tree (e.g., if the
//   /// subtree containing this [FtState] object is grafted from one location in
//   /// the tree to another due to the use of a [GlobalKey]). If that happens,
//   /// the framework will call [activate] to give the [FtState] object a chance to
//   /// reacquire any resources that it released in [deactivate]. It will then
//   /// also call [build] to give the object a chance to adapt to its new
//   /// location in the tree. If the framework does reinsert this subtree, it
//   /// will do so before the end of the animation frame in which the subtree was
//   /// removed from the tree. For this reason, [FtState] objects can defer
//   /// releasing most resources until the framework calls their [dispose] method.
//   ///
//   /// The framework does not call this method the first time a [FtState] object
//   /// is inserted into the tree. Instead, the framework calls [initState] in
//   /// that situation.
//   ///
//   /// Implementations of this method should start with a call to the inherited
//   /// method, as in `super.activate()`.
//   ///
//   /// See also:
//   ///
//   ///  * [Element.activate], the corresponding method when an element
//   ///    transitions from the "inactive" to the "active" lifecycle state.
//   @protected
//   @mustCallSuper
//   void activate() { }
//
//   /// Called when this object is removed from the tree permanently.
//   ///
//   /// The framework calls this method when this [FtState] object will never
//   /// build again. After the framework calls [dispose], the [FtState] object is
//   /// considered unmounted and the [mounted] property is false. It is an error
//   /// to call [setState] at this point. This stage of the lifecycle is terminal:
//   /// there is no way to remount a [FtState] object that has been disposed.
//   ///
//   /// Subclasses should override this method to release any resources retained
//   /// by this object (e.g., stop any active animations).
//   ///
//   /// {@macro flutter.widgets.State.initState}
//   ///
//   /// Implementations of this method should end with a call to the inherited
//   /// method, as in `super.dispose()`.
//   ///
//   /// ## Caveats
//   ///
//   /// This method is _not_ invoked at times where a developer might otherwise
//   /// expect it, such as application shutdown or dismissal via platform
//   /// native methods.
//   ///
//   /// ### Application shutdown
//   ///
//   /// There is no way to predict when application shutdown will happen. For
//   /// example, a user's battery could catch fire, or the user could drop the
//   /// device into a swimming pool, or the operating system could unilaterally
//   /// terminate the application process due to memory pressure.
//   ///
//   /// Applications are responsible for ensuring that they are well-behaved
//   /// even in the face of a rapid unscheduled termination.
//   ///
//   /// To artificially cause the entire widget tree to be disposed, consider
//   /// calling [runApp] with a widget such as [SizedBox.shrink].
//   ///
//   /// To listen for platform shutdown messages (and other lifecycle changes),
//   /// consider the [AppLifecycleListener] API.
//   ///
//   /// {@macro flutter.widgets.runApp.dismissal}
//   ///
//   /// See the method used to bootstrap the app (e.g. [runApp] or [runWidget])
//   /// for suggestions on how to release resources more eagerly.
//   ///
//   /// See also:
//   ///
//   ///  * [deactivate], which is called prior to [dispose].
//   @protected
//   @mustCallSuper
//   void dispose() {
//     assert(_debugLifecycleState == _StateLifecycle.ready);
//     assert(() {
//       _debugLifecycleState = _StateLifecycle.defunct;
//       return true;
//     }());
//     if (kFlutterMemoryAllocationsEnabled) {
//       FlutterMemoryAllocations.instance.dispatchObjectDisposed(object: this);
//     }
//   }
//
//   /// Describes the part of the user interface represented by this widget.
//   ///
//   /// The framework calls this method in a number of different situations. For
//   /// example:
//   ///
//   ///  * After calling [initState].
//   ///  * After calling [didUpdateWidget].
//   ///  * After receiving a call to [setState].
//   ///  * After a dependency of this [FtState] object changes (e.g., an
//   ///    [InheritedWidget] referenced by the previous [build] changes).
//   ///  * After calling [deactivate] and then reinserting the [FtState] object into
//   ///    the tree at another location.
//   ///
//   /// This method can potentially be called in every frame and should not have
//   /// any side effects beyond building a widget.
//   ///
//   /// The framework replaces the subtree below this widget with the widget
//   /// returned by this method, either by updating the existing subtree or by
//   /// removing the subtree and inflating a new subtree, depending on whether the
//   /// widget returned by this method can update the root of the existing
//   /// subtree, as determined by calling [Widget.canUpdate].
//   ///
//   /// Typically implementations return a newly created constellation of widgets
//   /// that are configured with information from this widget's constructor, the
//   /// given [BuildContext], and the internal state of this [FtState] object.
//   ///
//   /// The given [BuildContext] contains information about the location in the
//   /// tree at which this widget is being built. For example, the context
//   /// provides the set of inherited widgets for this location in the tree. The
//   /// [BuildContext] argument is always the same as the [context] property of
//   /// this [FtState] object and will remain the same for the lifetime of this
//   /// object. The [BuildContext] argument is provided redundantly here so that
//   /// this method matches the signature for a [WidgetBuilder].
//   ///
//   /// ## Design discussion
//   ///
//   /// ### Why is the [build] method on [FtState], and not [StatefulWidget]?
//   ///
//   /// Putting a `Widget build(BuildContext context)` method on [FtState] rather
//   /// than putting a `Widget build(BuildContext context, State state)` method
//   /// on [StatefulWidget] gives developers more flexibility when subclassing
//   /// [StatefulWidget].
//   ///
//   /// For example, [AnimatedWidget] is a subclass of [StatefulWidget] that
//   /// introduces an abstract `Widget build(BuildContext context)` method for its
//   /// subclasses to implement. If [StatefulWidget] already had a [build] method
//   /// that took a [FtState] argument, [AnimatedWidget] would be forced to provide
//   /// its [FtState] object to subclasses even though its [FtState] object is an
//   /// internal implementation detail of [AnimatedWidget].
//   ///
//   /// Conceptually, [StatelessWidget] could also be implemented as a subclass of
//   /// [StatefulWidget] in a similar manner. If the [build] method were on
//   /// [StatefulWidget] rather than [FtState], that would not be possible anymore.
//   ///
//   /// Putting the [build] function on [FtState] rather than [StatefulWidget] also
//   /// helps avoid a category of bugs related to closures implicitly capturing
//   /// `this`. If you defined a closure in a [build] function on a
//   /// [StatefulWidget], that closure would implicitly capture `this`, which is
//   /// the current widget instance, and would have the (immutable) fields of that
//   /// instance in scope:
//   ///
//   /// ```dart
//   /// // (this is not valid Flutter code)
//   /// class MyButton extends StatefulWidgetX {
//   ///   MyButton({super.key, required this.color});
//   ///
//   ///   final Color color;
//   ///
//   ///   @override
//   ///   Widget build(BuildContext context, State state) {
//   ///     return SpecialWidget(
//   ///       handler: () { print('color: $color'); },
//   ///     );
//   ///   }
//   /// }
//   /// ```
//   ///
//   /// For example, suppose the parent builds `MyButton` with `color` being blue,
//   /// the `$color` in the print function refers to blue, as expected. Now,
//   /// suppose the parent rebuilds `MyButton` with green. The closure created by
//   /// the first build still implicitly refers to the original widget and the
//   /// `$color` still prints blue even through the widget has been updated to
//   /// green; should that closure outlive its widget, it would print outdated
//   /// information.
//   ///
//   /// In contrast, with the [build] function on the [FtState] object, closures
//   /// created during [build] implicitly capture the [FtState] instance instead of
//   /// the widget instance:
//   ///
//   /// ```dart
//   /// class MyButton extends StatefulWidget {
//   ///   const MyButton({super.key, this.color = Colors.teal});
//   ///
//   ///   final Color color;
//   ///   // ...
//   /// }
//   ///
//   /// class MyButtonState extends State<MyButton> {
//   ///   // ...
//   ///   @override
//   ///   Widget build(BuildContext context) {
//   ///     return SpecialWidget(
//   ///       handler: () { print('color: ${widget.color}'); },
//   ///     );
//   ///   }
//   /// }
//   /// ```
//   ///
//   /// Now when the parent rebuilds `MyButton` with green, the closure created by
//   /// the first build still refers to [FtState] object, which is preserved across
//   /// rebuilds, but the framework has updated that [FtState] object's [widget]
//   /// property to refer to the new `MyButton` instance and `${widget.color}`
//   /// prints green, as expected.
//   ///
//   /// See also:
//   ///
//   ///  * [StatefulWidget], which contains the discussion on performance considerations.
//   @protected
//   Widget build(BuildContext context);
//
//   /// Called when a dependency of this [FtState] object changes.
//   ///
//   /// For example, if the previous call to [build] referenced an
//   /// [InheritedWidget] that later changed, the framework would call this
//   /// method to notify this object about the change.
//   ///
//   /// This method is also called immediately after [initState]. It is safe to
//   /// call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
//   ///
//   /// Subclasses rarely override this method because the framework always
//   /// calls [build] after a dependency changes. Some subclasses do override
//   /// this method because they need to do some expensive work (e.g., network
//   /// fetches) when their dependencies change, and that work would be too
//   /// expensive to do for every build.
//   @protected
//   @mustCallSuper
//   void didChangeDependencies() { }
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     assert(() {
//       properties.add(EnumProperty<_StateLifecycle>('lifecycle state', _debugLifecycleState, defaultValue: _StateLifecycle.ready));
//       return true;
//     }());
//     properties.add(ObjectFlagProperty<T>('_widget', _widget, ifNull: 'no widget'));
//     properties.add(ObjectFlagProperty<StatefulElement>('_element', _element, ifNull: 'not mounted'));
//   }
// }