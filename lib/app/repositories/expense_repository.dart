import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/repository_collection.dart';
import 'package:get_it/get_it.dart';

class ExpenseRepository extends RepositoryCollection<Expense> {
  ExpenseRepository() : super(builder: Expense.fromJson) {
    GetIt.I<FlatRepository>().data.then((flat) => load('flats/${flat.id}/expenses'));
  }
}
