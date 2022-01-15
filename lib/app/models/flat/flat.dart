import 'package:flatmates/app/models/flat/mate.dart';
import 'package:flatmates/app/models/serializable_model.dart';

import 'common_space.dart';

export 'common_space.dart';

part 'flat.g.dart';

const flatKey = 'flats';

@JsonSerializable()
class Flat extends SerializableModel {
  @JsonKey(required: true)
  String? name;

  @JsonKey(required: true)
  List<Mate> mates;

  @JsonKey(required: true, defaultValue: [])
  List<CommonSpace> commonSpaces;

  Flat()
      : mates = [],
        commonSpaces = [],
        super.init(flatKey);

  Flat._(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    this.name,
    this.mates,
    this.commonSpaces,
  ) : super(id, flatKey, createdAt, updatedAt);

  @override
  factory Flat.fromJson(json) => _$FlatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FlatToJson(this);
}
