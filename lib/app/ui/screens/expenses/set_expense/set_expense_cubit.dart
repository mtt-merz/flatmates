import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddExpenseState {}

class Editing extends AddExpenseState {
  final Expense expense;

  final bool isLoading;
  final bool hasError;

  Editing(this.expense, {this.isLoading = false, this.hasError = false});
}

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(Editing(_expense));

  static final _expense = Expense(
    amount: 0,
    issuerId: UserRepository.i.value!.id,
    addresseeIds: FlatRepository.i.value!.mates.map((e) => e.userId).toList(),
  );

  List<Mate> get mates => [...FlatRepository.i.value!.mates];

  void setAmount(String amount) =>
      emit(Editing(_expense..amount = double.tryParse(amount) ?? 0.0));

  void setDescription(String description) =>
      emit(Editing(_expense..description = description));

  void addAddressee(String addresseeId) =>
      emit(Editing(_expense..addresseeIds.add(addresseeId)));

  void removeAddressee(String addresseeId) =>
      emit(Editing(_expense..addresseeIds.remove(addresseeId)));

  bool get canSubmit =>
      _expense.amount != 0 && _expense.addresseeIds.isNotEmpty;

  void submit() {
    ExpenseRepository.i.insert(_expense);
  }
}
