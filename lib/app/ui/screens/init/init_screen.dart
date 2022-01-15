import 'package:flatmates/app/blocs/init_cubit.dart';
import 'package:flatmates/app/ui/screens/init/splash_screen.dart';
import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  late final InitCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = InitCubit();
  }

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
        if (state is Running) return const MainScreen();

        assert(state is ShouldInitializeFlat);
        return Scaffold(
            body: Center(
          child: ElevatedButton(
            child: const Text('Create flat'),
            onPressed: () => cubit.createFlat(),
          ),
        ));
      });

// Widget presentationPage(int counter) => Center(
//       child: Text('Presentation page #$counter'),
//     );
}
