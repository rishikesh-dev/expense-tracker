import 'package:expense_tracker/core/theme/pallete.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Hive.initFlutter(); // Initialize Hive with Flutter support
  Hive.registerAdapter(ExpenseModelAdapter()); // Register your model adapter
  await Hive.openBox<ExpenseModel>('expenses'); // Open the box

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: Pallete().lightTheme,
      darkTheme: Pallete().darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
