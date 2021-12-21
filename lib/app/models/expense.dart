import 'package:flatmates/app/repositories/template/models/serializable_model.dart';

part 'expense.g.dart';

@JsonSerializable(constructor: '_')
class Expense extends ExtendedSerializableModel {
  @JsonKey(required: true)
  double amount = 0;

  @JsonKey(required: true)
  String title = '';

  @JsonKey(required: true)
  final List<String> issuers;

  @JsonKey(required: true)
  final List<String> addresses;

  Expense.init({required this.issuers, required this.addresses})
      : amount = 0,
        super.init();

  // To be called ONLY by the generator
  Expense._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.amount,
    this.title,
    this.issuers,
    this.addresses,
  ) : super(id, createdAt, updatedAt);

  @override
  factory Expense.fromJson(json) => _$ExpenseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
