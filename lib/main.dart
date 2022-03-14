import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flatmates/app/ui/router.dart';
import 'package:flatmates/app/ui/screens/authentication/authentication_screen.dart';
import 'package:flatmates/app/ui/theme.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

void main() async {
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) =>
      log(event.message, name: event.loggerName, error: event.error, stackTrace: event.stackTrace));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Locator.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: CustomThemeData().theme,
        onGenerateRoute: CustomRouter.onGenerateRoute,
        home: AuthenticationScreen(),
      );
}
