import 'package:flatmates/app/models/chore/chore.dart';
import 'package:flutter/material.dart';

class ChoresPage extends StatefulWidget {
  const ChoresPage({Key? key}) : super(key: key);

  @override
  _ChoresPageState createState() => _ChoresPageState();
}


class _ChoresPageState extends State<ChoresPage> {
  List<Chore> chores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chores'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: chores
            .map((chore) => Card(
                  child: ListTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.adb_outlined)),
                    title: Text(chore.title),
                  ),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
