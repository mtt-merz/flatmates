import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/ui/screens/flat/flat_common_space_widget.dart';
import 'package:flatmates/app/ui/screens/flat/flat_common_spaces_setter_dialog.dart';
import 'package:flatmates/app/ui/utils/color_utils.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/mate_chip.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'flat_editor_cubit.dart';

import 'package:flutter/services.dart';

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
      builder: (context, Flat? flat) {
        if (flat == null)
          return const Center(child: CircularProgressIndicator());

        return ScreenTemplate(
          title: 'Edit flat',
          subtitle: 'Here you can set the info related to your flat',
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

            // Add common spaces button
            Padding(
              padding: Theme.of(context).cardTheme.margin!,
              child: OutlinedButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text('Add common spaces'),
                    ]),
                onPressed: () => showDialog<List<CommonSpace>?>(
                    context: context,
                    builder: (context) =>
                        SetCommonSpacesDialog(flat.commonSpaces)).then(
                    (commonSpaces) => cubit.setCommonSpaces(commonSpaces)),
              ),
            )
          ],
        );
      });
}
