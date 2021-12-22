import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';

import 'template/collection_repository.dart';

/// This repository provides the logged [User.mainFlat] mates
class MateRepository extends CollectionRepository<User> {
  static MateRepository get instance =>
      _instance ??= MateRepository._(UserRepository.instance.user.flat);
  static MateRepository? _instance;

  MateRepository._(String flatId)
      : super(
            builder: User.fromJson,
            query: PersistenceQuery(User.key).isEqualTo(field: 'flat', value: flatId));

  @override
  void refresh() => _instance = null;
}
