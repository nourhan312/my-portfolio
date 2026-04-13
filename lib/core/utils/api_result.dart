import '../error/failures.dart';

/// Typed result returned by every use case and repository.
/// No exceptions escape beyond the data layer.
sealed class ApiResult<T> {
  const ApiResult();
}

final class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

final class Err<T> extends ApiResult<T> {
  final Failure failure;
  const Err(this.failure);
}

extension ApiResultX<T> on ApiResult<T> {
  bool get isSuccess => this is Success<T>;
  bool get isErr => this is Err<T>;

  T get dataOrThrow => switch (this) {
        Success(:final data) => data,
        Err(:final failure) => throw StateError(failure.message),
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) err,
  }) =>
      switch (this) {
        Success(:final data) => success(data),
        Err(:final failure) => err(failure),
      };
}
