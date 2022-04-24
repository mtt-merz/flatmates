import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/models/serializable_model.dart';

import 'common_space/common_space.dart';

export 'common_space/common_space.dart';

part 'flat.g.dart';

@JsonSerializable()
class Flat extends SerializableModel {
  static const key = 'flats';

  @JsonKey(required: true)
  String? name;

  @JsonKey(required: true)
  String invitationCode;

  @JsonKey(required: true)
  List<Mate> mates;

  @JsonKey(required: true, defaultValue: [])
  List<CommonSpace> commonSpaces;

  Flat({required Mate mate})
      : mates = [mate],
        commonSpaces = [],
        invitationCode = DateTime.now().millisecondsSinceEpoch.toString(),
        super.init();

  Flat._(
      String id, this.invitationCode, this.name, this.mates, this.commonSpaces)
      : super(id);

  @override
  factory Flat.fromJson(json) => _$FlatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FlatToJson(this);
}
