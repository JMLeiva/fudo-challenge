sealed class Result<S, F> {
  const Result();

  factory Result.success(S value) {
    return Success(value);
  }

  factory Result.failure(F value) {
    return Failure(value);
  }
}

class Success<S, F> extends Result<S, F> {
  const Success(this.value);
  final S value;
}

class Failure<S, F> extends Result<S, F> {
  const Failure(this.value);
  final F value;
}