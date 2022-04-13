import 'package:flatmates/app/ui/screens/expenses/expense_adder/expense_adder_dialog.dart';
import 'package:flatmates/app/ui/screens/home/home_cubit.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      builder: (context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: Padding(
            padding: SizeUtils.of(context).basePadding,
            child: CustomScrollView(slivers: [
              SliverAppBar(
                title: Text(cubit.flatName),
                pinned: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 150,
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Card(
                  child: ListTile(
                    title: const Text('Expenses'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => showDialog(
                          barrierDismissible: false,
                          useSafeArea: true,
                          barrierColor: Colors.black87,
                          context: context,
                          builder: (context) => const ExpenseAdderDialog()),
                    ),
                    onTap: () => Navigator.of(context).pushNamed('/expenses'),
                  ),
                ),
              ]))
            ]),
          ),
        );
      });
}
