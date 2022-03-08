import 'package:flatmates/app/ui/screens/expenses/add_expense_dialog/add_expense_dialog.dart';
import 'package:flatmates/app/ui/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  final cubit = GetIt.I<HomeCubit>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
              title: Text(cubit.flatName),
              pinned: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 150,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => cubit.logout(),
                )
              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Card(
                child: ListTile(
                  title: const Text('Expenses'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => showDialog(
                        context: context, builder: (context) => const AddExpenseDialog()),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/expenses'),
                ),
              ),
            ]))
          ]),
        );
      });
}
