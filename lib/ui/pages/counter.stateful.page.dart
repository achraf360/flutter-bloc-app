import 'package:flutter/material.dart';

import '../theme/themes.dart';
import '../widgets/main.drawer.widget.dart';

class CounterStatefulPage extends StatefulWidget {
  const CounterStatefulPage({super.key});

  @override
  State<CounterStatefulPage> createState() => _CounterStatefulPageState();
}

class _CounterStatefulPageState extends State<CounterStatefulPage> {
  int counter = 0;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Counter Stateful",
          style: TextStyle(color: Theme.of(context).indicatorColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Counter Value : $counter",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          (errorMessage != '')
              ? Text(
                  errorMessage,
                  style: CustomThemes.errorTextStyle,
                )
              : const Text("")
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "dec",
            onPressed: () {
              setState(() {
                if (counter > 0) {
                  --counter;
                  errorMessage = "";
                } else {
                  errorMessage = "Counter value cannot be less than 0";
                }
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "inc",
            onPressed: () {
              setState(() {
                if (counter < 10) {
                  ++counter;
                  errorMessage = "";
                } else {
                  errorMessage = "Counter value cannot exceed 10";
                }
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
