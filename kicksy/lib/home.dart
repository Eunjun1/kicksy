import 'package:flutter/material.dart';
import 'package:team_project_5_2/vm/database_handler_1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHandler handler = DatabaseHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () => handler.insertEmployee(), 
          child: Text('111')
        ),
      ),
    );
  }
}