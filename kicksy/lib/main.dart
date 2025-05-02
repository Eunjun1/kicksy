import 'package:flutter/material.dart';
import 'package:kicksy/view/hq/hq_main.dart';
import 'package:kicksy/view/hq/hq_order_query.dart';
import 'package:kicksy/vm/database_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HqMain(),
    );
  }
}
