import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeList extends StatefulWidget {
  Iterable<Widget> titles;

  LikeList(Iterable<Widget> titles) {
    this.titles = titles;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LikeState(titles);
  }
}

class LikeState extends State<LikeList> {
  Iterable<Widget> titles;

  LikeState(Iterable<Widget> titles) {
    this.titles = titles;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我喜欢的列表"),
      ),
      body: ListView(
        children: ListTile.divideTiles(tiles: titles,color: Colors.blue).toList(),
      ),
    );
  }
}
