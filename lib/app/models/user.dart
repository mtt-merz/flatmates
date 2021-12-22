import 'dart:math';

import 'package:flutter/material.dart';

import 'template/serializable_model.dart';

part 'user.g.dart';

enum UserType { mate, owner }

@JsonSerializable()
class User extends ExtendedSerializableModel {
  static const String key = 'users';

  @JsonKey()
  late String name;

  @JsonKey()
  late String flat;

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
