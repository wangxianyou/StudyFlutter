import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/FileUtils.dart';

class PageIo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("io——demo"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("写文件"),
            onPressed: () => FileUtils.writeToFile(),
          )
        ],
      ),
    );
  }
}
