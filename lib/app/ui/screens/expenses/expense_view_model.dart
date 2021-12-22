import 'dart:async';

import 'package:flatmates/app/models/expense.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/mate_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';

export 'package:flatmates/app/models/expense.dart';

class ExpenseViewModel {
  static Expense get defaultExpense => Expense(
        amount: 0,
        flat: FlatRepository.instance.object.id,
        issuers: [UserRepository.instance.user.id],
        addresses: mates.map((mate) => mate.id).toList(),
      );

  static List<User> get mates => MateRepository.instance.objects;

  static User getMate(String mateId) => mates.firstWhere((mate) => mate.id == mateId);

  static bool check(Expense expense) => expense.amount != 0;

  static void insert(Expense expense) {
    if (expense.description?.isEmpty ?? false) expense.description = null;
    ExpenseRepository.instance.insert(expense);
  }

  static Stream<List<Expense>> get allExpensesStream => ExpenseRepository.instance.stream;

  static Stream<List<Expense>> get latestExpensesStream =>
      ExpenseRepository.instance.stream.transform(
        StreamTransformer.fromHandlers(
            handleData: (expenses, sink) =>
                sink.add(expenses.length > 4 ? expenses.sublist(0, 4) : expenses)),
      );

  static Stream<List<List<Expense>>> get expensesDiaryStream =>
      ExpenseRepository.instance.stream.transform(
        StreamTransformer.fromHandlers(
            handleData: (expenses, sink) => sink.add(
                  expenses.fold<List<List<Expense>>>([], (diary, expense) {
                    for (List<Expense> dailyExpenses in diary)
                      if (dailyExpenses
                          .any((e) => e.createdAt.day == expense.createdAt.day)) {
                        dailyExpenses.add(expense);
                        return diary;
                      }

                    diary.add([expense]);
                    return diary;
                  }),
                )),
      );
}
