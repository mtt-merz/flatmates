import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetExpenseState {
  final Expense expense;

  final bool isLoading;
  final bool hasError;

  SetExpenseState(this.expense,
      {this.isLoading = false, this.hasError = false});
}

final _defaultExpense = Expense(
  amount: 0,
  issuerId: UserRepository.i.value!.id,
  addresseeIds:
      FlatRepository.i.value!.mates.map((mate) => mate.userId).toList(),
);

class SetExpenseCubit extends Cubit<SetExpenseState> {
  final Expense _expense;

  SetExpenseCubit(Expense? expense)
      : _expense = expense?.clone() ?? _defaultExpense.clone(),
        super(SetExpenseState(expense ?? _defaultExpense));

  late final Expense _originalExpense = _expense.clone();

  List<Mate> get mates => [...FlatRepository.i.value!.mates];

  void setAmount(String amount) =>
      emit(SetExpenseState(_expense..amount = double.tryParse(amount) ?? 0.0));

  void setDescription(String description) =>
      emit(SetExpenseState(_expense..description = description));

  void addAddressee(String addresseeId) =>
      emit(SetExpenseState(_expense..addresseeIds.add(addresseeId)));

  void removeAddressee(String addresseeId) =>
      emit(SetExpenseState(_expense..addresseeIds.remove(addresseeId)));

  bool get canSubmit =>
      _expense.amount != 0 &&
      _expense.addresseeIds.isNotEmpty &&
      _expense != _originalExpense;
}
