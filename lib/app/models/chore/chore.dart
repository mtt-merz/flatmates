import '../serializable_model.dart';

part 'chore.g.dart';

const choreKey = 'chores';

@JsonSerializable()
class Chore extends SerializableModel {
  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final String? description;

  @JsonKey(required: true)
  final List<String> user;

  Chore({required this.title, this.description, required this.user}) : super.init(choreKey);

  Chore._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.title,
    this.description,
    this.user,
  ) : super(id, choreKey, createdAt, updatedAt);

  @override
  factory Chore.fromJson(json) => _$ChoreFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChoreToJson(this);
}
