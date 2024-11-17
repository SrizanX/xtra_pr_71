sealed class Result<T> {
  const Result();
}

final class Successful<T> extends Result<T> {
  final T data;

  const Successful({required this.data});
}

final class Failed<T> extends Result<T> {
  final String message;
  final Exception? exception;

  const Failed({required this.message, this.exception});
}
