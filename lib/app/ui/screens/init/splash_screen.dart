import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
    this.message,
    this.action = const CircularProgressIndicator(),
  }) : super(key: key);

  final String? message;
  final Widget action;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            const Icon(Icons.home, size: 90),
            message == null
                ? const SizedBox()
                : Positioned(
                    bottom: MediaQuery.of(context).size.height / 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [action, const SizedBox(height: 20), Text(message!)],
                    ),
                  )
          ],
        ),
      );
}
