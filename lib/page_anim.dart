import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:flutter_demo/view/constom_view_smile.dart';

/**
 * 动画demo页面
 */
class PageAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimState();
  }
}

class AnimState extends State<PageAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController con;
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  Animation<Offset> _offsetAnimation;
  Animation<double> _roteAnim;
  Animation<double> left;
  Animation<double> scaleA;
  Animation<double> rote;

  @override
  void initState() {
    // TODO: implement initState
//    Future(_initAnim);
    _initAnim();
    super.initState();
  }

  void _initAnim() {
    con = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    var roteCur = CurvedAnimation(parent: con, curve: Interval(0.0, 0.8));
    rote = Tween(begin: math.pi * 1.5, end: math.pi * 3.5).animate(roteCur)
      ..addListener(() {
        setState(() {});
      });
//    _curvedAnimation = CurvedAnimation(parent: con, curve: Curves.decelerate);
//    _offsetAnimation = Tween<Offset>(
//      begin: Offset.zero,
//      end: const Offset(4.5, 0.0),
//    ).animate(_curvedAnimation);
//    _roteAnim = Tween(
//      begin: 0.0,
//      end: 0.25,
//    ).animate(_curvedAnimation);
//
//    var queryData = MediaQuery.of(context);
//    var width = queryData.size.width;
//    left = Tween(begin: 0.0, end: width).animate(con)
//      ..addListener(() {
//        setState(() {});
//      })
//      ..addStatusListener((state) {
//        if (state == AnimationStatus.completed) {
//          con.reverse();
//        } else if (state == AnimationStatus.dismissed) {
//          con.forward();
//        }
//      });
//    scaleA = Tween(begin: 0.0, end: 1.0).animate(con);
//    con.forward();
  }

  @override
  Widget build(BuildContext context) {
//    var scale = ScaleTransition(child: Text("我是动画"), scale: _curvedAnimation);
//    var fade = FadeTransition(child: scale, opacity: _curvedAnimation);
//    var tran = SlideTransition(position: _offsetAnimation, child: fade);
//    var rote = RotationTransition(
//      turns: _roteAnim,
//      child: tran,
//    );
//
//    final marginLeft = left == null ? 0 : left.value;
//    final marginTop = math.sin(marginLeft / 20) * 20;
//    var contain = Container(
//      margin: EdgeInsets.only(left: marginLeft, top: marginTop + 100),
//      width: 16,
//      height: 16,
//      decoration: BoxDecoration(
//          color: Colors.blue, borderRadius: BorderRadius.circular(8)),
//    );
//
//    var scaleBoll = ScaleTransition(child: contain, scale: scaleA);

    var smile = Container(
      child: CustomPaint(
        painter: MyPaint(rote.value, math.sin(rote.value) + math.pi),
      ),
      width: 200,
      height: 200,
      color: Colors.deepOrange,
      padding: EdgeInsets.all(30.0),
    );
    // TODO: 1.Column内元素为什么没有水平居中  2.smile控件为什么会随其他动画联动
    return Scaffold(
      appBar: AppBar(
        title: Text("page-anim"),
      ),
      body: Column(
        children: <Widget>[smile],
      ),
    );
  }
}
