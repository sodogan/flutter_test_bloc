import 'dart:async';

import 'package:test_bloc/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _stateController = StreamController<int>();

  get stateOut {
    return _stateController.stream;
  }

  final _eventController = StreamController<CounterEvent>();

  StreamSink<CounterEvent> get eventSink {
    return _eventController.sink;
  }

  CounterBloc() {
    _eventController.stream.listen(mapEventToState);
  }

  mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _stateController.sink.add(_counter);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
