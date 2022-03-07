import 'package:flatmates/app/models/chore/chore.dart';
import 'package:flutter/material.dart';

class ChoresScreen extends StatefulWidget {
  const ChoresScreen({Key? key}) : super(key: key);

  @override
  _ChoresScreenState createState() => _ChoresScreenState();
}


class _ChoresScreenState extends State<ChoresScreen> {
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
