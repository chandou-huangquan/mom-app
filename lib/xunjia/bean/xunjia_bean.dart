import 'package:flutter/cupertino.dart';

class Chenpin with ChangeNotifier {
  ///成品的属性
  String productType;
  String productCaizhi;
  String productXinhao;
  String customer;
  String customerYaoqiu;
  String deptCode;
  String productNameDetail;
  int productDetailsId;
  List<Yuanliao> yuanliaos;

  Chenpin(
      {this.productType,
      this.productCaizhi,
      this.productXinhao,
      this.customer,
      this.customerYaoqiu,
      this.yuanliaos,
      this.deptCode,
      this.productNameDetail,
      this.productDetailsId});

  Chenpin.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productCaizhi = json['productCaizhi'];
    productXinhao = json['productXinhao'];
    customer = json['customer'];
    customerYaoqiu = json['customerYaoqiu'];
    deptCode = json['deptCode'];
    productNameDetail = json['productNameDetail'];
    productDetailsId = json['productDetailsId'];
    if (json['yuanliaos'] != null) {
      yuanliaos = [];
      json['yuanliaos'].forEach((v) {
        yuanliaos.add(new Yuanliao.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productType'] = this.productType;
    data['productCaizhi'] = this.productCaizhi;
    data['productXinhao'] = this.productXinhao;
    data['customer'] = this.customer;
    data['customerYaoqiu'] = this.customerYaoqiu;
    data['deptCode'] = this.deptCode;
    data['productNameDetail'] = this.productNameDetail;
    data['productDetailsId'] = this.productDetailsId;
    if (this.yuanliaos != null) {
      data['yuanliaos'] = this.yuanliaos.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void updateLeixing(String chenpinLeixing) {
    this.productType = chenpinLeixing;
    notifyListeners();
  }

  void updateKehu(String kehu) {
    this.customer = kehu;
    notifyListeners();
  }

  void updateYaoqiu(String yaoqiu) {
    this.customerYaoqiu = yaoqiu;
    notifyListeners();
  }

  void updateXinhao(String xinhao) {
    this.productXinhao = xinhao;
    notifyListeners();
  }

  void updateCaizhi(String caizhi) {
    this.productCaizhi = caizhi;
    notifyListeners();
  }

  void updateFuzhuCaizhi(String neirong) {
    this.productCaizhi =
        this.productCaizhi == null ? neirong : this.productCaizhi + neirong;
    notifyListeners();
  }

  void getYuliaos(List<dynamic> maps) {
    yuanliaos = [];
    maps.forEach((element) {
      Yuanliao yuanliao = new Yuanliao(
          invcode: element["invcode"],
          invname: element["caizhi"],
          invspec: element["xinhao"]);
      yuanliaos.add(yuanliao);
    });
    notifyListeners();
  }

  void updateYuanliao(int index, String newXinhao) {}

  void clearYuanliaos() {
    this.yuanliaos = [];
  }

  void updateProductDetail(int id, String deptcode) {
    this.productDetailsId = id;
    this.deptCode = deptcode;
  }
}

class Yuanliao with ChangeNotifier {
  String invcode;
  String invname;
  String invspec;

  Yuanliao({this.invcode, this.invname, this.invspec});

  Yuanliao.fromJson(Map<String, dynamic> json) {
    invcode = json['invcode'];
    invname = json['invname'];
    invspec = json['invspec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invcode'] = this.invcode;
    data['invname'] = this.invname;
    data['invspec'] = this.invspec;
    return data;
  }
}
