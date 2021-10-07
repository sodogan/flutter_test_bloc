import 'dart:async';

class NumberCreator {
  final _streamController = StreamController<int>();
  var _counter = 1;

  NumberCreator() {
    //startPeriodicCounter();
    _streamController.stream.listen(mapEventToAction);
  }
  Stream<int> get dataStream => _streamController.stream;

  StreamSink<int> get dataSink => _streamController.sink;

  void startPeriodicCounter() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _counter == 10
          ? _streamController.sink.addError('Error occurred')
          : _streamController.sink.add(_counter);
      _counter++;
    });
  }

  mapEventToAction(int value) {}

  void dispose() {
    _streamController.close();
  }
}
