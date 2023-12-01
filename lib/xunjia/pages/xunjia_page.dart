import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'package:offer_system/xunjia/widget/xunjia_drawer_widget.dart';
import 'package:offer_system/xunjia/xunjia_app_theme.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../main.dart';
import 'yuanliao_page.dart';

class Xunjia extends StatefulWidget {
  _Xunjia createState() => _Xunjia();
}

class _Xunjia extends State<Xunjia> {
  String leixing = "lvsufuhezhongbaodai";
  String deptCode = "";
  String deptName = '';

  bool showFuzhuShuruCaizhi = false;
  bool showFuzhuShuruXinhao = false;

  FocusNode caizhiFocus = FocusNode();
  FocusNode xinghaoFocus = FocusNode();
  bool hascaizhiFocus;
  bool hasxinghaoFocus;

  TextEditingController _caizhiValue = TextEditingController();
  TextEditingController _kehuValue = TextEditingController();
  TextEditingController _xinhaoValue = TextEditingController();
  TextEditingController _yaoqiuValue = TextEditingController();

  bool _isXinke = true;

  @override
  void initState() {
    super.initState();

    ///添加获取焦点与失去焦点的兼听
    caizhiFocus.addListener(() {
      ///当前兼听的 TextFeild 是否获取了输入焦点
      hascaizhiFocus = caizhiFocus.hasFocus;
      if (!hascaizhiFocus) {
        showFuzhuShuruCaizhi = false;
      }

      ///当前 focusNode 是否添加了兼听
      // bool hasListeners = focusNode1.hasListeners;
    });

    xinghaoFocus.addListener(() {
      hasxinghaoFocus = xinghaoFocus.hasFocus;
      if (!hasxinghaoFocus) {
        showFuzhuShuruXinhao = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      endDrawer: DrawerWidget(
        deptCode: deptCode,
        deptName: deptName,
        id: Provider.of<Chenpin>(context).productDetailsId,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XjAppbar(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                      ),
                      getLeixing(),
                      getProductName(),
                      caizhiShuru(),
                      showFuzhuShuruCaizhi
                          ? fuzhuCaizhiShuru(context)
                          : Container(),
                      showFuzhuShuruXinhao ? fuzhuXinhaoShuru() : Container(),
                      xinhao(context),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            kehu(),
                            Row(children: [
                              NeumorphicCheckbox(
                                value: _isXinke,
                                onChanged: (value) {
                                  setState(() {
                                    _isXinke = value;
                                  });
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '是否新客户',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]),
                          ]),
                      kehuyaoqiu(),
                      // textButton(context),
                      TxtBtn(
                        chenpinLeixing: leixing,
                        chenpinCaizhi: _caizhiValue.text,
                        chenpinXinhao: _xinhaoValue.text,
                        kehu: _kehuValue.text,
                        yaoqiu: _yaoqiuValue.text,
                        text: "开始分析",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLeixing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            '请先选择类型',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.27,
              color: XunjiaAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  getButtonUI(
                      "lvsufuhezhongbaodai", leixing == "lvsufuhezhongbaodai"),
                  const SizedBox(
                    width: 16,
                  ),
                  getButtonUI("lvsufuheneidai", leixing == "lvsufuheneidai"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  getButtonUI("pezhongbaodai", leixing == "pezhongbaodai"),
                  const SizedBox(
                    width: 16,
                  ),
                  getButtonUI("peneidai", leixing == "peneidai"),
                  const SizedBox(
                    width: 16,
                  ),
                  getButtonUI("gongnengxingmo", leixing == "gongnengxingmo"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // CategoryListView(
        //   callBack: () {
        //     moveTo();
        //   },
        // ),
      ],
    );
  }

  Widget caizhiShuru() {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          focusNode: caizhiFocus,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: XunjiaAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: '材质，请核对格式   格式：pe/al/pa/pe',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          controller: _caizhiValue,
                          onChanged: (String value) {
                            Provider.of<Chenpin>(context, listen: false)
                                .updateCaizhi(value);
                          },
                          onTap: () {
                            setState(() {
                              showFuzhuShuruCaizhi = true;
                            });
                          },
                          onEditingComplete: () {
                            caizhiFocus.addListener(() {
                              print(caizhiFocus.hasFocus);
                            });
                            setState(() {
                              showFuzhuShuruCaizhi = false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.mode_edit, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget xinhao(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          focusNode: xinghaoFocus,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: XunjiaAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '型号   格式：0.18*400*120*800F',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          controller: _xinhaoValue,
                          onChanged: (String value) {
                            Provider.of<Chenpin>(context, listen: false)
                                .updateXinhao(value);
                          },
                          onTap: () {
                            setState(() {
                              showFuzhuShuruXinhao = true;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              showFuzhuShuruXinhao = false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.mode_edit, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget kehu() {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: XunjiaAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '客户简称',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          controller: _kehuValue,
                          onChanged: (value) {
                            Provider.of<Chenpin>(context, listen: false)
                                .updateKehu(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.mode_edit, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kehuyaoqiu() {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: XunjiaAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '客户滴要求~',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          controller: _yaoqiuValue,
                          onChanged: (value) {
                            Provider.of<Chenpin>(context, listen: false)
                                .updateYaoqiu(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.mode_edit, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget fuzhuCaizhiShuru(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 18, right: 16),
      child: Row(
        children: [
          Container(
            width: 50,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_caizhiValue, 'PE');
                  changeShuru(context, 'PE');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'PE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 50,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_caizhiValue, 'AL');
                  changeShuru(context, 'AL');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'AL',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 50,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_caizhiValue, 'PET');
                  changeShuru(context, 'PET');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'PET',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 50,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_caizhiValue, 'PA');
                  changeShuru(context, 'PA');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'PA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_caizhiValue, '/');
                  changeShuru(context, '/');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '/',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_caizhiValue, '+');
                  changeShuru(context, '+');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '+',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget fuzhuXinhaoShuru() {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 18, right: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_xinhaoValue, '*');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '*',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_xinhaoValue, '(');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '(',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_xinhaoValue, ')');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    ')',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_xinhaoValue, '+');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '+',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  btnJoinInput(_xinhaoValue, 'F');
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'F',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void btnJoinInput(TextEditingController controller, String neirong) {
    controller.text = controller.text + neirong;
    controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: controller.text.length));
  }

  void changeShuru(BuildContext context, String neirong) {
    Provider.of<Chenpin>(context, listen: false).updateFuzhuCaizhi(neirong);
  }

  Widget getButtonUI(String leixingData, bool isSelected) {
    String txt = '';
    if ("lvsufuhezhongbaodai" == leixingData) {
      txt = '铝塑复合重包袋';
    } else if ("lvsufuheneidai" == leixingData) {
      txt = '铝塑复合内袋';
    } else if ('pezhongbaodai' == leixingData) {
      txt = 'PE重包袋';
    } else if ('peneidai' == leixingData) {
      txt = 'PE内袋';
    } else if ('gongnengxingmo' == leixingData) {
      txt = '功能性膜';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? XunjiaAppTheme.nearlyBlue
                : XunjiaAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: XunjiaAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                leixing = leixingData;
                print(leixing);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? XunjiaAppTheme.nearlyWhite
                        : XunjiaAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getProductName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            '请先产品名称',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.27,
              color: XunjiaAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  getButtonUIForProductName("0105", deptCode == "0105"),
                  const SizedBox(
                    width: 10,
                  ),
                  getButtonUIForProductName("0106", deptCode == "0106"),
                  const SizedBox(
                    width: 10,
                  ),
                  getButtonUIForProductName("0103", deptCode == "0103"),
                  const SizedBox(
                    width: 10,
                  ),
                  getButtonUIForProductName("0102", deptCode == "0102"),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // CategoryListView(
        //   callBack: () {
        //     moveTo();
        //   },
        // ),
      ],
    );
  }

  Widget getButtonUIForProductName(String deptCodeData, bool isSelected) {
    String txt = "";
    if ("0105" == deptCodeData) {
      txt = '制袋';
    } else if ("0106" == deptCodeData) {
      txt = '异型';
    } else if ('0103' == deptCodeData) {
      txt = '复合';
    } else if ('0102' == deptCodeData) {
      txt = '吹膜';
    }
    return Builder(builder: (BuildContext context) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: isSelected
                  ? XunjiaAppTheme.nearlyBlue
                  : XunjiaAppTheme.nearlyWhite,
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              border: Border.all(color: XunjiaAppTheme.nearlyBlue)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                setState(() {
                  deptCode = deptCodeData;
                  deptName = txt;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 18, right: 18),
                child: Center(
                  child: Text(
                    txt,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: isSelected
                          ? XunjiaAppTheme.nearlyWhite
                          : XunjiaAppTheme.nearlyBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class XjAppbar extends StatelessWidget {
  const XjAppbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppBar().preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '询价操作',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    //此处可以放置右侧的icon
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class TxtBtn extends StatefulWidget {
  TxtBtn(
      {Key key,
      this.chenpinLeixing,
      this.kehu,
      this.yaoqiu,
      this.chenpinCaizhi,
      this.chenpinXinhao,
      this.text})
      : super(key: key);

  final String chenpinLeixing;
  final String kehu;
  final String yaoqiu;
  final String chenpinCaizhi;
  final String chenpinXinhao;
  final String text;

  @override
  _TxtBtnState createState() => _TxtBtnState();
}

class _TxtBtnState extends State<TxtBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Text(
            widget.text,
            style: TextStyle(fontSize: 18, color: XunjiaAppTheme.nearlyWhite),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              //设置按下时的背景颜色
              if (states.contains(MaterialState.pressed)) {
                return Colors.red[600];
              }
              //默认不使用背景颜色
              return XunjiaAppTheme.nearlyBlue;
            }),
          ),
          onPressed: () {
            print(widget.chenpinCaizhi);
            if (widget.chenpinCaizhi == "" ||
                widget.chenpinXinhao == "" ||
                widget.chenpinCaizhi == null ||
                widget.chenpinXinhao == null) {
              Fluttertoast.showToast(
                  msg: "材质或者型号不可以为空。",
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.yellowAccent,
                  textColor: Colors.black,
                  fontSize: 16.0);
              return;
            }
            Provider.of<Chenpin>(context, listen: false)
                .updateLeixing(widget.chenpinLeixing);
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext contxt) => GetYuanliao(),
              ),
            );
          },
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
