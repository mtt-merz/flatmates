import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flatmates/app/ui/screens/splash_screen.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flatmates/app/ui/widget/text_input_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'flat_init_cubit.dart';

part 'create_flat_page.dart';

part 'join_flat_page.dart';

class FlatInitScreen extends StatelessWidget {
  FlatInitScreen({Key? key}) : super(key: key);

  final cubit = GetIt.I<FlatInitCubit>();
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) return const SplashScreen();
        if (snapshot.data!) return const MainScreen();

        // Flat not yet initialized
        return Scaffold(
          body: PageView(
            controller: controller,
            // scrollDirection: Axis.vertical,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              JoinFlatPage(onJoinFlat: cubit.joinFlat, onCreateFlat: cubit.createFlat),
              // () => controller.nextPage(
              // duration: const Duration(milliseconds: 200), curve: Curves.decelerate)),
              _CreateFlatPage(cubit),
            ],
          ),
        );
      });
}
