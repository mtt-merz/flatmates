import 'package:flatmates/app/services/persistence.dart';
import 'package:json_annotation/json_annotation.dart';

export 'package:json_annotation/json_annotation.dart';

part 'serializable_model.g.dart';

@JsonSerializable(constructor: '', createFactory: false)
abstract class SerializableModel implements _Serializable {
  @JsonKey(required: true)
  final String id;

  @JsonKey(required: true)
  final String key;

  @JsonKey(required: true)
  final DateTime createdAt;

  @JsonKey(required: true)
  DateTime _updatedAt;

  DateTime get updatedAt => _updatedAt;

  SerializableModel.init(this.key)
      : id = Persistence.instance.generateId(key),
        createdAt = DateTime.now(),
        _updatedAt = DateTime.now();

  SerializableModel.initFromId(this.id, this.key)
      : createdAt = DateTime.now(),
        _updatedAt = DateTime.now();

  SerializableModel(
    this.id,
    this.key,
    this.createdAt,
    DateTime updatedAt,
  ) : _updatedAt = updatedAt;

  void update() => _updatedAt = DateTime.now();

  @override
  bool operator ==(Object other) {
    if (other is! SerializableModel) return false;
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
