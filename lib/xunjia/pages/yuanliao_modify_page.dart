import 'package:flutter/material.dart';
import 'package:offer_system/main.dart';
import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'package:offer_system/xunjia/xunjia_app_theme.dart';
import 'package:provider/provider.dart';

class YuanliaoModify extends StatefulWidget {
  YuanliaoModify({Key key}) : super(key: key);

  @override
  _YuanliaoModifyState createState() => _YuanliaoModifyState();
}

class _YuanliaoModifyState extends State<YuanliaoModify>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval((1 / 4) * 1, 1.0, curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Chenpin chinpinProvider = Provider.of<Chenpin>(context);
    // return Text("123");
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        // return FadeTransition(
        //     opacity: animation,
        //     child: Transform(
        //         transform: new Matrix4.translationValues(
        //             0.0, 30 * (1.0 - animation.value), 0.0),
        // child: Padding(
        return Padding(
          padding:
              const EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              color: XunjiaAppTheme.nearlyWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: XunjiaAppTheme.grey.withOpacity(0.2),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: chinpinProvider.yuanliaos.length,
                      itemBuilder: (context, i) {
                        return YuanliaoInfo(
                          caizhi: chinpinProvider.yuanliaos[i].invname,
                          xinhao: chinpinProvider.yuanliaos[i].invspec,
                          invcode: chinpinProvider.yuanliaos[i].invcode,
                          index: i,
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class YuanliaoInfo extends StatelessWidget {
  const YuanliaoInfo(
      {Key key, this.caizhi, this.xinhao, this.invcode, this.index})
      : super(key: key);

  final int index;
  final String caizhi;
  final String xinhao;
  final String invcode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Container(
            height: 48,
            width: 2,
            decoration: BoxDecoration(
              color: HexColor('#87A0E5').withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 4),
                  child: Text(
                    caizhi,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: XunjiaAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.1,
                      color: XunjiaAppTheme.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: Image.asset("assets/fitness_app/eaten.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 3),
                      child: Text(
                        xinhao,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: XunjiaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: XunjiaAppTheme.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
