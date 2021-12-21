import 'dart:async';

import 'package:flatmates/app/models/flat.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication_service.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';
import 'package:flatmates/app/repositories/template/repository.dart';

export 'package:flatmates/app/models/flat.dart';

const _key = 'flats';

class FlatRepository extends Repository<Flat> {
  static FlatRepository? _instance;

  static FlatRepository get instance =>
      _instance ??= FlatRepository._(AuthenticationService.instance.userId);

  @override
  String get key => 'flats';

  FlatRepository._(String userId)
      : super(
            builder: Flat.fromJson,
            fetchObjects: () async {
              List<Map<String, dynamic>> result = [];

              // Get flats on which the user lives
              result.addAll(await Persistence.instance
                  .getWhereFieldContains(_key, field: 'mates', value: userId));

              // Get flats owned by the user
              result.addAll(await Persistence.instance
                  .getWhereFieldContains(_key, field: 'owner', value: userId));

              return result;
            });

  Flat get mainFlat =>
      objects.singleWhere((flat) => flat.id == UserRepository.instance.user.flat!);

  Stream get mainFlatStream => objectsStream.transform(StreamTransformer((stream, _) {
        final controller = StreamController();
        return stream.listen((_) => controller.add(mainFlat));
      }));

  @override
  Future<void> insert(Flat object) {
    UserRepository.instance.update((user) => user..flat = object.id);
    return super.insert(object);
  }
}
