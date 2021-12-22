import 'template/serializable_model.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends ExtendedSerializableModel {
  static const String key = 'tasks';

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final List<String> addresses;

  @JsonKey(required: true)
  final DateTime start;

  @JsonKey()
  final DateTime? end;

  @JsonKey(required: true)
  bool done;

  Task({
    required this.name,
    required this.addresses,
    required this.start,
    this.end,
  })  : done = false,
        super.init();

  Task._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.name,
    this.addresses,
    this.start,
    this.end,
    this.done,
  ) : super(id, createdAt, updatedAt);

  @override
  factory Task.fromJson(json) => _$TaskFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
