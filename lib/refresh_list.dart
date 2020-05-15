import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyState();
  }
}

class MyState extends State<RefreshListPage> {
  var items = List.generate(15, (i) => i);
  var _controller = new ScrollController();
  var isRequest = false;
  var isHasMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreData(items.length, items.length >=30 ? items.length:items
            .length + 15);
      }
    });
  }

  /**
   * 加载下一页数据
   */
  void _getMoreData(var from, var to) async {
    if (!isRequest) {
      setState(() {
        isRequest = true;
      });
      List<int> list = await request(from, to);
      setState(() {
        isHasMore = list.isNotEmpty;
        items.addAll(list);
        isRequest = false;
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
        child: isHasMore?Opacity(
          opacity: isRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
        ):Text("加载全部"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              return ListTile(
                title: Text("条目的：index = $index"),
              );
            }
          }),
    );
  }
}
