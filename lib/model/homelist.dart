import 'package:flutter/cupertino.dart';
import 'package:offer_system/test/pages/test_future.dart';
import 'package:offer_system/test2/pages/home_test.dart';
import 'package:offer_system/xunjia/pages/xunjia_home_page.dart';

class HomeList {
  Widget navigateScreen;
  String imagePath;

  HomeList({this.navigateScreen, this.imagePath = ''});

  static List<HomeList> homelist = [
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: XunjiaHome(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: TestFu(),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: HomePageTest(),
    ),
  ];
}
