import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flatmates/app/ui/widget/card_column.dart';
import 'package:flatmates/app/ui/widget/card_emphasis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final cubit = GetIt.I<ProfileCubit>();

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 120,
                foregroundColor: Colors.amber,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsetsDirectional.only(start: 24, bottom: 16.0),
                  title: Row(
                    children: [
                      CircleAvatar(backgroundColor: cubit.mateColor, radius: 5),
                      const SizedBox(width: 10),
                      Text(cubit.mateName, style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () => Navigator.of(context).pushNamed('/authentication/sign_up'),
                  ),
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
                            buildPopupMenuItem(
                              content: const Text('Set color'),
                              icon: const Icon(Icons.color_lens),
                              index: 1,
                            ),
                          ]),
                ],
              ),
              SliverPadding(
                padding: SizeUtils.of(context).basePadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    CardEmphasis(
                      title: 'Register an account!',
                      subtitle:
                          'Right now, if you logout or uninstall the app, you will lose all your data',
                      onTap: () {},
                    ),
                    // const Divider(),
                    CardColumn(children: [
                      SettingTile(
                        title: const Text('Leave flat'),
                        subtitle: const Text(
                            'If there are no more mates in the flat, it will be automatically deleted'),
                        icon: const Icon(Icons.home),
                        onTap: cubit.leaveFlat,
                      ),
                      SettingTile(
                          title: const Text('Delete profile'),
                          icon: const Icon(Icons.delete),
                          onTap: cubit.deleteAccount),
                    ])
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
      child: Row(children: children),
      value: index,
    );
  }
}

class SettingTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Icon? icon;
  final void Function() onTap;

  const SettingTile({Key? key, required this.title, this.subtitle, this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      isThreeLine: subtitle != null,
      leading: icon,
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16),
      onTap: onTap,
    );
  }
}
