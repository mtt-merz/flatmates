import 'template/serializable_model.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense extends ExtendedSerializableModel {
  static const String key = 'expenses';

  @JsonKey(required: true)
  double amount;

  @JsonKey(required: true)
  String? description;

  @JsonKey(required: true)
  List<String> issuers;

  @JsonKey(required: true)
  List<String> addresses;

  @JsonKey(required: true)
  final String flat;

  Expense({
    required this.flat,
    required this.amount,
    this.description,
    required this.issuers,
    required this.addresses,
  }) : super.init();

  Expense._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.amount,
    this.description,
    this.issuers,
    this.addresses,
    this.flat,
  ) : super(id, createdAt, updatedAt);

  @override
  factory Expense.fromJson(json) => _$ExpenseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
