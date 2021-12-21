import 'package:flatmates/app/services/authentication_service.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => AuthenticationService.instance.signInAnonymously(),
            ),
            TextButton(
              child: const Text('login'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
