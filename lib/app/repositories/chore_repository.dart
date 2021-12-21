import 'package:flatmates/app/models/chore.dart';
import 'package:flatmates/app/repositories/template/repository.dart';

export 'package:flatmates/app/models/chore.dart';

class ChoreRepository extends Repository<Chore> {
  static ChoreRepository get instance => _instance ??= ChoreRepository._();
  static ChoreRepository? _instance;

  ChoreRepository._() : super(builder: Chore.fromJson, fetchObjects: () async => []);

  @override
  String get key => 'chores';
}
