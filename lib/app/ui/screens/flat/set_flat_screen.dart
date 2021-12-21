import 'package:flatmates/app/models/flat.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/ui/widget/card.dart';
import 'package:flutter/material.dart';

class SetFlatScreen extends StatefulWidget {
  final Flat? flat;

  const SetFlatScreen(this.flat, {Key? key}) : super(key: key);

  @override
  _SetFlatScreenState createState() => _SetFlatScreenState();
}

class _SetFlatScreenState extends State<SetFlatScreen> {
  late final PageController pageController;

  List<String> commonSpaceSet = ['bathroom', 'kitchen', 'corridor'];

  FlatRole? role;
  late final TextEditingController nameController;
  List<String> commonSpaces = ['bathroom', 'kitchen'];

  @override
  void initState() {
    super.initState();

    pageController = PageController();
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

  Widget get setRoleWidget => Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () => setState(() => role = FlatRole.owner),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      child: Center(
                          child: Text('I\'m the owner',
                              style: Theme.of(context).textTheme.headline5)),
                    ),
                  )),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () => setState(() => role = FlatRole.mate),
                    child: Card(
                      color: Colors.lightGreen,
                      child: Center(
                          child: Text('I\'m a mate',
                              style: Theme.of(context).textTheme.headline5)),
                    ),
                  )),
            ]),
      );

  @override
  Widget build(BuildContext context) {
    if (role != null) pageController.jumpToPage(1);
    return Scaffold(
      body:
          PageView(allowImplicitScrolling: false, controller: pageController, children: [
        // Choose the role of the user
        setRoleWidget,

        // Set other info
        Scaffold(
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
      ]),
    );
  }

  void submit() => Navigator.of(context).pop(Flat(
        nameController.value.text,
        role: role!,
        userId: UserRepository.instance.user.id,
      ));
}
