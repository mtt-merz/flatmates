import 'package:flatmates/app/models/user.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final User user;

  const UserAvatar(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CircleAvatar(
        backgroundColor: user.color,
        radius: 17,
        child: Text(
          user.name!.substring(0, 1),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      );
}
