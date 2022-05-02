import 'package:flatmates/app/models/chore/chore.dart';
import 'package:flatmates/locator.dart';

import 'flat_repository.dart';
import 'repository_collection.dart';

class ChoreRepository extends RepositoryCollection<Chore> {
  static ChoreRepository get i => Locator.get<ChoreRepository>();

  ChoreRepository() : super(builder: Chore.fromJson);

  @override
  void fetch() => FlatRepository.i.breakingStream.listen((flat) {
        print('CHORE REPOSITORY FETCH TRIGGER: $flat');
        if (flat == null) return;
        key = 'flats/${flat.id}/chores';
        load(key);
      });
}
