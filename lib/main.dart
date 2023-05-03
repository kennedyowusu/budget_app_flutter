import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetApp());
}

class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
