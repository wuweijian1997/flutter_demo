import 'package:demo/util/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class PictureFragmentsPage extends StatefulWidget {
  static const String rName = 'PictureFragments';

  @override
  _PictureFragmentsPageState createState() => _PictureFragmentsPageState();
}

class _PictureFragmentsPageState extends State<PictureFragmentsPage> {
  FragmentsController controller = FragmentsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          child: PictureFragments(
            rowLength: 20,
            columnLength: 20,
            fragmentsController: controller,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.red,
                      width: 200,
                      height: 100,
                    ),
                    Container(
                      color: Colors.blue,
                      width: 200,
                      height: 100,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.green,
                      width: 200,
                      height: 100,
                    ),
                    Container(
                      color: Colors.yellow,
                      width: 200,
                      height: 100,
                    )
                  ],
                ),
                Image.asset(
                  Assets.rem,
                  width: 400,
                  height: 200,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => controller.start(),
      ),
    );
  }
}
