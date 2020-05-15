import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/**
 * 动画demo页面
 */
class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimState();
  }
}

class AnimState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController con;
  CurvedAnimation _curvedAnimation;
  Animation<Offset> _offsetAnimation;
  Animation<double> _roteAnim;
  Animation<double> left;
  Animation<double> scaleA;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(_initAnim);
  }

  void _initAnim() {
    con = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    _curvedAnimation = CurvedAnimation(parent: con, curve: Curves.decelerate);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(4.5, 0.0),
    ).animate(_curvedAnimation);
    _roteAnim = Tween(
      begin: 0.0,
      end: 0.25,
    ).animate(_curvedAnimation);

    var queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    left = Tween(begin: 0.0, end: width).animate(con)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          con.reverse();
        } else if (state == AnimationStatus.dismissed) {
          con.forward();
        }
      });
    scaleA = Tween(begin: 0.0, end: 1.0).animate(con);
    con.forward();
  }

  @override
  Widget build(BuildContext context) {
    var scale = ScaleTransition(child: Text("我是动画"), scale: _curvedAnimation);
    var fade = FadeTransition(child: scale, opacity: _curvedAnimation);
    var tran = SlideTransition(position: _offsetAnimation, child: fade);
    var rote = RotationTransition(
      turns: _roteAnim,
      child: tran,
    );

    final marginLeft = left == null ? 0 : left.value;
    final marginTop = math.sin(marginLeft / 20) * 20;
    var contain = Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop + 100),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(8)),
    );

    var scaleBoll = ScaleTransition(child: contain, scale: scaleA);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("page-anim"),
      ),
      body: Column(
        children: <Widget>[rote, scaleBoll],
      ),
    );
  }
}
