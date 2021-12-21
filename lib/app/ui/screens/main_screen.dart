import 'package:flatmates/app/ui/screens/authentication_screen.dart';
import 'package:flatmates/app/ui/screens/flat/flat_screen.dart';
import 'package:flatmates/app/ui/screens/home_screen.dart';
import 'package:flatmates/app/ui/screens/initialize_user_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthenticationService.instance.onAuthEvent,
        builder: (context, snapshot) {
          if (snapshot.hasError) return SplashScreen(message: snapshot.error.toString());
          if (!snapshot.hasData) return const SplashScreen();

          final authenticated = snapshot.data as bool;
          if (!authenticated) return const AuthenticationScreen();

          // User authenticated
          return StreamBuilder(
            stream: UserRepository.instance.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return SplashScreen(message: snapshot.error.toString());
              if (!snapshot.hasData) return const SplashScreen();

              final user = snapshot.data as User;
              if (user.name == null) return const InitUserScreen();
              if (user.flat == null) return const FlatScreen();

              return FutureBuilder(
                  future: loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return const SplashScreen();

                    return const HomeScreen();
                  });
            },
          );
        });
  }

  Future<void> loadData() async {
    await FlatRepository.instance.mainFlatStream.first;
    await ExpenseRepository.instance.objectsStream.first;
  }
}
