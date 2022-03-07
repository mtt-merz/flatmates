import '../serializable_model.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense extends SerializableModel {
  static const key = 'expenses';

  @JsonKey(required: true)
  double amount;

  @JsonKey(required: true)
  String? description;

  @JsonKey(required: true)
  String issuerId;

  @JsonKey(required: true)
  List<String> addresseeIds;

  @JsonKey(required: true)
  final String flatId;

  @JsonKey(required: true)
  final DateTime timestamp;

  Expense({
    required this.flatId,
    required this.amount,
    this.description,
    required this.issuerId,
    required this.addresseeIds,
  })  : timestamp = DateTime.now(),
        super.init(key);

  Expense._(
    String id,
    this.amount,
    this.description,
    this.issuerId,
    this.addresseeIds,
    this.flatId,
    this.timestamp,
  ) : super(id);

  @override
  factory Expense.fromJson(json) => _$ExpenseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
