import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CardSwipeWidgetDemo extends StatefulWidget {
  static String rName = 'card_swipe_widget';

  @override
  _CardSwipeDemoState createState() => _CardSwipeDemoState();
}

class _CardSwipeDemoState extends State<CardSwipeWidgetDemo> {
  final cards = [
    'assets/eat_cape_town_sm.jpg',
    'assets/eat_new_orleans_sm.jpg',
    'assets/eat_sydney_sm.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CardSwipeDemo'),
      ),
      body: Container(
        child: Column(
          children: [
            CardSwipe(
              key: cardSwipeGlobalKey,
              children: [for (String card in cards) _Card(card)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: const Text('左滑'),
                  onPressed: () => cardSwipeGlobalKey.currentState.handleSwipedEvent(true),
                ),
                RaisedButton(
                  child: const Text('右滑'),
                  onPressed: () => cardSwipeGlobalKey.currentState.handleSwipedEvent(false),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String imageAssetName;

  _Card(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(imageAssetName),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
