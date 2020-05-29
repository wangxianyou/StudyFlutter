import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RefreshListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyState();
  }
}

class MyState extends State<RefreshListPage> {
  var items = new List();
  var _controller = new ScrollController();
  var isRequest = false;
  var isHasMore = true;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreData();
      } else if (_controller.position.pixels ==
          _controller.position.minScrollExtent) {
        initNetData();
      }
    });

    initNetData();
  }

  /**
   * 获取网络数据
   */
  void initNetData() async {
    await http
        .get("http://www.wanandroid.com/project/list/1/json?cid=1")
        .then((http.Response response) {
      var result = json.decode(response.body);
      var list = result["data"]["datas"];
      setState(() {
        pageIndex = 2;
        items = list;
      });
    });
  }

  /**
   * 加载下一页数据
   */
  void _getMoreData() async {
    if (!isRequest) {
      setState(() {
        isRequest = true;
      });
      await http
          .get("http://www.wanandroid.com/project/list/$pageIndex/json?cid=1")
          .then((http.Response response) {
        var result = json.decode(response.body);
        var list = result["data"]["datas"];
        setState(() {
          pageIndex++;
          isHasMore = list.isNotEmpty;
          items.addAll(list);
          isRequest = false;
        });
      });
    }
  }

  Future<List<int>> request(var from, var to) async {
    return Future.delayed(Duration(seconds: 2), () {
      return List.generate(to - from, (i) => from + i);
    });
  }

  Widget _progress() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: isHasMore
            ? Opacity(
                opacity: isRequest ? 1.0 : 0.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              )
            : Text("加载全部"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("refresh-list"),
      ),
      body: ListView.builder(
          itemCount: items.length + 1,
          controller: _controller,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return _progress();
            } else {
              return Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text("条目的：index = ${items[index]["title"]}"),
                ),
              );
            }
          }),
    );
  }
}
