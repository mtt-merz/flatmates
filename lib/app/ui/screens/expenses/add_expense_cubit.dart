// import 'package:flatmates/app/models/expense/expense.dart';
// import 'package:flatmates/app/models/flat/mate/mate.dart';
// import 'package:flatmates/app/repositories/user_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
//
// class AddExpenseCubit extends Cubit<Expense?> {
//   final List<Mate> _mates;
//
//   AddExpenseCubit(this._mates) : super(null) {
//     _defaultExpense.then(emit);
//   }
//
//   Future<Expense> get _defaultExpense async {
//     final user = await GetIt.I<UserRepository>().data;
//
//     return Expense(flatId: user.flatId, amount: 0, issuerId: user.id, addresseeIds: addresseeIds);
//   }
//
//   late Expense _expense;
//
//   @override
//   void onChange(Change<Expense?> change) {
//     super.onChange(change);
//
//     assert(change.nextState != null);
//     _expense = change.nextState!;
//   }
//
//   set expenseAmount(double amount) => emit(_expense..amount = amount);
//
//   set expenseDescription(String description) => emit(_expense..description = description);
//
//   void addAddressee(String addresseeId) => emit(_expense..addresseeIds.add(addresseeId));
//
//   void removeAddressee(String addresseeId) => emit(_expense..addresseeIds.remove(addresseeId));
//
//   List<Mate> get mates => [..._mates];
//
//   bool get canSubmit => _expense.amount > 0 && _expense.addresseeIds.isNotEmpty;
// }
