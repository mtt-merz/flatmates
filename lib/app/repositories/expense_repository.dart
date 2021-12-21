import 'package:flatmates/app/models/expense.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';
import 'package:flatmates/app/repositories/template/repository.dart';

export 'package:flatmates/app/models/expense.dart';

const _key = 'expenses';

class ExpenseRepository extends Repository<Expense> {
  static ExpenseRepository get instance => _instance ??= ExpenseRepository._();
  static ExpenseRepository? _instance;

  @override
  String get key => 'expenses';

  ExpenseRepository._()
      : super(
            builder: Expense.fromJson,
            fetchObjects: () => Persistence.instance.getAll(_key));

  /// Divide expenses in daily groups
  List<List<Expense>> get diary => objects.fold([], (diary, expense) {
        for (List<Expense> dailyExpenses in diary)
          if (dailyExpenses.any((e) => e.createdAt.day == expense.createdAt.day)) {
            dailyExpenses.add(expense);
            return diary;
          }

        diary.add([expense]);
        return diary;
      });
}
