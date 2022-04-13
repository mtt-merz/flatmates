import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/ui/screens/flat/flat_common_space_widget.dart';
import 'package:flatmates/app/ui/screens/flat/flat_common_spaces_setter_dialog.dart';
import 'package:flatmates/app/ui/screens/flat/flat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlatScreen extends StatefulWidget {
  const FlatScreen({Key? key}) : super(key: key);

  @override
  _FlatScreenState createState() => _FlatScreenState();
}

class _FlatScreenState extends State<FlatScreen> {
  final FlatCubit cubit = FlatCubit();
  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('My Flat'),
          actions: [
            BlocBuilder(
                bloc: cubit,
                builder: (context, state) {
                  if (state is Loading) return const CircularProgressIndicator();
                  if (state is Updated)
                    return TextButton(
                      child: const Text('Save'),
                      onPressed: () => cubit.save(),
                    );

                  return const SizedBox();
                })
          ],
        ),
        backgroundColor: Theme.of(context).cardColor,
        body: BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is Loading) return const Center(child: CircularProgressIndicator());

              assert(state is Show);
              final flat = (state as Show).flat;

              if (flat.name != null) titleController.text = flat.name!;

              return ListView(
                shrinkWrap: true,
                children: [
                  // Name
                  Card(
                    child: Text('NAME', style: Theme.of(context).textTheme.caption),
                  ),
                  ListTile(
                    title: TextField(
                      controller: titleController,
                      onChanged: (value) => cubit.setName(value),
                    ),
                  ),

                  // Mates
                  const Divider(),
                  ListTile(
                    title: Text('MATES', style: Theme.of(context).textTheme.caption),
                    trailing: TextButton(
                      child: const Text('Add'),
                      onPressed: () {},
                    ),
                    dense: true,
                  ),

                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 28,
                    children: flat.mates.map<Widget>((mate) => Text(mate.name)).toList(),
                  ),

                  // Common spaces
                  const Divider(),
                  Card(
                    child: Text('COMMON SPACES', style: Theme.of(context).textTheme.caption),
                  ),
                  Column(
                    children: flat.commonSpaces.isNotEmpty
                        ? flat.commonSpaces
                            .map((e) => CommonSpaceWidget(title: e.name, backgroundColor: e.color))
                            .toList()
                        : [const Card(child: Text('No common spaces specified yet'))],
                  ),

                  // Add common spaces button
                  Padding(
                    padding: Theme.of(context).cardTheme.margin!,
                    child: OutlinedButton(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                        Icon(Icons.add),
                        SizedBox(width: 10),
                        Text('Add common spaces'),
                      ]),
                      onPressed: () => showDialog<List<CommonSpace>?>(
                              context: context,
                              builder: (context) => SetCommonSpacesDialog(flat.commonSpaces))
                          .then((commonSpaces) => cubit.setCommonSpaces(commonSpaces)),
                    ),
                  )
                ],
              );
            }),
      );
}
