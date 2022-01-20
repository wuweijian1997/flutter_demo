import 'package:flutter/material.dart';

class FragmentsExample extends StatelessWidget {
  final double width;
  final double height;

  const FragmentsExample({this.width = 300, this.height = 300, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildItem(Colors.red, const Icon(Icons.favorite)),
            buildItem(Colors.blue, const Icon(Icons.pages)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildItem(Colors.green, const Icon(Icons.settings)),
            buildItem(Colors.yellow, const Icon(Icons.animation)),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              './assets/rem.jpg',
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            ),
            const Text(
              'Logic',
              style: TextStyle(fontSize: 40),
            ),
          ],
        )
      ],
    );
  }

  buildItem(Color color, Icon icon) {
    return Container(
      color: color,
      width: width / 2,
      height: height / 4,
      child: icon,
    );
  }
}
