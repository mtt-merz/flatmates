import 'package:json_annotation/json_annotation.dart';

export 'package:json_annotation/json_annotation.dart';

part 'serializable_model.g.dart';

@JsonSerializable()
class SerializableModel implements _Serializable {
  @JsonKey(required: true)
  final String id;

  SerializableModel.init() : id = 'temp_id';

  SerializableModel(this.id);

  @override
  factory SerializableModel.fromJson(json) => _$SerializableModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SerializableModelToJson(this);
}

@JsonSerializable()
class ExtendedSerializableModel extends SerializableModel {
  @JsonKey(required: true)
  final DateTime createdAt;

  @JsonKey(required: true)
  DateTime _updatedAt;

  DateTime get updatedAt => _updatedAt;

  ExtendedSerializableModel.init()
      : createdAt = DateTime.now(),
        _updatedAt = DateTime.now(),
        super.init();

  ExtendedSerializableModel.initFromId(String id)
      : createdAt = DateTime.now(),
        _updatedAt = DateTime.now(),
        super(id);

  ExtendedSerializableModel(String id, this.createdAt, DateTime updatedAt)
      : _updatedAt = updatedAt,
        super(id);

  void update() => _updatedAt = DateTime.now();

  @override
  factory ExtendedSerializableModel.fromJson(json) =>
      _$ExtendedSerializableModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExtendedSerializableModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is! ExtendedSerializableModel) return false;
    if (runtimeType != other.runtimeType) return false;

    return other.id == id && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => id.hashCode;
}

abstract class _Serializable {
  _Serializable.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
