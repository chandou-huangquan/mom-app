import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoAlertDialogWidget {
  final BuildContext context;
  final String title;
  final String content;
  final Function querenBtn;
  final Function quxiaoBtn;

  CupertinoAlertDialogWidget(
      this.context, this.title, this.content, this.querenBtn, this.quxiaoBtn);

  void showDialogIos() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('确定'),
              isDestructiveAction: true,
              onPressed: () {
                querenBtn();
              },
            ),
            CupertinoDialogAction(
              child: Text('取消'),
              isDefaultAction: true,
              onPressed: () {
                print(quxiaoBtn);
                if (quxiaoBtn == null) {
                  Navigator.pop(context);
                } else {
                  quxiaoBtn();
                }
              },
            )
          ],
        );
      },
    );
  }
}
