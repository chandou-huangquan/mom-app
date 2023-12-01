import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'xunjia/model/xunjia_api.dart';

List<SingleChildStatelessWidget> xunjiaProviders = [
  Provider<XunjiaApi>(
    create: (_) => XunjiaApi(),
  ),
  ChangeNotifierProvider(create: (_) => Chenpin())
];
