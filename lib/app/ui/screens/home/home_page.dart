import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-vector/colorful-palm-silhouettes-background_23-2148541792.jpg?size=626&ext=jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ))),
            CustomScrollView(slivers: [
              SliverAppBar(
                title: StreamBuilder(
                    stream: FlatRepository.instance.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox();

                      final flat = snapshot.data as Flat;
                      return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed('/flat', arguments: flat),
                          child: Text(flat.name ?? 'My flat'));
                    }),
                pinned: true,
                // collapsedHeight: 100,
                backgroundColor: Colors.transparent,
                expandedHeight: 150,
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Card(
                  child: ListTile(
                    title: const Text('Your next chores'),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () => Navigator.of(context).pushNamed('chores'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Shopping list'),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () => Navigator.of(context).pushNamed('chores'),
                  ),
                ),
              ]))
            ]),
          ],
        ),
      );

  bool showBottom = false;
}
