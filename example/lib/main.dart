import 'package:flutter/material.dart';
import 'package:fresh_alert/fresh_alert.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: Center(
            child: Builder(
          builder: (context) => RaisedButton(
            child: Text('Click to test'),
            onPressed: () => showAlert(context),
          ),
        )),
      ),
    );
  }

  void showAlert(BuildContext context) {
    final alert = ToastAlert();
    alert.show(title: null, icon: Icons.check, context: context);
  }
}
