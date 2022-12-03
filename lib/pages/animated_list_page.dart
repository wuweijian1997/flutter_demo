import 'package:demo/util/index.dart';
import 'package:demo/widgets/custom_animated_list.dart';
import 'package:flutter/material.dart';

class AnimatedListDemoPage extends StatefulWidget {
  static const String rName = "AnimatedList";

  const AnimatedListDemoPage({Key? key}) : super(key: key);

  @override
  _AnimatedListDemoPageState createState() => _AnimatedListDemoPageState();
}

class _AnimatedListDemoPageState extends State<AnimatedListDemoPage> {
  final GlobalKey<CustomAnimatedListState> _listKey =
      GlobalKey<CustomAnimatedListState>();

  CustomAnimatedListState? get _animatedList => _listKey.currentState;
  List<int> list = [10, 9, 8];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      key: ValueKey(list[index]),
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
    _animatedList?.insertItem(index);
  }

  insert2() {
    setState(() {
      list = [1, 2, 3, 4, 5, 6, 7, 8];
    });
  }

  void remove(int index) {
    assert(index >= 0);
    int element = list.removeAt(index);
    _animatedList?.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            _buildRemovedItem(element, context, animation),
        duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    Log.info('length: ${list.length}', StackTrace.current);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            list = list.reversed.toList();
          });
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
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
            Card(
              child: Container(
                width: double.infinity,
                color: Colors.pink,
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  onPressed: insert2,
                ),
              ),
            ),
            Expanded(
              child: CustomAnimatedList(
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
  const CardItem({
    Key? key,
    required this.animation,
    this.onTap,
    required this.item,
  }) : super(key: key);
  final Animation<double> animation;
  final ValueChanged<int>? onTap;
  final int item;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      )),
      child: SizeTransition(
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
                  const Icon(Icons.delete),
                ],
              ),
              onPressed: () {
                onTap?.call(item);
              },
            ),
          ),
        ),
      ),
    );
  }
}
