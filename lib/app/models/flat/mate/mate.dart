import 'package:flatmates/app/models/serializable_model.dart';

part 'mate.g.dart';

/// A [Mate] represents a person who lives in a flat.
/// It's an entity relevant only in the flat context; it's related to a user.
@JsonSerializable()
class Mate {
  @JsonKey(required: true)
  String userId;

  @JsonKey(required: true)
  String name;

  Mate(this.userId, {required this.name});

  Mate._(this.userId, this.name);

  factory Mate.fromJson(json) => _$MateFromJson(json);

  Map<String, dynamic> toJson() => _$MateToJson(this);
}
