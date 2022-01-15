import 'dart:async';

import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/models/flat/mate.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';

abstract class ExpenseViewModelInterface {
  Expense get defaultExpense;

  List<Mate> get mates;

  bool check(Expense expense);

  void insert(Expense expense);

  Stream<List<Expense>> get allExpensesStream;

  Stream<List<Expense>> get latestExpensesStream;

  Stream<List<List<Expense>>> get expensesDiaryStream;
}

class ExpenseViewModel implements ExpenseViewModelInterface {
  @override
  Expense get defaultExpense => Expense(
        amount: 0,
        flat: 'FlatRepository.instance.object!.id',
        // TODO: update this
        issuer: Mate('test'),
        addresses: mates,
      );

  @override
  List<Mate> get mates =>[];// FlatRepository.instance.object!.mates;

  @override
  bool check(Expense expense) => expense.amount != 0;

  @override
  void insert(Expense expense) {
    if (expense.description?.isEmpty ?? false) expense.description = null;
    ExpenseRepository.instance.insert(expense);
  }

  @override
  Stream<List<Expense>> get allExpensesStream => ExpenseRepository.instance.stream;

  @override
  Stream<List<Expense>> get latestExpensesStream => ExpenseRepository.instance.stream.transform(
        StreamTransformer.fromHandlers(
            handleData: (expenses, sink) =>
                sink.add(expenses.length > 4 ? expenses.sublist(0, 4) : expenses)),
      );

  @override
  Stream<List<List<Expense>>> get expensesDiaryStream =>
      ExpenseRepository.instance.stream.transform(
        StreamTransformer.fromHandlers(
            handleData: (expenses, sink) => sink.add(
                  expenses.fold<List<List<Expense>>>([], (diary, expense) {
                    for (List<Expense> dailyExpenses in diary)
                      if (dailyExpenses.any((e) => e.createdAt.day == expense.createdAt.day)) {
                        dailyExpenses.add(expense);
                        return diary;
                      }

                    diary.add([expense]);
                    return diary;
                  }),
                )),
      );
}
