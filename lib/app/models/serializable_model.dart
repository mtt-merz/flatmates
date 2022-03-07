import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

export 'package:json_annotation/json_annotation.dart';

part 'serializable_model.g.dart';

@JsonSerializable(constructor: '', createFactory: false)
abstract class SerializableModel implements _Serializable {
  @JsonKey(required: true)
  final String id;

  SerializableModel.init(String key) : id = GetIt.I<PersistenceService>().generateId(key);

  SerializableModel(this.id);

  @override
  bool operator ==(Object other) {
    if (other is! SerializableModel) return false;
    if (runtimeType != other.runtimeType) return false;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

abstract class _Serializable {
  _Serializable.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
