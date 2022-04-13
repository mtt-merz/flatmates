import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseAdderCubit extends Cubit<Expense?> {
  ExpenseAdderCubit() : super(_defaultExpense);

  static User get _user => Locator.get<UserRepository>().value!;

  static Flat get _flat => Locator.get<FlatRepository>().value;

  static final Expense _defaultExpense = Expense(
    amount: 0,
    issuerId: _user.id,
    addresseeIds: _flat.mates.map((e) => e.name).toList(),
  );

  late Expense _expense;

  @override
  void onChange(Change<Expense?> change) {
    super.onChange(change);

    assert(change.nextState != null);
    _expense = change.nextState!;
  }

  set expenseAmount(double amount) => emit(_expense..amount = amount);

  set expenseDescription(String description) => emit(_expense..description = description);

  void addAddressee(String addresseeId) => emit(_expense..addresseeIds.add(addresseeId));

  void removeAddressee(String addresseeId) => emit(_expense..addresseeIds.remove(addresseeId));

  List<Mate> get mates => [..._flat.mates];

  bool get canSubmit => true; //_expense.amount > 0 && _expense.addresseeIds.isNotEmpty;
}
