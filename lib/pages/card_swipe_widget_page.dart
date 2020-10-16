import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CardSwipeWidgetDemo extends StatefulWidget {
  static String rName = 'card_swipe_widget';

  @override
  _CardSwipeDemoState createState() => _CardSwipeDemoState();
}

class _CardSwipeDemoState extends State<CardSwipeWidgetDemo> with SingleTickerProviderStateMixin {
  final cards = [
    'assets/eat_cape_town_sm.jpg',
    'assets/eat_new_orleans_sm.jpg',
    'assets/eat_sydney_sm.jpg',
  ];
  AnimationController controller;
  Animation<double> _animationScale;
  bool disable = false;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    _animationScale = controller.drive(Tween<double>(
      begin: 0.5,
      end: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CardSwipeDemo'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardSwipe(
              disable: disable,
              controller: controller,
              key: cardSwipeGlobalKey,
              emptyWidget: Center(
                child: Text('Empty'),
              ),
              children: [
                for (String card in cards)
                  _Card(
                    card,
                    key: ValueKey(card),
                  )
              ],
              animatedCardBuilder: animatedCardBuilder,
            ),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  child: const Text('Left'),
                  onPressed: () => cardSwipeGlobalKey.currentState
                      .handleSwipedEvent(isLeft: true),
                ),
                RaisedButton(
                  child: Text('Disable: $disable'),
                  onPressed: () {
                    setState(() {
                      disable = !disable;
                    });
                  },
                ),
                RaisedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    cardSwipeGlobalKey.currentState.add(
                        buildCardList(['assets/rem.jpg', 'assets/rem02.jpg']));
                  },
                ),
                RaisedButton(
                  child: const Text('Right'),
                  onPressed: () => cardSwipeGlobalKey.currentState
                      .handleSwipedEvent(isLeft: false),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildCardList(List<String> list) {
    return list
        .map((card) => _Card(
              card,
              key: ValueKey(card),
            ))
        .toList();
  }

  Widget animatedCardBuilder(BuildContext context, AnimationController controller, Widget child, int index) {
    return child;
  }
}

class _Card extends StatelessWidget {
  final String imageAssetName;

  _Card(this.imageAssetName, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imageAssetName,
          width: 400,
          height: 500,
          fit: BoxFit.cover,
        ));
  }
}
