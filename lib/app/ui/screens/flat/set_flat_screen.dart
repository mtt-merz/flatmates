import 'package:flatmates/app/models/flat.dart';
import 'package:flatmates/app/ui/widget/card.dart';
import 'package:flutter/material.dart';

class SetFlatScreen extends StatefulWidget {
  final Flat? flat;

  const SetFlatScreen(this.flat, {Key? key}) : super(key: key);

  @override
  _SetFlatScreenState createState() => _SetFlatScreenState();
}

class _SetFlatScreenState extends State<SetFlatScreen> {
  List<String> commonSpaceSet = ['bathroom', 'kitchen', 'corridor'];

  late final TextEditingController nameController;
  List<String> commonSpaces = ['bathroom', 'kitchen'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  void didUpdateWidget(covariant SetFlatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
          appBar: AppBar(title: const Text('Set other info')),
          body: ListView(children: [
            // Name card
            Card(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(label: Text('Name')),
                      keyboardType: TextInputType.name,
                    ))),

            // Photo card
            CardColumn(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 5.0),
                Text('Add image'),
              ])
            ]),

            // Common spaces card
            CardColumn(
              title: 'Common spaces',
              children: [
                Wrap(
                  children: commonSpaceSet
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InputChip(
                              label: Text(e),
                              visualDensity: VisualDensity.comfortable,
                              selected: commonSpaces.contains(e),
                              onSelected: (selected) => setState(() => selected
                                  ? commonSpaces.add(e)
                                  : commonSpaces.remove(e)),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),

            // Address card
            CardColumn(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 5.0),
                Text('Add address'),
              ])
            ]),
          ]),
          persistentFooterButtons: [
            OutlinedButton(
              child: const Text('Cancel'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: nameController.value.text.isEmpty ? null : submit,
            ),
          ],
        ),
      );

  // TODO: persist the flat
  void submit() => Navigator.of(context).pop();
}
