import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flatmates/app/services/authentication_service.dart';
import 'package:flatmates/app/ui/screens/chores/chores_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/set_expense_screen.dart';
import 'package:flatmates/app/ui/screens/flat/flat_screen.dart';
import 'package:flatmates/app/ui/screens/flat/set_flat_screen.dart';
import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  // De-comment this for a better logging granularity (the default is INFO)
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) => log(event.message,
      name: event.loggerName, error: event.error, stackTrace: event.stackTrace));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();

    AuthenticationService.instance.dispose();
  }

  Future<void> initializeApp() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: CustomThemeData().theme,
        routes: {
          'flat': (_) => const FlatScreen(),
          'set_flat': (_) => const SetFlatScreen(null),
          'expenses': (_) => const ExpensesScreen(),
          'set_expense': (_) => const AddExpenseScreen(),
          'chores': (_) => const ChoresScreen(),
        },
        home: FutureBuilder(
            future: initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return const SplashScreen();

              return const MainScreen();
            }),
      );
}
