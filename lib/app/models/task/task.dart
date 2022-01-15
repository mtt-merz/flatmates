import '../serializable_model.dart';

part 'task.g.dart';

const _key = 'tasks';

@JsonSerializable()
class Task extends SerializableModel {
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
        super.init(_key);

  Task._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.name,
    this.addresses,
    this.start,
    this.end,
    this.done,
  ) : super(id, _key, createdAt, updatedAt);

  @override
  factory Task.fromJson(json) => _$TaskFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
