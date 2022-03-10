import '../serializable_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends SerializableModel {
  @JsonKey()
  String? flatId;

  User(String id) : super(id);

  User._(String id, this.flatId) : super(id);

  @override
  factory User.fromJson(json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
