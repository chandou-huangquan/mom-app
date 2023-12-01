import 'package:offer_system/bean/sm_user_bean.dart';
import 'package:offer_system/common/base_model.dart';
import 'package:offer_system/model/system_api.dart';
import 'package:offer_system/utils/shared_preferences.dart';

class SmUserModel extends BaseModel {
  SystemApi _api;

  SmUserModel(SystemApi api) {
    this._api = api;
  }

  Future<bool> pae(SmUserBean smUserBean) async {
    loadingg(true);
    Map resMap = await _api.login(smUserBean.usercode, smUserBean.password);
    bool isSuccess = false;
    if (resMap != null) {
      SpUtil sp = await SpUtil.getInstance();
      sp.putString("token", resMap["token"]);
      sp.putString("usercode", smUserBean.usercode);
      sp.putString("username", resMap["username"]);
      sp.putString("dept", resMap["dept"]);
      sp.putBool("islogin", true);
      isSuccess = true;
    }
    loadingg(false);
    return isSuccess;
  }
}
