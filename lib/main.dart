import 'package:expenses_app/pages/expenses.dart';
import 'package:expenses_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

// this import is for making the app always stand up and won't rotate
// import 'package:flutter/services.dart';
void main() {
  //  this code is for making the app always stand up and won't rotate
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (fn) => runApp(
  //     const ExpensesApp(),
  //   ),
  // );
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: ThemeMode.system,=> this is the default
      home: const ExpensesPage(),
    );
  }
}
