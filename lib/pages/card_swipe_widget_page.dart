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

  bool disable = false;

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
              disable: disable,
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
            ),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  child: const Text('Left'),
                  onPressed: () => cardSwipeGlobalKey.currentState.handleSwipedEvent(true),
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
                    setState(() {
                      cards.add('assets/rem.jpg');
                      cards.add('assets/rem02.jpg');
                    });
                  },
                ),
                RaisedButton(
                  child: const Text('Right'),
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

  _Card(this.imageAssetName, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
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
