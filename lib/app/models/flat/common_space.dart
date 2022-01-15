import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flutter/material.dart';

part 'common_space.g.dart';

@JsonSerializable()
class CommonSpace {
  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final int colorValue;

  @JsonKey(ignore: true)
  Color get color => Color(colorValue);

  CommonSpace(this.name, {Color? color}) : colorValue = color?.value ?? Colors.white.value;

  CommonSpace._(this.name, this.colorValue);

  factory CommonSpace.fromJson(json) => _$CommonSpaceFromJson(json);

  Map<String, dynamic> toJson() => _$CommonSpaceToJson(this);
}

List<CommonSpace> defaultCommonSpaces = [
  CommonSpace('Kitchen', color: Colors.amber),
  CommonSpace('Bathroom', color: Colors.cyan),
  CommonSpace('Entrance', color: Colors.deepPurpleAccent),
  CommonSpace('Living Room', color: Colors.deepOrange),
  CommonSpace('Bedroom', color: Colors.blue),
  CommonSpace('Terrace', color: Colors.pinkAccent),
];
