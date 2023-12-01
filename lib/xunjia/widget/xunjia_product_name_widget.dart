import 'package:flutter/material.dart';
import 'package:offer_system/xunjia/xunjia_app_theme.dart';

class ProductName extends StatefulWidget {
  ProductName({Key key, this.deptCode, this.xuanzeProductName})
      : super(key: key);

  final String deptCode;
  final Function xuanzeProductName;

  @override
  _ProductNameState createState() => _ProductNameState();
}

class _ProductNameState extends State<ProductName> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            '请先产品名称',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.27,
              color: XunjiaAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  getButtonUIForProductName("0105", widget.deptCode == "0105",
                      widget.xuanzeProductName),
                  const SizedBox(
                    width: 10,
                  ),
                  getButtonUIForProductName("0106", widget.deptCode == "0106",
                      widget.xuanzeProductName),
                  const SizedBox(
                    width: 10,
                  ),
                  getButtonUIForProductName("0103", widget.deptCode == "0103",
                      widget.xuanzeProductName),
                  const SizedBox(
                    width: 10,
                  ),
                  getButtonUIForProductName("0102", widget.deptCode == "0102",
                      widget.xuanzeProductName),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // CategoryListView(
        //   callBack: () {
        //     moveTo();
        //   },
        // ),
      ],
    );
  }
}

Widget getButtonUIForProductName(
    String deptCode, bool isSelected, Function xuanzeProductName) {
  String txt = '';
  if ("0105" == deptCode) {
    txt = '制袋';
  } else if ("0106" == deptCode) {
    txt = '异型';
  } else if ('0103' == deptCode) {
    txt = '复合';
  } else if ('0102' == deptCode) {
    txt = '吹膜';
  }
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          color: isSelected
              ? XunjiaAppTheme.nearlyBlue
              : XunjiaAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: XunjiaAppTheme.nearlyBlue)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          onTap: () {
            xuanzeProductName();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
              child: Text(
                txt,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: isSelected
                      ? XunjiaAppTheme.nearlyWhite
                      : XunjiaAppTheme.nearlyBlue,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
