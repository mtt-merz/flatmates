import 'dart:math';

import 'package:flatmates/app/repositories/template/models/serializable_model.dart';
import 'package:flutter/material.dart';

part 'user.g.dart';

enum UserType { mate, owner }

@JsonSerializable(constructor: '_', explicitToJson: true)
class User extends ExtendedSerializableModel {
  @JsonKey()
  String? name;

  @JsonKey()
  String? flat;

  @JsonKey()
  int colorValue;

  @JsonKey(ignore: true)
  Color get color => Color(colorValue);

  User(String id)
      : colorValue = Colors.primaries[Random().nextInt(Colors.primaries.length)].value,
        super.initFromId(id);

  User._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.name,
    this.flat,
    this.colorValue,
  ) : super(id, createdAt, updatedAt);

  @override
  factory User.fromJson(json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'USER $id';
}
