import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin Repository<T> {
  /// Use this stream to notify listeners about main changes
  /// of the repository object. For instance:
  ///  - from null to not null
  ///  - changes of object id
  ///  - changes of number of objects in the list
  ///  - [...]
  Stream<T> get breakingStream => _breakingStreamController.stream;
  final BehaviorSubject<T> _breakingStreamController = BehaviorSubject();

  @protected
  void addBreakingEvent(T event) {
    _breakingStreamController.add(event);
    _streamController.add(event);
  }

  /// Use this stream to notify listeners about fine-level updates
  /// of the repository object.
  Stream<T> get stream => _streamController.stream;
  final BehaviorSubject<T> _streamController = BehaviorSubject();

  bool get hasValue => _streamController.value != null;

  T? get value => _streamController.valueOrNull;

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
