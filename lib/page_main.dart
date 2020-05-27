import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/page_data.dart';
import 'package:flutter_demo/page_io_demo.dart';
import 'package:flutter_demo/page_anim.dart';
import 'package:flutter_demo/page_json_demo.dart';
import 'package:flutter_demo/page_other.dart';

class PageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pages = ["data","json","io", "anim","other"];
    return MaterialApp(
      routes: {
        "/${pages[pages.indexOf("data")]}": (context) => PageData(),
        "/${pages[pages.indexOf("json")]}": (context) => PageJsonDemo(),
        "/${pages[pages.indexOf("io")]}": (context) => PageIo(),
        "/${pages[pages.indexOf("anim")]}": (context) => PageAnimation(),
        "/${pages[pages.indexOf("other")]}": (context) => PageOther(),
      },
      home: Home(pages),
    );
  }
}

class Home extends StatelessWidget {
  List pages;

  Home(var pages) {
    this.pages = pages;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _items(int count) {
      return List<Widget>.generate(count, (int index) {
        var name = pages[index];
        return GestureDetector(
          child: Card(
            color: Colors.amberAccent,
            child: Container(
              alignment: Alignment.center,
              child: Text("$name",style: TextStyle(fontSize: 20,color: Colors
                      .blue),),
            ),
          ),
          onTap: () => Navigator.pushNamed(context, "/$name"),
        );
      });
    }

    var _buildGrid = GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.8,
      children: _items(pages.length),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("主页面"),
      ),
      body: _buildGrid,
    );
  }
}
