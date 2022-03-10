import 'package:flatmates/app/models/serializable_model.dart';

part 'mate.g.dart';

/// A [Mate] represents a person who lives in a flat.
/// It's an entity relevant only in the flat context; it's related to a user.
@JsonSerializable()
class Mate {
  @JsonKey(required: true)
  final String userId;

  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  int colorValue;

  Mate(this.userId, {required this.name, required this.colorValue});

  Mate._(this.userId, this.name, this.colorValue);

  factory Mate.fromJson(json) => _$MateFromJson(json);

  Map<String, dynamic> toJson() => _$MateToJson(this);

  Mate clone() => Mate._(userId, name, colorValue);
}
