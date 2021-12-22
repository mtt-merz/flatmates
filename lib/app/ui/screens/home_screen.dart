import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/ui/screens/expenses/add_expense_dialog.dart';
import 'package:flatmates/app/ui/screens/expenses/expense_tile.dart';
import 'package:flatmates/app/ui/screens/expenses/expense_view_model.dart';
import 'package:flatmates/app/ui/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget get lastExpenses => StreamBuilder(
      stream: ExpenseViewModel.latestExpensesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && (snapshot.data! as List).isEmpty) return const SizedBox();
        return CardColumn(
          title: 'Last expenses',
          children: !snapshot.hasData
              ? [const Center(child: CircularProgressIndicator())]
              : (snapshot.data as List<Expense>)
                  .map<Widget>((expense) => ExpenseTile(expense))
                  .toList()
            ..add(ListTile(
              title: const Text('View all'),
              onTap: () => Navigator.of(context).pushNamed('expenses'),
            )),
        );
      });

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
                      return Text(flat.name);
                    }),
                pinned: true,
                // collapsedHeight: 100,
                backgroundColor: Colors.transparent,
                expandedHeight: 150,
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                lastExpenses,
                Card(
                  child: ListTile(
                    title: const Text('Chores'),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () => Navigator.of(context).pushNamed('chores'),
                  ),
                ),
              ]))
            ]),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Add expense'),
          icon: const Icon(Icons.add),
          onPressed: () =>
              showDialog(context: context, builder: (_) => const AddExpenseDialog())
                  .then((expense) {
            if (expense == null) return;
            ExpenseRepository.instance.insert(expense as Expense);
          }),
        ),
      );

  bool showBottom = false;
}
