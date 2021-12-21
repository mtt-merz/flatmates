import 'package:flatmates/app/repositories/template/models/serializable_model.dart';

part 'flat.g.dart';

enum FlatRole { owner, mate }

@JsonSerializable(constructor: '_')
class Flat extends ExtendedSerializableModel {
  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  final String? owner;

  @JsonKey(defaultValue: [])
  final List<String> mates;

  Flat(this.name, {required FlatRole role, required String userId})
      : owner = role == FlatRole.owner ? userId : null,
        mates = role == FlatRole.mate ? [userId] : [],
        super.init();

  Flat._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.name,
    this.owner,
    this.mates,
  ) : super(id, createdAt, updatedAt);

  @override
  factory Flat.fromJson(json) => _$FlatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FlatToJson(this);
}
