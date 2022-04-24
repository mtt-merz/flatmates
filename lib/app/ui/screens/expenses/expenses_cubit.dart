import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCubit extends Cubit<AsyncSnapshot<List<Expense>>> {
  final _expenseRepository = Locator.get<ExpenseRepository>();

  ExpenseCubit() : super(const AsyncSnapshot.waiting()) {
    _expenseRepository.stream.listen(
      (expenses) => emit(AsyncSnapshot.withData(ConnectionState.active, expenses)),
    );
  }

  void insert(Expense expense) {
    if (expense.description?.isEmpty ?? false) expense.description = null;
    _expenseRepository.insert(expense);
  }

// @override
// Stream<List<List<Expense>>> get expensesDiaryStream =>
//     ExpenseRepository.instance.stream.transform(
//       StreamTransformer.fromHandlers(
//           handleData: (expenses, sink) => sink.add(
//                 expenses.fold<List<List<Expense>>>([], (diary, expense) {
//                   for (List<Expense> dailyExpenses in diary)
//                     if (dailyExpenses.any((e) => e.createdAt.day == expense.createdAt.day)) {
//                       dailyExpenses.add(expense);
//                       return diary;
//                     }
//
//                   diary.add([expense]);
//                   return diary;
//                 }),
//               )),
//     );
}
