import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ExpensesCubitState {}

class Loading extends ExpensesCubitState {}

class Loaded extends ExpensesCubitState {
  final List<Expense> expenses;

  Loaded(this.expenses);

  List<List<Expense>> get expensesDiary =>
      (expenses..sort((a, b) => a.timestamp.isAfter(b.timestamp) ? 0 : 1))
          .fold<List<List<Expense>>>([], (diary, expense) {
        for (List<Expense> dailyExpenses in diary)
          if (dailyExpenses
              .any((e) => e.timestamp.day == expense.timestamp.day)) {
            dailyExpenses.add(expense);
            return diary;
          }

        diary.add([expense]);
        return diary;
      });

  double getMateBalance(String userId) =>
      expenses.fold(0.0, (previousValue, expense) {
        var value = previousValue;

        if (expense.issuerId == userId) value += expense.amount;
        if (expense.addresseeIds.contains(userId))
          value -= expense.amount / expense.addresseeIds.length;

        return value;
      });
}

class ExpensesCubit extends Cubit<ExpensesCubitState> {
  ExpensesCubit() : super(Loading()) {
    ExpenseRepository.i.stream.listen(
      (expenses) => emit(Loaded(expenses)),
    );
  }

  String getMateNicknameFromId(String userId) {
    final mate = FlatRepository.i.loggedMate(userId)!;
    return mate.nickname;
  }

  Future<void> refresh() => ExpenseRepository.i.reload();

  List<Mate> get mates => FlatRepository.i.value!.mates;
}
