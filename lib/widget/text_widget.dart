import 'package:flutter/material.dart';
import 'package:offer_system/xunjia/xunjia_app_theme.dart';

class TextWidget extends StatelessWidget {
  final String textContent;
  final double fSize;
  TextWidget({this.textContent, this.fSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fSize,
        letterSpacing: 0.27,
        color: XunjiaAppTheme.darkerText,
      ),
    );
  }
}
