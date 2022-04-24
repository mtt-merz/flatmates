import 'package:flatmates/app/ui/screens/settings/settings_cubit.dart';
import 'package:flatmates/app/ui/widget/card_column.dart';
import 'package:flutter/material.dart';

class AccountSettingsPanel extends StatelessWidget {
  final cubit = SettingsCubit();

  AccountSettingsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CardColumn(children: [
        SettingTile(
          title: const Text('Sign out'),
          icon: const Icon(Icons.logout),
          onTap: cubit.signOut,
        ),
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
            onTap: () => cubit.deleteAccount(
                  onRequiresRecentLogin: () => Navigator.of(context)
                      .pushNamed('/authentication/check')
                      .then((value) => value as bool),
                )),
      ]);
}

class SettingTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Icon? icon;
  final void Function() onTap;

  const SettingTile(
      {Key? key,
      required this.title,
      this.subtitle,
      this.icon,
      required this.onTap})
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
