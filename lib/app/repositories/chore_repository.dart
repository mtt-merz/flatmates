import 'package:flatmates/app/models/chore.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';

import 'template/collection_repository.dart';

export 'package:flatmates/app/models/chore.dart';

class ChoreRepository extends CollectionRepository<Chore> {
  static ChoreRepository get instance =>
      _instance ??= ChoreRepository._(UserRepository.instance.user.flat);
  static ChoreRepository? _instance;

  User? user;

  ChoreRepository._(String flatId)
      : super(
            builder: Chore.fromJson,
            query: PersistenceQuery(Chore.key).isEqualTo(field: 'flat', value: flatId));

  @override
  void refresh() => _instance = null;
}
