import 'package:flutter/material.dart';
import 'package:offer_system/app_theme.dart';
import 'package:offer_system/xunjia/widget/xunjia_appbar_widget.dart';

class XunjiaBill extends StatefulWidget {
  XunjiaBill({Key key}) : super(key: key);

  @override
  _XunjiaBillState createState() => _XunjiaBillState();
}

class _XunjiaBillState extends State<XunjiaBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XunjiaAppbar(
              title: "询价列表",
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                // controller: editingController,
                decoration: InputDecoration(
                  labelText: '型号搜索',
                  hintText: '型号搜索',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // filterSearch(value);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text("sadaf"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
