import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CardSwipeWidgetDemo extends StatefulWidget {
  static String rName = 'CardSwipe';

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
  GlobalKey<CardSwipeState> cardSwipeGlobalKey = GlobalKey();
  CardSwipeController cardSwipeController;

  @override
  void initState() {
    super.initState();
    cardSwipeController = CardSwipeController(list: buildCardList(cards));
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
              key: cardSwipeGlobalKey,
              cardSwipeController: cardSwipeController,
              emptyWidget: Center(
                child: Text('Empty'),
              ),
            ),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  child: const Text('Left'),
                  onPressed: () => cardSwipeGlobalKey.currentState
                      .handleSwipedEvent(swipeDirection: SwipeDirection.left),
                ),
                RaisedButton(
                  child: const Text('Right'),
                  onPressed: () => cardSwipeGlobalKey.currentState
                      .handleSwipedEvent(swipeDirection: SwipeDirection.right),
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
                    cardSwipeController.addAll(
                        addList: buildCardList(
                            ['assets/rem.jpg', 'assets/rem02.jpg']));
                  },
                ),
                RaisedButton(
                  child: const Text('rollback'),
                  onPressed: () {
                    // cardSwipeController.rollbackBySwipeDirection();
                    cardSwipeController.rollback(count: 10);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildCardList(List<String> list) {
    List<Widget> result = [];
    list.forEach((card) {
      result.add(_Card(
        card,
        key: ValueKey(card),
      ));
    });
    return result;
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
