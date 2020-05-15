import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureDetectorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyState();
  }
}

class MyState extends State<GestureDetectorPage> {
  final con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GesturePagePractice"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: con,
          ),
          RaisedButton(
              child: Text("RaisedButton获取文本框内容"),
              onPressed: () => debugPrint("RaisedButton 点击了----$con")),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              child: Text("GestureDetector获取文本框内容"),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
            ),
            onTap: (){
              Navigator.pop(context,"我是GestureDetectorPage页面返回的数据");
              debugPrint("GestureDetector ----onTap");
            },
            onTapDown: (_) => debugPrint("GestureDetector ----onTapDown"),
            onTapUp: (aa) => debugPrint("GestureDetector ----onTapUp--${aa.globalPosition}"),
            onTapCancel: () => debugPrint("GestureDetector ----onTapCancel"),
            onDoubleTap: () => debugPrint("GestureDetector ----onDoubleTap"),
            onLongPress: () => debugPrint("GestureDetector ----onLongPress"),
            onPanDown: (aa) => debugPrint("GestureDetector "
                "----onPanDown--${aa.globalPosition}"),
            onScaleUpdate: (aa) => debugPrint("GestureDetector --onScaleUpdate--${aa.scale}"),
          )
        ],
      ),
    );
  }
}
