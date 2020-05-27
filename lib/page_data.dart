import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/entity_book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/**
 * 文件存储的类
 */
const String USERNAME = 'username';

const String PWD = 'pwd';

String userName;
String userPwd;

class PageData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文件存储的demo"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: LoginWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: SpWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: SqliteWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: FileWidget(),
          ),
        ],
      ),
    );
  }
}

/**
 * sp的存储练习
 */
class FileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FileWidgetState();
  }
}

class FileWidgetState extends State<FileWidget> {
  var resultTip;
  var savePath;
  String cachePath;
  String appPath;
  String sdPath;

  void _add() async {
    var file = File("$cachePath/user.txt");
    await file.writeAsString("用户名是：$userName,密码是：$userPwd");
    setState(() {
      resultTip = "增加操作成功";
    });
  }

  void _delete() {
    var file = File("$cachePath/user.txt");
    file.deleteSync();
    setState(() {
      resultTip = "删除操作成功";
    });
  }

  void _update() async {
    var file = File("$cachePath/user.txt");
    await file.writeAsString("用户名是：$userName,密码是：$userPwd");
    setState(() {
      resultTip = "更新操作成功";
    });
  }

  void _select() async {
    var file = File("$cachePath/user.txt");
    var result = "查询操作成功，${await file.readAsString()}";
    setState(() {
      resultTip = "$result";
    });
  }

  void getCachePath() async {
    var directory = await getTemporaryDirectory();
    setState(() {
      cachePath = directory.path;
    });
  }

  void getAppPath() async {
    var directory = await getApplicationDocumentsDirectory();
    setState(() {
      appPath = directory.path;
    });
  }

  void getSdPath() async {
    var directory = await getExternalStorageDirectory();
    setState(() {
      sdPath = directory.path;
    });
  }

  @override
  void initState() {
    super.initState();
    getCachePath();
    getAppPath();
    getSdPath();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("file的增删改查"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("增"),
              onPressed: _add,
            ),
            RaisedButton(
              child: Text("删"),
              onPressed: _delete,
            ),
            RaisedButton(
              child: Text("改"),
              onPressed: _update,
            ),
            RaisedButton(
              child: Text("查"),
              onPressed: _select,
            )
          ],
        ),
        Text("caceh存储的路径是：$cachePath"),
        Text("app存储的路径是：$appPath"),
        Text("sdcard存储的路径是：$sdPath"),
        Text("结果是：$resultTip"),
      ],
    );
  }
}

/**
 * sqlite的存储练习
 */
class SqliteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SqliteWidgetState();
  }
}

class SqliteWidgetState extends State<SqliteWidget> {
  var resultTip;
  final String tableBook = 'book';
  final String columnId = '_id';
  final String columnName = 'name';
  final String columnAuthor = 'author';
  String path;
  Database db;
  int a = 10012;

  Future<Database> _createTable() async {
    if (db != null) {
      return db;
    }
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, "book.db");
    return db = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      await db.execute("CREATE TABLE $tableBook (" +
          "$columnId INTEGER PRIMARY KEY," +
          "$columnName TEXT," +
          "$columnAuthor TEXT" +
          ")");
    });
  }

  void _add() async {
    a = a + 1;
    Database db = await _createTable();
    var map = {columnId: "$a", columnName: "flutter", columnAuthor: "guolin"};
    db.insert(tableBook, map);
    setState(() {
      resultTip = "增加操作成功";
    });
  }

  void _delete(int id) async {
    Database db = await _createTable();
    db.delete(tableBook, where: "$columnId=?", whereArgs: [id]);
    setState(() {
      resultTip = "删除操作成功";
    });
  }

  void _update(Book book) async {
    debugPrint("待更新的book：${book.toString()}");
    Database db = await _createTable();
    db.update(tableBook, book.toBook(),
        where: "$columnId=?", whereArgs: [book.id]);
    setState(() {
      resultTip = "更新操作成功";
    });
  }

  void _selectAll() async {
    Database db = await _createTable();
    List<Map> all = await db
        .query(tableBook, columns: [columnId, columnName, columnAuthor]);
    setState(() {
      resultTip = "查询操作成功，数据是：${all.toString()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("sqlite的增删改查"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: RaisedButton(
              child: Text("创建"),
              onPressed: _createTable,
            )),
            Expanded(
                child: RaisedButton(
              child: Text("增"),
              onPressed: _add,
            )),
            Expanded(
                child: RaisedButton(
              child: Text("删"),
              onPressed: () {
                _delete(a);
              },
            )),
            Expanded(
                child: RaisedButton(
              child: Text("改"),
              onPressed: () {
                var map = {
                  "_id": "$a",
                  "name": "java",
                  "author": "gang",
                };
                _update(Book.from(map));
              },
            )),
            Expanded(
                child: RaisedButton(
              child: Text("查"),
              onPressed: _selectAll,
            )),
          ],
        ),
        Text("结果是：$resultTip"),
      ],
    );
  }
}

/**
 * sp的存储练习
 */
class SpWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpWidgetState();
  }
}

class SpWidgetState extends State<SpWidget> {
  var resultTip;

  void _add() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USERNAME, "wxy");
    sp.setString(PWD, "123456");
    setState(() {
      resultTip = "增加操作成功";
    });
  }

  void _delete() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(USERNAME);
    sp.remove(PWD);
    setState(() {
      resultTip = "删除操作成功";
    });
  }

  void _update() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USERNAME, "wxy_new");
    sp.setString(PWD, "654321");
    setState(() {
      resultTip = "更新操作成功";
    });
  }

  void _select() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String name = sp.get(USERNAME);
    String pwd = sp.get(PWD);
    setState(() {
      resultTip = "查询操作成功，当前的用户名是：$name,密码是：$pwd";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("SP的增删改查"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("增"),
              onPressed: _add,
            ),
            RaisedButton(
              child: Text("删"),
              onPressed: _delete,
            ),
            RaisedButton(
              child: Text("改"),
              onPressed: _update,
            ),
            RaisedButton(
              child: Text("查"),
              onPressed: _select,
            )
          ],
        ),
        Text("结果是：$resultTip"),
      ],
    );
  }
}

/**
 * 用户名和密码的widget
 */
class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("对用户名和密码进行增删改查的操作"),
        TextField(
          onChanged: (str){
            userName = str;
          },
          decoration: InputDecoration(labelText: '用户名', hintText: '请输入用户名'),
        ),
        TextField(
          onChanged: (str){
            userPwd = str;
          },
          decoration: InputDecoration(labelText: '密码', hintText: '请输入密码'),
        )
      ],
    );
  }
}
