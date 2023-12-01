import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:offer_system/utils/dioUtils_ss.dart';
import 'package:offer_system/utils/shared_preferences.dart';

class TestFu extends StatefulWidget {
  TestFu({Key key}) : super(key: key);

  @override
  _TestFuState createState() => _TestFuState();
}

class _TestFuState extends State<TestFu> {
  Future<String> get() async {
    SpUtil sp = await SpUtil.getInstance();
    String a = sp.getString("token");
    return a;
  }

  // Future<String> get1() async {
  //   var pa = {"a": "abc"};
  //   var a = await DioUtilss.requestHttp<String>(Api.baseUrl + "/test/test1",
  //       method: "get");
  //   // print(a);
  //   return a;
  // }

  Future<String> get1() async {
    var pa = {"a": "abc"};
    var a = await DioUtilss.requestHttp<String>(
        "http://192.168.10.104:8090/test/test1",
        parameters: pa,
        method: "get");
    // print(a);
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试页"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 13,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Archive',
                      color: Colors.blue,
                      icon: Icons.archive,
                    ),
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'More',
                      color: Colors.grey.shade200,
                      icon: Icons.more_horiz,
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                    ),
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                  ),
                  child: ListTile(
                    title: Text('$index'),
                  ),
                );
              },
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              color: Colors.blue,
              elevation: 20,
              margin: EdgeInsets.all(20),
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Card Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    subtitle: Text(
                      'something in card',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(24),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarThemeData(),
                    child: ButtonBar(
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SearchListWidget(),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.green,
          elevation: 20,
          margin: EdgeInsets.all(20),
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                ),
                title: Text(
                  'Card Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                subtitle: Text(
                  'something in card',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                  ),
                ),
                contentPadding: EdgeInsets.all(24),
              ),
              ButtonBarTheme(
                data: ButtonBarThemeData(),
                child: ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchListWidget extends StatefulWidget {
  @override
  _SearchListWidgetState createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  final initList = List<String>.generate(10000, (i) => 'Search Item $i');
  TextEditingController editingController = TextEditingController();
  var showItemList = List<String>();

  @override
  void initState() {
    showItemList.addAll(initList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: editingController,
          decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            filterSearch(value);
          },
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: showItemList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${showItemList[index]}'),
              );
            },
          ),
        ),
      ],
    );
  }

  filterSearch(String query) {
    List<String> searchList = List<String>();
    searchList.addAll(initList);
    if (query.isNotEmpty) {
      List<String> resultListData = List<String>();
      searchList.forEach((item) {
        if (item.contains(query)) {
          resultListData.add(item);
        }
      });
      setState(() {
        showItemList.clear();
        showItemList.addAll(resultListData);
      });
      return;
    } else {
      setState(() {
        showItemList.clear();
        showItemList.addAll(initList);
      });
    }
  }
}
