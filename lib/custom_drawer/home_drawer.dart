import 'package:flutter/material.dart';
import 'package:offer_system/app_theme.dart';
import 'package:offer_system/fuye/pages/login_page.dart';
import 'package:offer_system/navigation_home_screen.dart';
import 'package:offer_system/utils/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key key,
    this.iconAnimationController,
    this.screenIndex,
    this.callBackIndex,
  }) : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;
  bool islogin;
  SpUtil sp;

  Future<bool> getLoginStatus() async {
    sp = await SpUtil.getInstance();
    islogin = sp.getBool('islogin');
    return islogin;
  }

  Future<String> getUsername() async {
    SpUtil sp = await SpUtil.getInstance();
    return sp.getString("username");
  }

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: '主页',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: '帮助',
        isAssetsImage: true,
        imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: '意见反馈',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: '邀请朋友',
        icon: Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: '给出评价',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: '关于我们',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset('assets/images/userimg.png'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 30),
                    child: FutureBuilder(
                      future: getUsername(),
                      builder: (context, AsyncSnapshot anapshot) {
                        if (anapshot.hasData) {
                          return Text(
                            anapshot.data,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.grey,
                                fontSize: 18),
                          );
                        } else {
                          return Text(
                            "南慕容",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.grey,
                                fontSize: 18),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(height: 1, color: AppTheme.grey.withOpacity(0.6)),
          Expanded(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0.0),
            itemCount: drawerList.length,
            itemBuilder: (BuildContext context, int index) {
              return inkwell(drawerList[index]);
            },
          )),
          Divider(height: 1, color: AppTheme.grey.withOpacity(0.6)),
          Column(
            children: <Widget>[
              ListTile(
                title: FutureBuilder(
                    future: getLoginStatus(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (!snapshot.data) {
                          return Text(
                            '登录',
                            style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppTheme.darkText),
                            textAlign: TextAlign.left,
                          );
                        } else {
                          return Text(
                            "注销",
                            style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppTheme.darkText),
                            textAlign: TextAlign.left,
                          );
                        }
                      } else {
                        return Text(
                          "登录",
                          style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppTheme.darkText),
                          textAlign: TextAlign.left,
                        );
                      }
                    }),
                trailing: FutureBuilder(
                  future: getLoginStatus(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (!snapshot.data) {
                        return Icon(Icons.login_rounded,
                            color: Colors.redAccent);
                      } else {
                        return Icon(Icons.power_settings_new,
                            color: Colors.redAccent);
                      }
                    } else {
                      return Icon(Icons.login_rounded, color: Colors.redAccent);
                    }
                  },
                ),
                // trailing: IconButton(
                //   icon: Icon(Icons.power_settings_new),
                //   color: Colors.red,
                // onPressed: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => LoginPage()));
                // },
                // ),
                onTap: () async {
                  print(islogin);
                  if (islogin == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    return;
                  }
                  if (islogin) {
                    SpUtil sp = await SpUtil.getInstance();
                    sp.putString("username", "沪江游客");
                    sp.putBool("islogin", false);
                    sp.putString("token", null);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationHomeScreen()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
