// import 'dart:async';
//
// import 'package:flatmates/app/models/expense/expense.dart';
// import 'package:flatmates/app/repositories/expense_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// abstract class ExpenseCubitState {}
//
// class Loading extends ExpenseCubitState {}
//
// class Show extends ExpenseCubitState {
//   final List<Expense> expense;
//
//   Show(this.expense);
// }
//
// class ExpenseCubit extends Cubit<ExpenseCubitState> {
//   ExpenseCubit() : super(Loading()) {
//     ExpenseRepository.instance.stream.listen(
//       (expenses) => emit(Show(expenses)),
//     );
//   }
//
//   void insert(Expense expense) {
//     if (expense.description?.isEmpty ?? false) expense.description = null;
//     ExpenseRepository.instance.insert(expense);
//   }
//
//   @override
//   Stream<List<List<Expense>>> get expensesDiaryStream =>
//       ExpenseRepository.instance.stream.transform(
//         StreamTransformer.fromHandlers(
//             handleData: (expenses, sink) => sink.add(
//               expenses.fold<List<List<Expense>>>([], (diary, expense) {
//                 for (List<Expense> dailyExpenses in diary)
//                   if (dailyExpenses.any((e) => e.createdAt.day == expense.createdAt.day)) {
//                     dailyExpenses.add(expense);
//                     return diary;
//                   }
//
//                 diary.add([expense]);
//                 return diary;
//               }),
//             )),
//       );
//
// }
