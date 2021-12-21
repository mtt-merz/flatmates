import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/ui/widget/card.dart';
import 'package:flutter/material.dart';

class FlatScreen extends StatefulWidget {
  const FlatScreen({Key? key}) : super(key: key);

  @override
  _FlatScreenState createState() => _FlatScreenState();
}

class _FlatScreenState extends State<FlatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Flat Screen')),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Flat list
          StreamBuilder(
            stream: FlatRepository.instance.objectsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();

              final flats = snapshot.data as List<Flat>;
              return Column(
                children: flats
                    .map((flat) => Card(
                            child: ListTile(
                          title: Text(flat.name),
                        )))
                    .toList(),
              );
            },
          ),

          // Join an existing flat
          CardColumn(
            title: 'Join an existing flat',
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          label: Text('Invite code', textAlign: TextAlign.center),
                        )),
                  ),
                  IconButton(
                    icon: const CircleAvatar(child: Icon(Icons.arrow_right)),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('or'),
          ),

          // Insert a new flat
          ElevatedButton(
            child: const Text('Set up your flat'),
            onPressed: () => Navigator.of(context).pushNamed('set_flat').then((flat) {
              if (flat == null) return;
              FlatRepository.instance.insert(flat as Flat);
            }),
          ),
        ]),
      );
}
