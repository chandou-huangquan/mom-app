import 'package:flutter/material.dart';

class XjXzCard extends StatelessWidget {
  const XjXzCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
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
    );
  }
}
