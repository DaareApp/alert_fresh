import 'package:flutter/material.dart';

class ToastAlert {
  bool _isVisible = false;

  void show({
    @required BuildContext context,
    @required IconData icon,
    String title,
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
          child: Container(
              alignment: Alignment.center,
              child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Card(
                    elevation: title != null && title != '' ? 20 : 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: title != null && title != ''
                        ? Theme.of(context).accentColor.withOpacity(0.85)
                        : Colors.transparent,
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(6),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: title != null && title != ''
                                  ? Icon(
                                      icon,
                                      color: title != null
                                          ? null
                                          : Theme.of(context).accentColor,
                                      size: 60,
                                    )
                                  : Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 0.4,
                                          top: 0.4,
                                          child: Icon(
                                            icon,
                                            color: Colors.black54,
                                            size: 80,
                                          ),
                                        ),
                                        Icon(
                                          icon,
                                          color: Theme.of(context).accentColor,
                                          size: 80,
                                        ),
                                      ],
                                    ),
                            ),
                            title == null || title == ''
                                ? Container()
                                : Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        title ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  )))),
    );
    overlayState.insert(overlayEntry);

    await new Future.delayed(duration);

    overlayEntry.remove();

    _isVisible = false;
  }
}

class ToastView extends StatefulWidget {
  final Widget child;

  ToastView({this.child});

  @override
  _ToastViewState createState() => _ToastViewState();
}

class _ToastViewState extends State<ToastView> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this, value: 0.2);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
        child: new Material(
            color: Colors.transparent,
            child: ScaleTransition(scale: _animation, child: widget.child)));
  }
}
