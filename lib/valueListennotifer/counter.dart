import 'package:flutter/material.dart';

class CounterStateless extends StatelessWidget {
  CounterStateless({super.key});
  // int count = 0;
  final ValueNotifier<int> counter = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      body: Center(
          child: SizedBox(
        height: 500,
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                counter.value += 1;
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                if (counter.value > 0) {
                  counter.value -= 1;
                }
              },
              icon: Icon(Icons.remove),
            ),
            ValueListenableBuilder(
                valueListenable: counter,
                builder: (BuildContext context, int value, Widget? child) {
                  return Text(counter.value.toString());
                })
          ],
        ),
      )),
    );
  }
}
