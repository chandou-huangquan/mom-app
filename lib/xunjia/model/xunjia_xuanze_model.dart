import 'package:offer_system/common/base_model.dart';
import 'package:offer_system/utils/shared_preferences.dart';
import 'package:offer_system/xunjia/model/xunjia_api.dart';

class XunjiaXuanzeModel extends BaseModel {
  XunjiaApi _api;

  XunjiaXuanzeModel(XunjiaApi api) {
    this._api = api;
  }

  var maps;

  Future getXuanzeModel(int pageIndex, int pageSize) async {
    loadingg(true);
    SpUtil sp = await SpUtil.getInstance();
    String dept = sp.getString("dept");
    maps = await _api.getXuanze(dept, pageIndex, pageSize);
    loadingg(false);
  }
}
