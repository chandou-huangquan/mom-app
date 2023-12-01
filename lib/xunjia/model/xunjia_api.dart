import 'package:offer_system/common/api.dart';
import 'package:offer_system/utils/dioUtils_s.dart';
import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'dart:convert' as JSON;

class XunjiaApi extends Api {
  static const String testXunjiaTest = '/yuanliao/getyl';
  static const String addXunjiaApi = "/xunjia/add";
  static const String findXjproDetailsByDeptCode =
      "/xjproDetails/findByDeptCode";
  static const String findforxuanze = "/xjbillmain/findforxuanze";

  Future getYuanliao(String caizhi, String xinhao) async {
    var params = {"caizhi": caizhi, "xinhao": xinhao};
    var response = DioUtilss.requestHttp(Api.baseUrl + XunjiaApi.testXunjiaTest,
        parameters: params, method: "get");
    return response;
  }

  Future addXunjia(Chenpin chenpin) async {
    var response = DioUtilss.requestHttp(Api.baseUrl + XunjiaApi.addXunjiaApi,
        data: JSON.jsonEncode(chenpin), method: "postjson");
    return response;
  }

  Future getXjProductApi(String deptCode) async {
    var params = {"deptcode": deptCode};
    var response = DioUtilss.requestHttp(
        Api.baseUrl + XunjiaApi.findXjproDetailsByDeptCode,
        parameters: params,
        method: "get");
    return response;
  }

  Future getXuanze(String deptCode, int pageIndex, int pageSize) {
    var params = {
      "deptCode": deptCode,
      "pageIndex": pageIndex,
      "pageSize": pageSize
    };
    print(params);
    var response = DioUtilss.requestHttp(Api.baseUrl + XunjiaApi.findforxuanze,
        parameters: params, method: "get");
    return response;
  }
}
