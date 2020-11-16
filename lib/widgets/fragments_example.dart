import 'package:flutter/material.dart';

class FragmentsExample extends StatelessWidget {
  final double width;
  final double height;
  const FragmentsExample({this.width = 300, this.height = 300});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildItem(Colors.red, Icon(Icons.favorite)),
            buildItem(Colors.blue, Icon(Icons.pages)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildItem(Colors.green, Icon(Icons.settings)),
            buildItem(Colors.yellow, Icon(Icons.animation)),
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
            Text('Logic', style: TextStyle(fontSize: 40),),
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
