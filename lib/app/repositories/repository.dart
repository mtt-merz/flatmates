import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin Repository<T> {
  /// Control the [Repository] stream
  final BehaviorSubject<T> _streamController = BehaviorSubject();

  Stream<T> get stream => _streamController.stream;

  bool get hasValue => _streamController.hasValue;

  T get value => _streamController.value;

  T? get valueOrNull => _streamController.valueOrNull;

  @protected
  void addEvent(T event) => _streamController.add(event);

  @mustCallSuper
  void close() => _streamController.close();
}

class FetchRepositoryFailure<R extends Repository> {
  final String toFetch;

  FetchRepositoryFailure(this.toFetch);

  @override
  String toString() => '$R cannot fetch $toFetch';
}
