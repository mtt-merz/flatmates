import 'package:flatmates/app/ui/screens/profile/editor/profile_editor_cubit.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/flat/mate/mate.dart';

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditorScreen> createState() => _ProfileEditorScreenState();
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  final cubit = ProfileEditorCubit();

  late final TextEditingController nameController;
  late final TextEditingController surnameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: cubit.mate.name);
    surnameController = TextEditingController(text: cubit.mate.surname);
  }

  @override
  void dispose() {
    super.dispose();

    cubit.close();
    nameController.dispose();
    surnameController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, Mate? mate) {
        return ScreenTemplate(
          title: 'Edit profile',
          subtitle: 'This is your account related to the current flat',
          footer: SubmitButton(
            onPressed: () => cubit.save().then((_) => Navigator.of(context).pop()),
            child: const Text('Save'),
          ),
          children: mate == null
              ? [const CircularProgressIndicator()]
              : [
                  // First name
                  FieldContainer(
                    label: 'name',
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Insert your name'),
                      textCapitalization: TextCapitalization.words,
                      onChanged: cubit.setName,
                    ),
                  ),

                  // Last name
                  FieldContainer(
                    label: 'surname',
                    child: TextField(
                      controller: surnameController,
                      decoration: const InputDecoration(hintText: 'Insert your surname (optional)'),
                      textCapitalization: TextCapitalization.words,
                      onChanged: cubit.setSurname,
                    ),
                  ),

                  // Color
                  FieldContainer(
                    label: 'color',
                    child: GridView.count(
                        crossAxisCount: 7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 5),
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        children: cubit.availableColors
                            .map((color) => IconButton(
                                  padding: EdgeInsets.all(color.value == mate.colorValue ? 0 : 8),
                                  icon: ClipOval(child: Container(color: color)),
                                  onPressed: () => cubit.setColor(color),
                                ))
                            .toList()),
                  ),
                ],
        );
      });
}
