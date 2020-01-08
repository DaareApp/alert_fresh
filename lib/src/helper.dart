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
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Theme.of(context).primaryColor.withOpacity(0.85),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                                child: Icon(
                              icon,
                              size: 60,
                            )),
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

class ToastView extends StatelessWidget {
  final Widget child;

  ToastView({this.child});

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
        child: new Material(color: Colors.transparent, child: child));
  }
}
