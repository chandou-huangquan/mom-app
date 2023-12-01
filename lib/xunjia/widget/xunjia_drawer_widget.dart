import 'package:flutter/material.dart';
import 'package:offer_system/utils/provider_widget.dart';
import 'package:offer_system/xunjia/bean/xunjia_bean.dart';
import 'package:offer_system/xunjia/model/xjProductDetails_model.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key, this.deptCode, this.deptName, this.id})
      : super(key: key);

  final String deptCode;
  final String deptName;
  int id;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // String _radioGroupA = "";

  void _handleRadioValueChanged(int value) {
    setState(() {
      widget.id = value;
    });
    print(widget.id);
    Provider.of<Chenpin>(context, listen: false)
        .updateProductDetail(widget.id, widget.deptCode);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<XjProductDetailsModel>(
      model: XjProductDetailsModel(Provider.of(context)),
      onReady: (model) => model.getXjProductModel(widget.deptCode),
      builder: (context, model, child) {
        if (model.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            // height: 300,
            child: Drawer(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.maps.length,
                      itemBuilder: (context, i) {
                        return RadioListTile<int>(
                          value: model.maps[i]["id"],
                          groupValue: widget.id,
                          onChanged: _handleRadioValueChanged,
                          subtitle: Text(widget.deptName),
                          title: Text(model.maps[i]["productName"]),
                          secondary: Icon(Icons.arrow_forward_ios_rounded),
                          selected: widget.id == model.maps[i]["id"],
                        );
                      })
                ]),
              ),
            )),
          );
        }
      },
    );
  }
}
