import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CustomImagePage extends StatelessWidget {
  static const String rName = 'CustomImage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CustomImage(
          image: NetworkImage(
            'https://www.monstersandcritics.com/wp-content/uploads/2020/07/Re-Zero-Rem-wake-up-death.jpg',
          ),
          width: 300,
          height: 400,
          loadingBuilder: (context, child, ImageChunkEvent? imageChunkEvent) {
            if(imageChunkEvent == null) {
              return Text('未加载');
            }
            return Text('加载中: ${imageChunkEvent.cumulativeBytesLoaded} / ${imageChunkEvent.expectedTotalBytes}');
          },
          errorWidgetBuilder: (context, err, stack) {
            return Text('加载失败');
          },
        ),
      ),
    );
  }
}
