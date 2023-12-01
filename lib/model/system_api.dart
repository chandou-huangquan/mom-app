import 'package:offer_system/common/api.dart';
import 'package:offer_system/utils/dioUtils_s.dart';

class SystemApi extends Api {
  static const String testXunjiaTest = '/auth/login';

  Future<Map> login(String usercode, String password) async {
    var params = {"usercode": usercode, "password": password};
    var response = DioUtilss.requestHttp<Map>(Api.baseUrl + testXunjiaTest,
        parameters: params, method: "post");
    return response;
  }
}
