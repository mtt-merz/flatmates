import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'initialize_flat_cubit.dart';

part '_join_flat_page.dart';

part '_set_username_page.dart';

class InitializeFlatScreen extends StatelessWidget {
  InitializeFlatScreen({Key? key}) : super(key: key);

  final cubit = GetIt.I<InitializeFlatCubit>();
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder(
            bloc: cubit,
            builder: (context, AsyncSnapshot<FlatState> snapshot) {
              if (!snapshot.hasData) return const SplashScreen();
              switch (snapshot.data!) {
                case FlatState.regular:
                  return const MainScreen();
                case FlatState.notFound:
                  return _SetFlatPage(onJoinFlat: cubit.joinFlat, onCreateFlat: cubit.createFlat);
                case FlatState.joining:
                case FlatState.generating:
                  return _SetUsernamePage(onUsernameSet: cubit.setUsername);
              }
            }),
      );
}
