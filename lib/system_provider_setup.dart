import 'package:offer_system/model/system_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'bean/sm_user_bean.dart';

List<SingleChildStatelessWidget> systemProviders = [
  Provider<SystemApi>(create: (_) => SystemApi()),
  ChangeNotifierProvider<SmUserBean>(
    create: (_) => SmUserBean(),
  ),
];
