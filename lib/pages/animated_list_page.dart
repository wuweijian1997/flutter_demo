import 'package:flutter/material.dart';

class AnimatedListDemoPage extends StatefulWidget {
  static const String rName = "customAnimatedList";

  @override
  _AnimatedListDemoPageState createState() => _AnimatedListDemoPageState();
}

class _AnimatedListDemoPageState extends State<AnimatedListDemoPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  AnimatedListState get _animatedList => _listKey.currentState;
  List<int> list = [10, 9, 8];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: list[index],
      onTap: (int item) {
        remove(list.indexOf(item));
      },
    );
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
    );
  }

  insert() {
    int index = list.length;
    list.insert(index, 100 + list.length);
    _animatedList.insertItem(index);
  }

  void remove(int index) {
    assert(index != null && index >= 0);
    int element = list.removeAt(index);
    if (element != null) {
      _animatedList.removeItem(
        index,
            (BuildContext context, Animation<double> animation) =>
            _buildRemovedItem(element, context, animation),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                width: double.infinity,
                color: Colors.pink,
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  onPressed: insert,
                ),
              ),
            ),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: list.length,
                itemBuilder: _buildItem,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key, @required this.animation, this.onTap, @required this.item})
      : assert(animation != null),
        assert(item != null && item >= 0),
        super(key: key);
  final Animation<double> animation;
  final ValueChanged<int> onTap;
  final int item;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: Offset(1, 1),
        end: Offset.zero,
      )),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: Card(
          child: Container(
            width: double.infinity,
            color: Colors.primaries[item % Colors.primaries.length],
            child: IconButton(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('$item'),
                  Icon(Icons.delete),
                ],
              ),
              onPressed: () {
                onTap.call(item);
              },
            ),
          ),
        ),
      ),
    );
  }
}
