import 'package:flatmates/app/ui/screens/authentication/authentication_cubit.dart';
import 'package:flatmates/app/ui/screens/init/init_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flatmates/app/ui/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({Key? key}) : super(key: key);

  final cubit = GetIt.I<AuthenticationCubit>();

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is Loading) return const SplashScreen();
        if (state is Authenticated) return const InitScreen();

        assert(state is NotAuthenticated);
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
                LoadingElevatedButton(
                  loading: (state as NotAuthenticated).isLoading,
                  child: const SizedBox(
                      width: double.infinity, child: Text('START', textAlign: TextAlign.center)),
                  onPressed: cubit.signInAnonymously,
                ),

                // Sign in button
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Already have an account?'),
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
