import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  static const rName = 'Demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: Offset.zero)
              ]),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    child: Image.network("https://img.zcool.cn/community/01f68d5c0d11d9a80121ab5de16b86.jpg@1280w_1l_2o_100sh.jpg"),
                    height: 130,
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  ),
                  Container(
                    height: 130,
                    color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Name:",
                            ),
                            Container(
                              width: 4,
                            ),
                            Text(
                              "Girdhari Lal",
                            ),
                          ],
                        ),
                        Container(height: 8),
                        Text(
                          "Meeting Time",
                        ),
                        Container(height: 8),
                        Text(
                          "Agenda",
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
