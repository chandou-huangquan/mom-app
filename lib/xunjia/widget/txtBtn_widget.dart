import 'package:flutter/material.dart';
import 'package:offer_system/xunjia/xunjia_app_theme.dart';

class TxtBtn extends StatefulWidget {
  TxtBtn({Key key, this.text, this.onpress}) : super(key: key);

  final String text;
  final Function onpress;

  @override
  _TxtBtnState createState() => _TxtBtnState();
}

class _TxtBtnState extends State<TxtBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 18, color: XunjiaAppTheme.nearlyWhite),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.red[600];
                }
                //默认不使用背景颜色
                return XunjiaAppTheme.nearlyBlue;
              }),
            ),
            onPressed: widget.onpress),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
