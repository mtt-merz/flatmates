import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flutter/material.dart';

part 'common_space.g.dart';

@JsonSerializable()
class CommonSpace {
  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final int colorValue;

  @JsonKey(required: true)
  bool enabled;

  Color get color => Color(colorValue);

  CommonSpace(this.name, {Color? color, this.enabled = false})
      : colorValue = color?.value ?? Colors.white.value;

  CommonSpace._(this.name, this.colorValue, this.enabled);

  factory CommonSpace.fromJson(json) => _$CommonSpaceFromJson(json);

  Map<String, dynamic> toJson() => _$CommonSpaceToJson(this);
}
