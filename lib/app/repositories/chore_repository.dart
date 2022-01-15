import 'package:flatmates/app/models/chore/chore.dart';
import 'package:flatmates/app/services/persistence.dart';

import 'template/repository_collection.dart';

export 'package:flatmates/app/models/chore/chore.dart';

class ChoreRepository extends RepositoryCollection<Chore> {
  static ChoreRepository get instance => _instance ??= ChoreRepository._();
  static ChoreRepository? _instance;

  ChoreRepository._()
      : super(
            builder: Chore.fromJson,
            query: PersistenceQuery(choreKey)
                .isEqualTo(field: 'flat', value: 'UserRepository.instance.object!.flat'));

  @override
  void refresh() => _instance = null;
}
