import 'package:demo/bloc/event/counter_event.dart';
import 'package:demo/bloc/state/counter_state.dart';
import 'package:demo/util/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial());

  onIncrement() {
    add(IncrementEvent());
  }

  onDecrement() {
    add(DecrementEvent());
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    Log.info('event: $event', StackTrace.current);
    if (event is IncrementEvent) {
      yield state..counter += 1;
    } else if (event is DecrementEvent) {
      yield state..counter -= 1;
    }
  }
}
