import 'package:flatmates/app/ui/utils/color_utils.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/mate_chip.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'flat_editor_cubit.dart';

class FlatEditorScreen extends StatefulWidget {
  const FlatEditorScreen({Key? key}) : super(key: key);

  @override
  State<FlatEditorScreen> createState() => _FlatEditorScreenState();
}

class _FlatEditorScreenState extends State<FlatEditorScreen> {
  final cubit = FlatEditorCubit();
  late final TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
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
        final flat = (state as Editing).flat;

        return ScreenTemplate(
          title: 'Edit flat',
          subtitle: 'Here you can set the info related to your flat',
          footer: SubmitButton(
            onPressed: () {},
            child: const Text('SAVE'),
          ),
          children: [
            // Name
            FieldContainer(
              label: 'name',
              child: TextField(
                controller: titleController,
                decoration:
                    const InputDecoration(hintText: 'Insert your flat name'),
                textCapitalization: TextCapitalization.words,
                onChanged: cubit.setName,
              ),
            ),

            // Mates
            FieldContainer(
              label: 'mates',
              child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  children: flat.mates
                      .map<Widget>((mate) => MateChip(mate))
                      .toList()),
            ),

            FieldContainer(
              label: 'invitation code',
              child: TextField(
                  controller: TextEditingController(text: flat.invitationCode),
                  // textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: flat.invitationCode));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Code copied to clipboard')));
                        },
                        icon: const Icon(Icons.copy)),
                  ),
                  style: Theme.of(context).textTheme.headline6),
            ),

            // Common spaces
            FieldContainer(
              label: 'common spaces',
              child: Column(
                children: flat.commonSpaces.isNotEmpty
                    ? flat.commonSpaces
                        .map((e) => CommonSpaceWidget(
                            title: e.name, backgroundColor: e.color))
                        .toList()
                    : [
                        const Card(
                            child: Text('No common spaces specified yet'))
                      ],
              ),
            ),
          ],
        );
      });
}

class CommonSpaceWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final ImageProvider? image;

  const CommonSpaceWidget({
    Key? key,
    required this.title,
    required this.backgroundColor,
    this.image,
  }) : super(key: key);

  Color get contentColor => ColorUtils(backgroundColor).textColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: backgroundColor),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: backgroundColor,
          child: ListTile(
            leading: image != null
                ? SizedBox(width: MediaQuery.of(context).size.width * .25)
                : null,
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: contentColor)),
          ),
        ),
      );
}
