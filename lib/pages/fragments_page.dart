import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class FragmentsPage extends StatefulWidget {
  static const String rName = 'Fragments';

  @override
  _FragmentsPageState createState() => _FragmentsPageState();
}

class _FragmentsPageState extends State<FragmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Fragments(
            tag: "Fragments",
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.red,
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.green,
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      color: Colors.yellow,
                      width: 100,
                      height: 100,
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
