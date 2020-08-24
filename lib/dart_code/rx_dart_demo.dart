import 'package:rxdart/rxdart.dart';

void main(List<String> arguments) {
/*  int n = 10;
  const seed = IndexedPair(1, 1, 0);
  Rx.range(1, n)
  .scan((accumulated, value, index) => (IndexedPair.next(accumulated)), seed)
  .listen(print, onDone: () => print('down'));*/

  List<int> intList = [1, 12, 99, 105, 78];
  Stream.fromIterable(intList).scan((accumulated, value, index) => accumulated + value, 0).doOnData((event) {
    print(event);
  });

}

class IndexedPair {
  final int n1, n2, index;

  const IndexedPair(this.n1, this.n2, this.index);

  factory IndexedPair.next(IndexedPair prev) => IndexedPair(prev.n2, prev.index <= 1 ? prev.n1 : prev.n1 + prev.n2, prev.index + 1);

  @override
  String toString() => '$index: $n2';
}
