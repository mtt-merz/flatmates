import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeCubitState {}

class Ready extends HomeCubitState {}

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(Ready());

  String? get flatName => FlatRepository.i.value.name;
}
