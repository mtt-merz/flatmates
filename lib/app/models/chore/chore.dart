import '../serializable_model.dart';

part 'chore.g.dart';

@JsonSerializable()
class Chore extends SerializableModel {
  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final String? description;

  @JsonKey(required: true)
  final List<String> mateIds;

  Chore({required this.title, this.description, required this.mateIds}) : super.init();

  Chore._(
    String id,
    this.title,
    this.description,
    this.mateIds,
  ) : super(id);

  @override
  factory Chore.fromJson(json) => _$ChoreFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChoreToJson(this);
}
