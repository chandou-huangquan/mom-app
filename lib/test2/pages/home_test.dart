import 'package:flutter/material.dart';
import 'package:offer_system/test2/pages/page1.dart';
import 'package:offer_system/utils/provider_widget.dart';
import 'package:offer_system/widget/pullRefresh_Widget.dart';
import 'package:offer_system/xunjia/model/xunjia_api.dart';
import 'package:offer_system/xunjia/model/xunjia_xuanze_model.dart';
import 'package:provider/provider.dart';

class HomePageTest extends StatelessWidget {
  const HomePageTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试页2"),
      ),
      body: Body(),
      endDrawer: DrawerWidget(),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.all(16),
            child: Text(
              'Android群英传',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(16),
              // image: DecorationImage(
              //   image: AssetImage('images/feedbackImage.png'),
              //   fit: BoxFit.contain,
              //   alignment: Alignment.centerRight,
              // ),
            ),
          ),
          UserAccountsDrawerHeader(
            accountName: Text('XuYisheng'),
            accountEmail: Text('XuYisheng89@163.com'),
          ),
          ListTile(
            title: Text('Title1'),
          ),
          ListTile(
            title: Text('Title1'),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Dismiss'),
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            child: Text('Open Drawer'),
          ),
          RaisedButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            child: Text('Open EndDrawer'),
          ),
          TextButton(
              onPressed: () async {
                XunjiaApi xj = XunjiaApi();
                var res = await XunjiaXuanzeModel(xj).getXuanzeModel(1, 2);
                print(res);
              },
              child: Text("asdergergewrgwrgrwtgwrtgrwgwrgtwrtgwrtg")),
          ProviderWidget<XunjiaXuanzeModel>(
            model: XunjiaXuanzeModel(Provider.of(context)),
            builder: (context, model, child) {
              if (model.loading) {
                return FlutterLogo();
              } else {
                return TextButton(
                    onPressed: () {
                      model.getXuanzeModel(0, 2);
                    },
                    child: Text("斐波那契额"));
              }
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TestPage1()));
              },
              child: Text("pushTestPage1"))
        ],
      ),
    );
  }
}
