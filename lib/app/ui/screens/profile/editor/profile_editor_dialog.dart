import 'package:flatmates/app/ui/screens/profile/editor/profile_editor_cubit.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../models/flat/mate/mate.dart';

class ProfileEditorDialog extends StatefulWidget {
  const ProfileEditorDialog({Key? key}) : super(key: key);

  @override
  State<ProfileEditorDialog> createState() => _ProfileEditorDialogState();
}

class _ProfileEditorDialogState extends State<ProfileEditorDialog> {
  final cubit = GetIt.I<ProfileEditorCubit>();

  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, Mate mate) {
        return FormDialog(
          title: 'Profile',
          onSubmit: () => Navigator.of(context).pop(),
          children: [
            // Username
            FieldContainer(
              label: 'name',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Insert your name'),
                controller: controller,
                textCapitalization: TextCapitalization.words,
              ),
            ),

            // Color
            FieldContainer(
              label: 'COLOR',
              child: SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                        children: cubit.availableColors
                            .map<Widget>((color) => IconButton(
                                  constraints: BoxConstraints.tight(
                                      Size.square(color.value == mate.colorValue ? 70 : 50)),
                                  icon: ClipOval(child: Container(color: color)),
                                  onPressed: () => cubit.setColor(color),
                                ))
                            .toList())
                  ],
                ),
              ),
            )
          ],
        );
      });
}
