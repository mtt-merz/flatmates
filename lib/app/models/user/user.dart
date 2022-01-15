import 'dart:math';

import 'package:flutter/material.dart';

import '../serializable_model.dart';

part 'user.g.dart';

const userKey = 'users';

@JsonSerializable()
class User extends SerializableModel {
  @JsonKey()
  String flat;

  @JsonKey()
  int colorValue;

  @JsonKey(ignore: true)
  Color get color => Color(colorValue);

  User(String id)
      : flat = '',
        colorValue = Colors.primaries[Random().nextInt(Colors.primaries.length)].value,
        super.initFromId(id, userKey);

  User._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.flat,
    this.colorValue,
  ) : super(id, userKey, createdAt, updatedAt);

  @override
  factory User.fromJson(json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'USER $id';
}
