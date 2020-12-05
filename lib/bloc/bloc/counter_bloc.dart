import 'package:demo/bloc/event/counter_event.dart';
import 'package:demo/bloc/state/counter_state.dart';
import 'package:demo/util/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  onIncrement() {
    add(IncrementEvent());
  }

  onDecrement() {
    add(DecrementEvent());
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    Log.info('event: $event', StackTrace.current);
    if (event is IncrementEvent) {
      yield state + 1;
    } else if (event is DecrementEvent) {
      yield state - 1;
    }
  }
}