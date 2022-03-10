import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin Repository<T> {
  /// Control the [Repository] stream
  final BehaviorSubject<T> _streamController = BehaviorSubject();

  Stream<T> get stream => _streamController.stream;

  bool get hasValue => _streamController.hasValue;

  T get value => _streamController.value;

  @protected
  void addEvent(T event) => _streamController.add(event);

  @mustCallSuper
  void close() => _streamController.close();
}

class LoadRepositoryFailure {}
