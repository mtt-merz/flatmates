import 'package:flatmates/app/ui/settings/account/account_settings_panel.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flatmates/app/ui/widget/card_emphasis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final cubit = ProfileCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is! Ready) return const Center(child: CircularProgressIndicator());

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsetsDirectional.only(start: 24, bottom: 16.0),
                  title: Row(
                    children: [
                      CircleAvatar(backgroundColor: cubit.mateColor, radius: 5),
                      const SizedBox(width: 10),
                      Text('${cubit.mateName} ${cubit.mateSurname}',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                actions: [
                  PopupMenuButton<int>(
                      onSelected: (int index) {
                        switch (index) {
                          case 0:
                            Navigator.of(context).pushNamed('/profile/editor');
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<int>>[
                            buildPopupMenuItem(
                              content: const Text('Edit profile'),
                              icon: const Icon(Icons.edit),
                              index: 0,
                            ),
                            // buildPopupMenuItem(
                            //   content: const Text('Set color'),
                            //   icon: const Icon(Icons.color_lens),
                            //   index: 1,
                            // ),
                          ]),
                ],
              ),
              SliverPadding(
                padding: SizeUtils.of(context).listScreenPadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    if (cubit.userIsAnonymous)
                      CardEmphasis(
                        title: 'Register an account!',
                        subtitle: 'Right now, if you logout or uninstall the app'
                            ' you will lose all your data',
                        image: Image.asset('assets/images/marketing_1.png'),
                        onTap: () => Navigator.of(context).pushNamed('/authentication/sign_up'),
                      ),

                    // Settings
                    AccountSettingsPanel(),
                  ]),
                ),
              )
            ],
          ),
        );
      });

  PopupMenuEntry<int> buildPopupMenuItem({
    required Widget content,
    Icon? icon,
    required int index,
  }) {
    final List<Widget> children = [];
    if (icon != null) children.addAll([Icon(icon.icon, size: 22), const SizedBox(width: 12)]);
    children.add(content);

    return PopupMenuItem<int>(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 37,
      value: index,
      child: Row(children: children),
    );
  }
}
