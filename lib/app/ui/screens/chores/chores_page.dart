import 'package:flatmates/app/ui/screens/chores/chores_cubit.dart';
import 'package:flatmates/app/ui/widget/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoresPage extends StatefulWidget {
  const ChoresPage({Key? key}) : super(key: key);

  @override
  _ChoresPageState createState() => _ChoresPageState();
}

class _ChoresPageState extends State<ChoresPage> {
  final cubit = ChoresCubit();

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is Loading)
          return const Center(child: CircularProgressIndicator());

        final chores = (state as Loaded).chores;
        return PageTemplate(
          title: 'Chores',
          onRefresh: cubit.refresh,
          children: chores
              .map((chore) => Card(
                    child: ListTile(
                      leading:
                          const CircleAvatar(child: Icon(Icons.adb_outlined)),
                      title: Text(chore.title),
                    ),
                  ))
              .toList(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
        );
      });
}
