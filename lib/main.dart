import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "first flutter app",
      theme: ThemeData(primaryColor: Colors.white, dividerColor: Colors.amber),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  // TODO: implement build
  final _suggestions = <WordPair>[];
  var _save = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    _buildRow(WordPair word) {
      var isSave = _save.contains(word);
      return ListTile(
        title: Text(
          word.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          isSave ? Icons.favorite : Icons.favorite_border,
          color: isSave ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (isSave) {
              _save.remove(word);
            } else {
              _save.add(word);
            }
          });
        },
      );
    }

    _buildSuggestions() {
      return ListView.builder(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, i) {
            if (i.isOdd) {
              return Divider();
            }
            var index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          });
    }

    _onPushSave() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        var titles = _save.map((word) {
          return ListTile(
            title: Text(
              word.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        return Scaffold(
          appBar: AppBar(
            title: Text("collect page"),
          ),
          body: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: titles,
            ).toList(),
          ),
        );
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("APP BAR"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _onPushSave)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

//class RollingButton extends StatefulWidget {
//  @override
//  State createState() {
//    return _RollingButton();
//  }
//}
//
//class _RollingButton extends State<RollingButton> {
//  final _random = Random();
//
//  List<int> _list() {
//    final i = _random.nextInt(6) + 1;
//    final j = _random.nextInt(6) + 1;
//    return [i, j];
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return RaisedButton(
//      onPressed: _onPressed,
//      child: Text('random word'),
//    );
//  }
//
//  _onPressed() {
//    debugPrint('_onPressed');
////    var result = _list();
//    var wordPair = WordPair.random();
//    showDialog(
//        context: context,
//        builder: (_) {
//          return AlertDialog(
//            content: Text(wordPair.asPascalCase),
////            content: Text('roll result: ${result[0]} , ${result[1]}'),
//          );
//        });
//  }
//}
