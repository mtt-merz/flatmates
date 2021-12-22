import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flatmates/app/services/authentication_service.dart';
import 'package:flatmates/app/ui/screens/chores/chores_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/add_expense_dialog.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_screen.dart';
import 'package:flatmates/app/ui/screens/flat/flat_screen.dart';
import 'package:flatmates/app/ui/screens/flat/set_flat_screen.dart';
import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flatmates/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() async {
  // De-comment this for a better logging granularity (the default is INFO)
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) => log(event.message,
      name: event.loggerName, error: event.error, stackTrace: event.stackTrace));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: CustomThemeData().theme,
        routes: {
          'flat': (_) => const FlatScreen(),
          'set_flat': (_) => const SetFlatScreen(null),
          'expenses': (_) => const ExpensesScreen(),
          'set_expense': (_) => const AddExpenseDialog(),
          'chores': (_) => const ChoresScreen(),
        },
        home: const MainScreen(),
      );
}
