import 'package:flutter/material.dart';
import 'package:offer_system/widget/pullRefresh_Widget.dart';

class TestPage1 extends StatelessWidget {
  const TestPage1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("测试下拉")),
      body: PullRefreshWidget(),
    );
  }
}
