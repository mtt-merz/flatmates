import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/repository_collection.dart';
import 'package:flatmates/locator.dart';

class ExpenseRepository extends RepositoryCollection<Expense> {
  ExpenseRepository() : super(builder: Expense.fromJson);

  @override
  void fetch() =>
      Locator.get<FlatRepository>().stream.listen((flat) => load('flats/${flat.id}/expenses'));
}
