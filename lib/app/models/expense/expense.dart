import 'package:flatmates/app/models/flat/mate.dart';

import '../serializable_model.dart';

part 'expense.g.dart';

const expenseKey = 'expenses';

@JsonSerializable()
class Expense extends SerializableModel {
  @JsonKey(required: true)
  double amount;

  @JsonKey(required: true)
  String? description;

  @JsonKey(required: true)
  Mate issuer;

  @JsonKey(required: true)
  List<Mate> addresses;

  @JsonKey(required: true)
  final String flat;

  Expense({
    required this.flat,
    required this.amount,
    this.description,
    required this.issuer,
    required this.addresses,
  }) : super.init(expenseKey);

  Expense._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.amount,
    this.description,
    this.issuer,
    this.addresses,
    this.flat,
  ) : super(id, expenseKey, createdAt, updatedAt);

  @override
  factory Expense.fromJson(json) => _$ExpenseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
