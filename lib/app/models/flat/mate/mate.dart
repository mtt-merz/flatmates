import 'package:flatmates/app/models/serializable_model.dart';

part 'mate.g.dart';

/// A [Mate] represents a person who lives in a flat.
/// In general it's an entity relevant only in the flat context; it can be related to a real user
/// (the user who create a flat can specify also the mates; when a user joins the flat its id
/// is associated to one of the specified mates, or to a new one).
@JsonSerializable()
class Mate {
  @JsonKey(required: true)
  String name;

  @JsonKey()
  String? userId;

  Mate(this.name);

  Mate._(this.name, this.userId);

  factory Mate.fromJson(json) => _$MateFromJson(json);

  Map<String, dynamic> toJson() => _$MateToJson(this);
}
