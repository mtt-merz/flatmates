import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/repositories/template/repository_object.dart';
import 'package:flatmates/app/services/persistence.dart';

export 'package:flatmates/app/models/flat/flat.dart';

class FlatRepository extends RepositoryObject<Flat> {
  static late FlatRepository instance;

  static init(String flatId) => instance = FlatRepository._(flatId);

  static create(Flat flat) async {
    await Persistence.instance.insert(flat);
    instance = FlatRepository._(flat.id);
  }

  FlatRepository._(String flatId) : super(key: flatKey, id: flatId, builder: Flat.fromJson);
}
