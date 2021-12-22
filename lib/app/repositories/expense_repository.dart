import 'package:flatmates/app/models/expense.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';

import 'template/collection_repository.dart';

class ExpenseRepository extends CollectionRepository<Expense> {
  static ExpenseRepository get instance =>
      _instance ??= ExpenseRepository._(UserRepository.instance.user.flat);
  static ExpenseRepository? _instance;

  ExpenseRepository._(String flatId)
      : super(
          builder: Expense.fromJson,
          query: PersistenceQuery(Expense.key).isEqualTo(field: 'flat', value: flatId),
        );

  @override
  void refresh() => _instance = null;
}
