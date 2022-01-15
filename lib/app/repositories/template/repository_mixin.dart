mixin RepositoryMixin<T> {
  Stream<T> get stream;

  Future<T> get data => stream.first;
}
