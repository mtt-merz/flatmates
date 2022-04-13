import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'init_cubit.dart';

part '_set_flat_page.dart';

part '_set_name_page.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final cubit = InitCubit();

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

        if (state is ShouldInitializeFlat)
          return _SetFlatPage(
            onJoinFlat: cubit.joinFlat,
            onCreateFlat: cubit.createFlat,
            hasError: state.hasError,
          );

        if (state is ShouldSetName)
          return _SetNamePage(
            setName: cubit.setName,
            hasError: state.hasError,
            isLoading: state.isLoading,
          );

        assert(state is Initialized);
        return const MainScreen();
      });
}
