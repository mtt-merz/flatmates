import 'package:flatmates/app/ui/screens/expenses/expense_tile.dart';
import 'package:flatmates/app/ui/screens/expenses/set_expense_screen.dart';
import 'package:flatmates/app/ui/widget/card.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User get user => UserRepository.instance.user;

  Flat get flat => FlatRepository.instance.mainFlat;

  Widget get lastExpenses => CardColumn(
        title: 'Last expenses',
        children: ExpenseRepository.instance.objects
            .map((expense) => ExpenseTile(expense) as Widget)
            .toList()
          ..add(ListTile(
            title: const Text('View all'),
            onTap: () => Navigator.of(context).pushNamed('expenses'),
          )),
      );

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
            StreamBuilder(
                stream: MergeStream([
                  ExpenseRepository.instance.objectsStream,
                ]),
                builder: (context, _) {
                  return CustomScrollView(slivers: [
                    SliverAppBar(
                      title: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(flat.name),
                        const SizedBox(width: 5),
                        const Icon(Icons.keyboard_arrow_down, size: 18)
                      ]),
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
                  ]);
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Add expense'),
          icon: const Icon(Icons.add),
          onPressed: () =>
              showDialog(context: context, builder: (_) => const AddExpenseScreen())
                  .then((expense) {
            if (expense == null) return;
            ExpenseRepository.instance.insert(expense as Expense);
          }),
        ),
      );

  bool showBottom = false;
}
