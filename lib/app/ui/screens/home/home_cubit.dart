import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeCubitState {}

class Ready extends HomeCubitState {}

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(Ready());

  String? get flatName => FlatRepository.i.value!.name;

  void addExpense(Expense expense) => ExpenseRepository.i.insert(expense);
}
