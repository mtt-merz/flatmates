import 'dart:math';

import 'package:flutter/material.dart';

import '../serializable_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends SerializableModel {
  static const key = 'users';

  @JsonKey()
  String? flatId;

  @JsonKey(required: true)
  final int colorValue;

  Color get color => Color(colorValue);

  User(String id)
      : colorValue = Colors.primaries[Random().nextInt(Colors.primaries.length)].value,
        super(id);

  User._(
    String id,
    this.flatId,
    this.colorValue,
  ) : super(id);

  @override
  factory User.fromJson(json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'USER $id';
}
