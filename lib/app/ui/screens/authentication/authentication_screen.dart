import 'package:flatmates/app/ui/screens/authentication/authentication_cubit.dart';
import 'package:flatmates/app/ui/screens/flat/init/initialize_flat_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({Key? key}) : super(key: key);

  final cubit = AuthenticationCubit();

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) return const SplashScreen();

        final authenticated = snapshot.data!;
        if (authenticated) return InitializeFlatScreen();

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Padding(
            padding: SizeUtils.of(context).screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                const Expanded(child: Icon(Icons.star)),

                // Sign in Anonymously button
                ElevatedButton(
                  child: const SizedBox(
                      width: double.infinity, child: Text('START', textAlign: TextAlign.center)),
                  onPressed: cubit.signInAnonymously,
                ),

                // Sign in button
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Already have an profile?'),
                  TextButton(
                    child: const Text('Login'),
                    onPressed: cubit.signIn,
                  ),
                ])
              ],
            ),
          ),
        );
      });
}
