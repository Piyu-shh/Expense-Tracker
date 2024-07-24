import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
// Make sure to import your ExpenseData class
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => ExpenseData()), // Add ExpenseData provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
