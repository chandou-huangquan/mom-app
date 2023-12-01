import 'package:flutter/material.dart';
import 'package:offer_system/system_provider_setup.dart';
import 'package:offer_system/utils/shared_preferences.dart';
import 'package:offer_system/xunjia_provider_setup.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'navigation_home_screen.dart';

SpUtil sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
  //     .then((_) => runApp(MyApp()));
  // final provider = Provider();
  // await provider.init(true);
  sp = await SpUtil.getInstance();
  runApp(MultiProvider(
      providers: xunjiaProviders..addAll(systemProviders), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '沪江系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS),
      home: NavigationHomeScreen(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
