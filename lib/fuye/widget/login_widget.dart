import 'dart:math';
import 'package:flutter/material.dart';
import 'package:offer_system/bean/sm_user_bean.dart';
import 'package:offer_system/fuye/theme/app_size.dart';
import 'package:offer_system/fuye/theme/app_style.dart';
import 'package:offer_system/fuye/widget/welcome_widget.dart';
import 'package:offer_system/model/sm_user_model.dart';
import 'package:offer_system/model/system_api.dart';
import 'package:offer_system/navigation_home_screen.dart';
import 'package:offer_system/utils/provider_widget.dart';
import 'package:offer_system/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

///登录页面剪裁曲线
class LoginClipper extends CustomClipper<Path> {
  // 第一个点
  Point p1 = Point(0.0, 54.0);
  Point c1 = Point(20.0, 25.0);
  Point c2 = Point(81.0, -8.0);
  // 第二个点
  Point p2 = Point(160.0, 20.0);
  Point c3 = Point(216.0, 38.0);
  Point c4 = Point(280.0, 73.0);
  // 第三个点
  Point p3 = Point(280.0, 44.0);
  Point c5 = Point(280.0, -11.0);
  Point c6 = Point(330.0, 8.0);

  @override
  Path getClip(Size size) {
    // 第四个点
    Point p4 = Point(size.width, .0);

    Path path = Path();
    // 移动到第一个点
    path.moveTo(p1.x, p1.y);
    //第一阶段 三阶贝塞尔曲线
    path.cubicTo(c1.x, c1.y, c2.x, c2.y, p2.x, p2.y);
    //第二阶段 三阶贝塞尔曲线
    path.cubicTo(c3.x, c3.y, c4.x, c4.y, p3.x, p3.y);
    //第三阶段 三阶贝塞尔曲线
    path.cubicTo(c5.x, c5.y, c6.x, c6.y, p4.x, p4.y);
    // 连接到右下角
    path.lineTo(size.width, size.height);
    // 连接到左下角
    path.lineTo(0, size.height);
    //闭合
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this.hashCode != oldClipper.hashCode;
  }
}

/// 登录图标按钮
class LoginBtnIconWidget extends StatelessWidget {
  const LoginBtnIconWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SmUserBean smUserProvider = Provider.of<SmUserBean>(context);
    return Row(
      children: [
        Spacer(),
        ProviderWidget<SmUserModel>(
          model: SmUserModel(Provider.of<SystemApi>(context)),
          builder: (context, model, child) {
            if (model.loading) {
              return CircularProgressIndicator();
            } else {
              return GradientBtnWidget(
                  width: 160,
                  child: Row(
                    children: [
                      SizedBox(width: 34),
                      BtnTextWhiteWidget(
                        text: '登录',
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/icons/icon_arrow_right.png',
                        width: kIconSize,
                        height: kIconSize,
                      ),
                      SizedBox(width: 24),
                    ],
                  ),
                  onTap: () async {
                    bool isSuccess = await model.pae(smUserProvider);
                    SpUtil sp = await SpUtil.getInstance();
                    var username = sp.getString("username");
                    if (isSuccess && username != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationHomeScreen()));
                    }
                    // Navigator.pop(context);
                    // print(smUserProvider.username);
                    // print(smUserProvider.password);
                  });
            }
          },
        ),
      ],
    );
  }
}

///登录输入框
class LoginInput extends StatelessWidget {
  LoginInput(
      {Key key, this.hintText, this.prefixIcon, this.obscureText = false})
      : super(key: key);

  final String hintText;
  final String prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    SmUserBean smUserProvider = Provider.of<SmUserBean>(context);
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: kInputBorder,
        focusedBorder: kInputBorder,
        enabledBorder: kInputBorder,
        prefixIcon: Container(
          width: kIconBoxSize,
          height: kIconBoxSize,
          alignment: Alignment.center,
          child: Image.asset(
            prefixIcon,
            width: kIconSize,
            height: kIconSize,
          ),
        ),
      ),
      obscureText: obscureText,
      style: kBodyTextStyle.copyWith(
        fontSize: 18,
      ),
      onChanged: (String value) {
        if (hintText == "usercode") {
          smUserProvider.updateUsername(value);
        } else if (hintText == "Password") {
          smUserProvider.updatePass(value);
        }
      },
    );
  }
}

/// 返回图标
class BackIcon extends StatelessWidget {
  const BackIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: kIconBoxSize,
        height: kIconBoxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/icons/icon_back.png',
          width: kIconSize,
          height: kIconSize,
        ),
      ),
    );
  }
}
