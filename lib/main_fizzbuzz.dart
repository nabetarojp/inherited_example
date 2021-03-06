import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  var _count = 1;

  @override
  Widget build(BuildContext context) {
    return _Inherited(
      message: _createMessage(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => setState(() => _count++),
        ),
        body: const Center(
          child: _Message(),
        ),
      ),
    );
  }

  String _createMessage() {
    final result = _count % 15 == 0
        ? 'FizzBuzz'
        : (_count % 3 == 0 ? 'Fizz' : (_count % 5 == 0 ? 'Buzz' : '-'));
    print('_count: $_count, result: $result');
    return result;
  }
}

class _Message extends StatelessWidget {
  const _Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('_Message: rebuild');
    return Text(
      'Message: ${_Inherited.of(
        context,
        // 変更監視する
        listen: true,
      )!.message}',
      style: const TextStyle(fontSize: 64),
    );
  }
}

class _Inherited extends InheritedWidget {
  const _Inherited({
    Key? key,
    required this.message,
    required Widget child,
  }) : super(key: key, child: child);

  final String message;

  static _Inherited? of(
    BuildContext context, {
    required bool listen,
  }) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<_Inherited>()
        : context.getElementForInheritedWidgetOfExactType<_Inherited>()!.widget
            as _Inherited;
  }

  @override
  bool updateShouldNotify(_Inherited old) => message != old.message;
}
