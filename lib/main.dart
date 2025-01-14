import 'package:flutter/material.dart';
import 'package:flutter_project/valueListennotifer/counter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterStateless(),
    );
  }
}
