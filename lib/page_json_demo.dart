import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/entity_point.dart';
import 'package:http/http.dart' as http;

class PageJsonDemo extends StatelessWidget {
  void toObject() {
    String s = "{\"x\":1,\"y\":2,\"desc\":\"描述\"}";
    String pointsJson = "[{\"x\":1,\"y\":2,\"desc\":\"描述\"},{\"x\":1,\"y\":2,"
        "\"desc\":\"描述\"}]";
    var decode = json.decode(s);
    var myPoint = MyPoint.fromJson(decode);
    debugPrint("toObject------------${myPoint.toString()}");

    var decode2 = json.decode(pointsJson);
    debugPrint("toObject-------decode2--前---${decode2.toString()}");
    var list = <MyPoint>[];
    for (var map in decode2) {
      list.add(MyPoint.fromJson(map));
    }
    debugPrint("toObject-------decode2---后--${list.toString()}");
  }

  void toJson() {
    var point = MyPoint(1, 2, "描述");
    var parsePoint = json.encode(point);
    debugPrint("toJson------------$parsePoint");

    var points = [point, point];
    var parsePoints = json.encode(points);
    debugPrint("toJson------------$parsePoints");
  }


  Future<String> getMsg() async {
    try {
      var future = await http.get("http://www.baidu.com");
      debugPrint("请求的结果是----------------------------：${future}");
      if (future.statusCode == 200) {
        debugPrint("请求的结果是----------------------------：${future.body}");
        return future.body;
      }
    } catch (e, s) {
      print(s);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("json练习"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("将json转Entity"),
              onPressed: toObject,
            ),
            RaisedButton(
              child: Text("将Entity转json"),
              onPressed: toJson,
            ),
            Text("${getMsg()}")
          ],
        ),
      ),
    );
  }
}
