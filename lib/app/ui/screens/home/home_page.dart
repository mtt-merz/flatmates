import 'package:flatmates/app/ui/screens/expenses/add_expense/add_expense_dialog.dart';
import 'package:flatmates/app/ui/screens/home/home_cubit.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = HomeCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is! Ready)
          return const Center(child: CircularProgressIndicator());

        return Scaffold(
          appBar: AppBar(
            title: InkWell(
              onTap: () => Navigator.of(context).pushNamed('/flat'),
              child: Text(cubit.flatName ?? 'My Flat',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          body: ListView(
            padding: SizeUtils.of(context).basePadding,
            children: [
              Card(
                child: ListTile(
                  title: const Text('Expenses'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => showDialog(
                        barrierDismissible: false,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => const AddExpenseDialog()),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/expenses'),
                ),
              ),
            ],
          ),
        );
      });
}
