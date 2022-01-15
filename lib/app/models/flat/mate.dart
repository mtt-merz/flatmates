import 'package:flatmates/app/models/serializable_model.dart';

part 'mate.g.dart';

const _key = 'mates';

@JsonSerializable()
class Mate extends SerializableModel {
  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  String? userId;

  Mate(this.name) : super.init(_key);

  Mate._(
    id,
    createdAt,
    updatedAt,
    this.name,
    this.userId,
  ) : super(id, _key, createdAt, updatedAt);

  @override
  factory Mate.fromJson(json) => _$MateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MateToJson(this);
}
