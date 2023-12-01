import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offer_system/test/widget/showDiolag.dart';
import 'package:offer_system/utils/provider_widget.dart';
import 'package:offer_system/widget/fultter_toast_widget.dart';
import 'package:offer_system/widget/text_widget.dart';
import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'package:offer_system/xunjia/model/xunjia_model.dart';
import 'package:offer_system/xunjia/pages/yuanliao_modify_page.dart';
import 'package:offer_system/xunjia/widget/txtBtn_widget.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class GetYuanliao extends StatelessWidget {
  const GetYuanliao({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     color: XunjiaAppTheme.nearlyWhite,
      //   ),
      //   backgroundColor: XunjiaAppTheme.nearlyBlue,
      //   onPressed: () {
      //     // print('chanpinLeixing');
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                child: Column(
                  children: [
                    CaizhiInfo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaizhiInfo extends StatefulWidget {
  CaizhiInfo({Key key}) : super(key: key);

  @override
  _CaizhiInfoState createState() => _CaizhiInfoState();
}

class _CaizhiInfoState extends State<CaizhiInfo> {
  void onpress(BuildContext context, Chenpin chinpinProvider) {
    int i = 0;
    chinpinProvider.yuanliaos.forEach((element) {
      if (element.invcode == null ||
          element.invcode == "ZBD" ||
          element.invcode == "") {
        i++;
        return;
      }
    });
    if (i > 0) {
      Toast.showToast("有未知的物料，在u8c中不存在！", ErrorLevel.Warning);
    } else {
      CupertinoAlertDialogWidget(context, "提交报价", "提交后将此信息发送至各个部门开始做选择题。", () {
        Provider.of<XunjiaModel>(context, listen: false)
            .addXunjia(chinpinProvider);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
      }, null)
          .showDialogIos();
    }
  }

  @override
  Widget build(BuildContext context) {
    Chenpin chinpinProvider = Provider.of<Chenpin>(context);
    return ProviderWidget<XunjiaModel>(
      model: XunjiaModel(Provider.of(context)),
      onReady: (model) => model.getYuanliao(chinpinProvider,
          chinpinProvider.productCaizhi, chinpinProvider.productXinhao),
      builder: (context, model, child) {
        if (model.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  textContent: "材质型号",
                  fSize: 16.0,
                ),
                chinpinProvider.yuanliaos == null
                    ? SizedBox()
                    : YuanliaoModify(),
                TxtBtn(
                  text: "开始询价",
                  onpress: () => onpress(context, chinpinProvider),
                )
              ],
            ),
          );
        }
      },
    );
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
