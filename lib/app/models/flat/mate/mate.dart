import 'package:equatable/equatable.dart';
import 'package:flatmates/app/models/serializable_model.dart';

part 'mate.g.dart';

/// A [Mate] represents a person who lives in a flat.
/// It's an entity relevant only in the flat context; it's related to a user.
@JsonSerializable()
class Mate extends Equatable {
  @JsonKey(required: true)
  final String name;

  @JsonKey()
  final String? surname;

  @JsonKey(required: true)
  final String userId;

  @JsonKey(required: true)
  final int colorValue;

  const Mate(this.name, {required this.userId, required this.colorValue, this.surname});

  const Mate._(this.userId, this.name, this.surname, this.colorValue);

  factory Mate.fromJson(json) => _$MateFromJson(json);

  Map<String, dynamic> toJson() => _$MateToJson(this);

  Mate copyWith({String? userId, String? name, String? surname, int? colorValue}) => Mate._(
      userId ?? this.userId,
      name ?? this.name,
      surname ?? this.surname,
      colorValue ?? this.colorValue);

  @override
  List<Object?> get props => [userId, name, surname, colorValue];
}
