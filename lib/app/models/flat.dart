import 'template/serializable_model.dart';

part 'flat.g.dart';

@JsonSerializable(constructor: '_')
class Flat extends ExtendedSerializableModel {
  static const String key = 'flats';

  @JsonKey(required: true)
  String name;

  Flat(this.name) : super.init();

  Flat._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.name,
  ) : super(id, createdAt, updatedAt);

  @override
  factory Flat.fromJson(json) => _$FlatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FlatToJson(this);
}
