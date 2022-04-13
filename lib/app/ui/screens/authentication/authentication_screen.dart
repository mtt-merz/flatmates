import 'package:flatmates/app/ui/screens/authentication/authentication_cubit.dart';
import 'package:flatmates/app/ui/screens/init/init_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final cubit = Locator.get<AuthenticationCubit>();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is Loading) return const SplashScreen();
        if (state is Authenticated) return const InitScreen();

        if (state is! NotAuthenticated) throw Exception();
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
                  SubmitButton(
                    onPressed: cubit.signInAnonymously,
                    loading: state.isLoading,
                    child: const Text('START'),
                  ),

                  // Sign in button
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('You already have an account?'),
                    TextButton(
                      child: const Text('Login'),
                      onPressed: () => Navigator.of(context)
                          .pushNamed('/authentication/sign_in')
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('You\'re logged in')))),
                    ),
                  ])
                ],
              )),
        );
      });
}
