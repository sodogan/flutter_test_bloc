import 'package:flutter/material.dart';
import './counter_bloc.dart';
import './number_creator.dart';
import './counter_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final _counterBloc = CounterBloc();

  void _incrementCounter() {
    setState(() => _counter++);
  }

  void _decrementCounter() {
    _counter > 0 ? setState(() => _counter--) : _counter = 0;
  }

  StreamBuilder numberCreatorStreamBuilder() {
    final _streamBuilder = StreamBuilder(
      stream: NumberCreator().dataStream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _connectionState = snapshot.connectionState;
        // if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: _connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : snapshot.hasError
                    ? const Text('Error occured')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Your current counter is:',
                          ),
                          Text(
                            '${snapshot.data}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ));
      },
    );

    return _streamBuilder;
  }

  @override
  Widget build(BuildContext context) {
    final _streamBuilder = StreamBuilder(
      stream: _counterBloc.stateOut,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _connectionState = snapshot.connectionState;
        // if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: _connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : snapshot.hasError
                    ? const Text('Error occured')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Your current counter is:',
                          ),
                          Text(
                            '${snapshot.data}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ));
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _streamBuilder,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => _counterBloc.eventSink.add(IncrementEvent()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => _counterBloc.eventSink.add(DecrementEvent()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
