import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

export 'package:json_annotation/json_annotation.dart';

part 'serializable_model.g.dart';

@JsonSerializable(constructor: '', createFactory: false)
abstract class SerializableModel with EquatableMixin implements _Serializable {
  @JsonKey(required: true)
  final String id;

  SerializableModel.init() : id = const Uuid().v4();

  const SerializableModel(this.id);

  @override
  List<Object> get props => [id];
}

abstract class _Serializable {
  _Serializable.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
