import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/repository_collection.dart';
import 'package:flatmates/locator.dart';

class ExpenseRepository extends RepositoryCollection<Expense> {
  static ExpenseRepository get i => Locator.get<ExpenseRepository>();

  ExpenseRepository() : super(builder: Expense.fromJson);

  @override
  void fetch() => FlatRepository.i.stream.listen((flat) {
        key = 'flats/${flat.id}/expenses';
        load(key);
      });
}
