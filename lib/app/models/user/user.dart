import '../serializable_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends SerializableModel {
  static const key = 'users';

  @JsonKey(required: true)
  final bool isAnonymous;

  @JsonKey()
  final Set<String> flatIds;

  @JsonKey()
  String? currentFlatId;

  User(String id, {required this.isAnonymous, Set<String>? flatIds, this.currentFlatId})
      : flatIds = flatIds ?? <String>{},
        super(id);

  User._(String id, this.isAnonymous, this.flatIds, this.currentFlatId) : super(id);

  @override
  factory User.fromJson(json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
