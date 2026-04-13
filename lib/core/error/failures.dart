/// Base failure class — all errors in the app extend this.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

final class LocalDataFailure extends Failure {
  const LocalDataFailure(super.message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
