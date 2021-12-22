import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class InitUserScreen extends StatefulWidget {
  const InitUserScreen({Key? key}) : super(key: key);

  @override
  State<InitUserScreen> createState() => _InitUserScreenState();
}

class _InitUserScreenState extends State<InitUserScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What\' your name?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  autofocus: true,
                  style: Theme.of(context).textTheme.headline5,
                  keyboardType: TextInputType.name,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  child: const Text('Ok'),
                  onPressed: controller.value.text.isEmpty ? null : submit,
                )
              ],
            )),
      );

  void submit() {
    final user = UserRepository.instance.user..name = controller.text;
    UserRepository.instance.update(user);

    FocusScope.of(context).unfocus();
  }
}
