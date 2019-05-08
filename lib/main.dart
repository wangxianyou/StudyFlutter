import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "first flutter app",
      home: Scaffold(
        appBar: AppBar(
          title: Text("APP BAR"),
        ),
        body: Center(
          child: RollingButton()
        ),
      ),
    );
  }
}


class RollingButton extends StatefulWidget {

  @override
  State createState() {
    return _RollingButton();
  }
}

class _RollingButton extends State<RollingButton> {
  final _random = Random();

  List<int> _list(){
    final i = _random.nextInt(6)+1;
    final j = _random.nextInt(6)+1;
    return [i,j];

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: _onPressed,
      child: Text('roll'),
    );
  }
  _onPressed() {
    debugPrint('_onPressed');
    var result = _list();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('roll result: ${result[0]} , ${result[1]}'),
          );
        }
    );
  }

}