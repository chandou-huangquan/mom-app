import 'package:flutter/cupertino.dart';
import 'package:offer_system/xunjia/pages/xuanze_home_page.dart';
import 'package:offer_system/xunjia/pages/xunjia_page.dart';

class XujiaHomeList {
  Widget navigateScreen;
  String imagePath;
  String navigateName;

  XujiaHomeList({this.navigateScreen, this.imagePath = '', this.navigateName});

  static List<XujiaHomeList> xujiahomelist = [
    XujiaHomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateName: '询价',
      navigateScreen: Xunjia(),
    ),
    XujiaHomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateName: '选择试卷',
      navigateScreen: XunjiaBill(),
    ),
    XujiaHomeList(
      imagePath: 'assets/fitness_app/area1.png',
      navigateName: '询价审批',
      // navigateScreen: FitnessAppHomeScreen(),
    ),
    XujiaHomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateName: '询价记录',
      // navigateScreen: DesignCourseHomeScreen(),
    ),
  ];
}
