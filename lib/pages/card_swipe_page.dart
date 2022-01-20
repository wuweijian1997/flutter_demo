import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class CardSwipeWidgetDemo extends StatefulWidget {
  static String rName = 'CardSwipe';

  const CardSwipeWidgetDemo({Key? key}) : super(key: key);

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
  late CardSwipeController cardSwipeController;

  @override
  void initState() {
    super.initState();
    cardSwipeController = CardSwipeController(list: buildCardList(cards));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CardSwipeDemo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardSwipe(
            disable: disable,
            key: cardSwipeGlobalKey,
            cardSwipeController: cardSwipeController,
            emptyWidget: const Center(
              child: Text('Empty'),
            ),
          ),
          Wrap(
            children: <Widget>[
              ElevatedButton(
                child: const Text('Left'),
                onPressed: () => cardSwipeGlobalKey.currentState
                    ?.handleSwipedEvent(swipeDirection: SwipeDirection.left),
              ),
              ElevatedButton(
                child: const Text('Right'),
                onPressed: () => cardSwipeGlobalKey.currentState
                    ?.handleSwipedEvent(swipeDirection: SwipeDirection.right),
              ),
              ElevatedButton(
                child: Text('Disable: $disable'),
                onPressed: () {
                  setState(() {
                    disable = !disable;
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  cardSwipeController.addAll(
                      addList: buildCardList(
                          ['assets/rem.jpg', 'assets/rem02.jpg']));
                },
              ),
              ElevatedButton(
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
    );
  }

  List<Widget> buildCardList(List<String> list) {
    List<Widget> result = [];
    for (var card in list) {
      result.add(_Card(
        card,
        key: ValueKey(card),
      ));
    }
    return result;
  }
}

class _Card extends StatelessWidget {
  final String imageAssetName;

  const _Card(this.imageAssetName, {Key? key}) : super(key: key);

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
