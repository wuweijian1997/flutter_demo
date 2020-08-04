import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeroPage extends StatelessWidget {
  static const rName = 'HeroPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Hero(
              tag:
              'https://c-ssl.duitang.com/uploads/item/201609/23/20160923211308_ic4kG.png',
              child: Image.network('https://c-ssl.duitang.com/uploads/item/201609/23/20160923211308_ic4kG.png')),
        ),
      ),
    );
  }
}
