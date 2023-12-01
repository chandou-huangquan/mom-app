import 'package:offer_system/common/base_model.dart';
import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'xunjia_api.dart';

class XunjiaModel extends BaseModel {
  ///原料的属性
  String str;

  XunjiaApi _api;

  XunjiaModel(XunjiaApi api) {
    this._api = api;
  }

  List<dynamic> maps;

  void getYuanliao(Chenpin chenpin, String caizhi, String xinhao) async {
    loadingg(true);
    maps = await _api.getYuanliao(caizhi, xinhao);
    if (maps != null) {
      chenpin.getYuliaos(maps);
    }
    loadingg(false);
  }

  void addXunjia(Chenpin chenpin) {
    loadingg(true);
    _api.addXunjia(chenpin);
    loadingg(false);
  }
}
