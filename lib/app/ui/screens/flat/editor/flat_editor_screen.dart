import 'package:flatmates/app/models/flat/common_space/common_space.dart';
import 'package:flatmates/app/ui/theme.dart';
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
  final cubit = SetFlatCubit();
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
      builder: (context, SetFlatState state) {
        final flat = state.flat;
        return ScreenTemplate(
          title: 'Your flat',
          subtitle: 'Here you can find and edit the info related to your flat.',
          footer: state.hasChanges
              ? SubmitButton(
                  onPressed: () =>
                      cubit.save().then((_) => Navigator.of(context).pop()),
                  child: const Text('SAVE'),
                )
              : null,
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

            // Invitation code
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
              child: flat.commonSpaces.isEmpty
                  ? const Text('No common spaces specified yet')
                  : GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      childAspectRatio: 21 / 9,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: flat.commonSpaces
                          .map((commonSpace) => CommonSpaceWidget(
                                commonSpace,
                                onToggle: () =>
                                    cubit.toggleCommonSpace(commonSpace),
                              ))
                          .toList()),
            ),
          ],
        );
      });
}

class CommonSpaceWidget extends StatelessWidget {
  final CommonSpace commonSpace;
  final VoidCallback onToggle;

  const CommonSpaceWidget(this.commonSpace, {Key? key, required this.onToggle})
      : super(key: key);

  Color get contentColor => ColorUtils(commonSpace.color).textColor;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: commonSpace.color,
            borderRadius: BorderRadius.all(
                Radius.circular(CustomThemeData().fieldRadius))),
        child: ListTile(
          onTap: onToggle,
          title: Text(commonSpace.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: contentColor)),
        ),
      );
}
