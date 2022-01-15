import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/services/persistence.dart';

import 'template/repository_collection.dart';

class ExpenseRepository extends RepositoryCollection<Expense> {
  static ExpenseRepository get instance => _instance ??= ExpenseRepository._();
  static ExpenseRepository? _instance;

  ExpenseRepository._()
      : super(
          builder: Expense.fromJson,
          query: PersistenceQuery(expenseKey)
              .isEqualTo(field: 'flat', value: 'test'),
        );

  @override
  void refresh() => _instance = null;
}
