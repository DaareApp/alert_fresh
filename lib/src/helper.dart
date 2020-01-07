import 'package:flutter/material.dart';

class ToastAlert {
  bool _isVisible = false;

  void show({
    @required BuildContext context,
    @required WidgetBuilder externalBuilder,
    Duration duration = const Duration(seconds: 2),
    Offset position = Offset.zero,
  }) async {
    if (_isVisible) {
      return;
    }

    _isVisible = true;

    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastView(
        child: externalBuilder(context),
      ),
    );
    overlayState.insert(overlayEntry);

    await new Future.delayed(duration);

    overlayEntry.remove();

    _isVisible = false;
  }
}

class ToastView extends StatelessWidget {
  final Widget child;

  ToastView({this.child});

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
        child: new Material(color: Colors.transparent, child: child));
  }
}
