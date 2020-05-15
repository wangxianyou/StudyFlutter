import 'dart:math';

import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/gesture_detector_page.dart';
import 'package:flutter_demo/like_list.dart';
import 'package:flutter_demo/page_anim.dart';
import 'package:flutter_demo/refresh_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "first flutter app",
        theme: ThemeData(
            primaryColor: Colors.white,
            dividerColor: Colors.amber,
            backgroundColor: Colors.red),
        home: MyListview());
  }
}

class MyListview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyListviewState();
  }
}

class BuildListview extends StatelessWidget {
  final List<Building> builds;

  BuildListview(this.builds);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: builds.length,
      itemBuilder: (context, index) {
        return BuildItem(index, builds[index], (p) => debugPrint("当前点的是：$p"));
      },
    );
  }
}

typedef ClickListener = void Function(int p);

class BuildItem extends StatelessWidget {
  final int positon;
  final Building item;
  final ClickListener listener;

  BuildItem(this.positon, this.item, this.listener);

  @override
  Widget build(BuildContext context) {
    var icon = Icon(
      BuildingType.restaurant == item.type ? Icons.restaurant : Icons.theaters,
      color: Colors.blue,
    );
    // TODO: implement build
    return InkWell(
      onTap: () => listener(positon),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: icon,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(item.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyListviewState extends State<MyListview> {
  final _favoriteList = Set<prefix0.WordPair>();
  final _suggestionList = <WordPair>[];
  var isV = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.grid_on), onPressed: _myGrideview),
          IconButton(icon: Icon(Icons.list), onPressed: _myList),
          IconButton(icon: Icon(Icons.view_list), onPressed: _myListRefresh),
          IconButton(
              icon: Icon(Icons.collections_bookmark),
              onPressed: () {
                var future = Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => LikeList(_favoriteList.map((item) {
                              return ListTile(
                                title: Text(item.asPascalCase),
                              );
                            }))));
              })

        ],
      ),
      body: _suggestions(context),
    );
  }

  /**
   * 加载更多的list
   */
  void _myListRefresh() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RefreshListPage();
    }));
  }

  /**
   * gridview列表
   */
  void _myGrideview() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      List<Container> _buildGridTileList(int count) {
        return new List<Container>.generate(
            count,
            (int index) => new Container(
                decoration: BoxDecoration(color: Colors.blue),
                child: Card(
                  elevation: 10,
                  child: Text("item$index"),
                )));
      }

      Widget buildGrid() {
        return new GridView.extent(
          maxCrossAxisExtent: 150.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _buildGridTileList(30),
        );
      }

      var countGrid = GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: const EdgeInsets.all(8.0),
        childAspectRatio: 1.8,
        children: _buildGridTileList(30),
      );

      return Scaffold(
          appBar: AppBar(
            title: Text("GridView"),
          ),
          body: countGrid);
    }));
  }

  void _myList() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final builds = [
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(BuildingType.restaurant, 'CineArts at the Empire',
            '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(BuildingType.restaurant, 'CineArts at the Empire',
            '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(BuildingType.restaurant, 'CineArts at the Empire',
            '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(BuildingType.restaurant, 'CineArts at the Empire',
            '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(BuildingType.restaurant, 'CineArts at the Empire',
            '85 W Portal Ave'),
        Building(
            BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
        Building(BuildingType.restaurant, 'CineArts at the Empire',
            '85 W Portal Ave'),
      ];
      return Scaffold(
        appBar: AppBar(
          title: Text("list页面"),
        ),
        body: BuildListview(builds),
      );
    }));
  }

  Widget _suggestions(BuildContext context) {
    var con = TextEditingController();
    return Column(
      children: <Widget>[
        Stack(
//          alignment: Alignment(-0.6, -0.6),
          alignment: Alignment(0.5, 0),
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 100,
            ),
            isV
                ? Positioned(
                    left: 20,
                    right: 30,
                    top: 80,
                    child: Text("Positioned"),
                  )
                : Text(""),
            Text("Stack111"),
            Text("Stack222"),
          ],
        ),
        Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber,
                    offset: Offset(10.0, 10.0),
                    blurRadius: 2,
                  ),
                  BoxShadow(
                      color: Colors.blueAccent,
                      offset: Offset(5.0, 5.0),
                      spreadRadius: 2)
                ]),
            child: Text("我是text文本")),
        FlatButton(
          onPressed: () {
            setState(() {
              isV = !isV;
            });
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AnimationPage()));
          },
          child: Text("跳转到anim_page"),
        ),
        RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text("确定跳转到GestureDetectorPage页面？"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var future = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => GestureDetectorPage()));
                            debugPrint("返回页面的数据是--------$future");
                          },
                          child: Text("ok"))
                    ],
                  );
                });
          },
          child: Text("跳转到GestureDetectorPage页面"),
        ),
        Expanded(
            child: Container(child: ListView.builder(itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestionList.length) {
            _suggestionList.addAll(prefix0.generateWordPairs().take(10));
          }
          return _ItemList(_suggestionList[index]);
        }))),
      ],
    );
  }

  Widget _ItemList(prefix0.WordPair p) {
    final isCollect = _favoriteList.contains(p);
    return ListTile(
      title: Text(p.asPascalCase),
      trailing: Icon(Icons.favorite, color: isCollect ? Colors.red : null),
      onTap: () {
        setState(() {
          if (isCollect) {
            _favoriteList.remove(p);
          } else {
            _favoriteList.add(p);
          }
        });
      },
    );
  }
}

class MyRaiseButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RaiseButton();
  }
}

class _RaiseButton extends State<MyRaiseButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: _onPress,
      child: Text("click"),
    );
  }

  _onPress() {
    final rd = WordPair.random();
    debugPrint("打印信息");
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("弹窗的title${rd.asPascalCase}"),
          );
        });
  }
}

class TextStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextStatefulState();
  }
}

class TextStatefulState extends State<TextStateful> {
  var mController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: mController,
            ),
          ),
          RaisedButton(
            child: Text("click"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text('${mController.text}'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('ok'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 手动调用 controller 的 dispose 方法以释放资源
    mController.dispose();
  }
}

class TestStateless extends StatelessWidget {
  var style = TextStyle(fontSize: 16, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var img = Image.network(
      'http://pic1.sc.chinaz'
      '.com/files/pic/pic9/201905/zzpic17988.jpg',
      width: 40.0,
      height: 30.0,
    );

    var text = Text('sfshhsgj', style: style);

    var flatbtn = FlatButton(
      onPressed: () => print('FlatButton'),
      child: Text(
        'flatbtn',
        style: style,
      ),
    );

    var raiseBtn = RaisedButton(
      onPressed: () => print('RaisedButton'),
      child: Text(
        'RaisedButton',
        style: style,
      ),
    );

    var con = Container(
      child: Center(
        child: Text('Container'),
      ),
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.all(19),
      width: 400,
      height: 500,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
    );

    var pad = Padding(
      child: Text('Padding'),
      padding: EdgeInsets.all(18),
    );

    var cluom = Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text('bbb'),
          ),
          flex: 1,
        ),
        Expanded(
          child: Center(
            child: Text('ddd'),
          ),
          flex: 1,
        ),
        Expanded(
          child: Center(
            child: Text('bggggbb'),
          ),
          flex: 1,
        ),
      ],
    );

    var sta = Stack(
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          color: Colors.amberAccent,
        ),
        Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
        Text('aaa')
      ],
      alignment: const Alignment(0, 1),
    );

    _listDemo() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text('列表')),
          body: BuildListView(),
        );
      }));
    }

    var textSection = Container(
      padding: EdgeInsets.all(32),
      child: Text('afdfdsgsg'),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('test 1'),
        ),
        body: Column(
          children: <Widget>[
            Image.network(
              "http://pic1.sc.chinaz"
              ".com/files/pic/pic9/201905/zzpic17988.jpg",
              width: 600,
              height: 200,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'asdssdasdasd',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('asfdfdsgfdhg')
                      ],
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Text('41')
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _listDemo(),
                  child: Column(
                    children: <Widget>[Icon(Icons.list), Text('listviewDemo')],
                  ),
                ),
                Column(
                  children: <Widget>[Icon(Icons.phone), Text('手机')],
                ),
                Column(
                  children: <Widget>[Icon(Icons.share), Text('分享')],
                )
              ],
            ),
            textSection
          ],
        ));
  }
}

enum BuildingType { theater, restaurant }

typedef OnClickItemListener = void Function(int position);

class Building {
  final BuildingType type;
  final String title;
  final String address;

  Building(this.type, this.title, this.address);
}

class ItemView extends StatelessWidget {
  final int position;
  final Building building;
  final OnClickItemListener listener;

  ItemView(this.position, this.building, this.listener);

  @override
  Widget build(BuildContext context) {
    var icon = Icon(building.type == BuildingType.restaurant
        ? Icons.restaurant
        : Icons.theaters);
    return InkWell(
      onTap: () => listener(position),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            child: icon,
          ),
          Expanded(
            child: Column(
              children: <Widget>[Text(building.title), Text(building.address)],
            ),
          )
        ],
      ),
    );
  }
}

class BuildListView extends StatelessWidget {
  final buildings = [
    Building(BuildingType.restaurant, '北京', '天安门'),
    Building(BuildingType.restaurant, '大连', '天安门'),
    Building(BuildingType.theater, '深圳', '天安门'),
    Building(BuildingType.restaurant, '广东', '天安门'),
    Building(BuildingType.theater, '成都', '天安门')
  ];

  _OnTap(int postion) {
    debugPrint('item = $postion');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return ItemView(index, buildings[index], _OnTap(index));
        });
  }
}

//
//class RandomWords extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return RandomWordsState();
//  }
//}
//
//class RandomWordsState extends State<RandomWords> {
//  // TODO: implement build
//  final _suggestions = <WordPair>[];
//  var _save = new Set<WordPair>();
//  final _biggerFont = const TextStyle(fontSize: 18);
//
//  @override
//  Widget build(BuildContext context) {
//    _buildRow(WordPair word) {
//      var isSave = _save.contains(word);
//      return ListTile(
//        title: Text(
//          word.asPascalCase,
//          style: _biggerFont,
//        ),
//        trailing: Icon(
//          isSave ? Icons.favorite : Icons.favorite_border,
//          color: isSave ? Colors.red : null,
//        ),
//        onTap: () {
//          setState(() {
//            if (isSave) {
//              _save.remove(word);
//            } else {
//              _save.add(word);
//            }
//          });
//        },
//      );
//    }
//
//    _buildSuggestions() {
//      return ListView.builder(
//          padding: EdgeInsets.all(16),
//          itemBuilder: (context, i) {
//            if (i.isOdd) {
//              return Divider();
//            }
//            var index = i ~/ 2;
//            if (index >= _suggestions.length) {
//              _suggestions.addAll(generateWordPairs().take(10));
//            }
//            return _buildRow(_suggestions[index]);
//          });
//    }
//
//    _onPushSave() {
//      assert(true);
//      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//        var titles = _save.map((word) {
//          return ListTile(
//            title: Text(
//              word.asPascalCase,
//              style: _biggerFont,
//            ),
//          );
//        });
//        return Scaffold(
//          appBar: AppBar(
//            title: Text("collect page"),
//          ),
//          body: ListView(
//            children: ListTile.divideTiles(
//              context: context,
//              tiles: titles,
//            ).toList(),
//          ),
//        );
//      }));
//    }
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("APP BAR"),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.list), onPressed: _onPushSave)
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//}
