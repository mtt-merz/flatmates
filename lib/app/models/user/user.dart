import '../serializable_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends SerializableModel {
  @JsonKey(required: true)
  final bool isAnonymous;

  @JsonKey()
  String? flatId;

  User(String id, {required this.isAnonymous, this.flatId}) : super(id);

  User._(String id, this.isAnonymous, this.flatId) : super(id);

  @override
  factory User.fromJson(json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
