import 'package:flatmates/app/blocs/auth_cubit.dart';
import 'package:flatmates/app/ui/screens/init/init_screen.dart';
import 'package:flatmates/app/ui/screens/init/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthenticationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AuthenticationCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is Loading) return const SplashScreen();
          if (state is Authenticated) return const InitScreen();

          assert(state is NotAuthenticated);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Welcome to Flatmates :)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    child: const Text('Start'),
                    onPressed: () => cubit.signInAnonymously(),
                  ),
                  TextButton(
                    child: const Text('login'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        });
  }
}
