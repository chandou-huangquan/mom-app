import 'package:offer_system/common/base_model.dart';
import 'package:offer_system/xunjia/model/xunjia_api.dart';

class XjProductDetailsModel extends BaseModel {
  XunjiaApi _api;

  XjProductDetailsModel(XunjiaApi api) {
    this._api = api;
  }

  List<dynamic> maps;

  void getXjProductModel(String deptCode) async {
    loadingg(true);
    maps = await _api.getXjProductApi(deptCode);
    loadingg(false);
  }
}
