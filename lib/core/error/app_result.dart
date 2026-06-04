import 'app_error.dart';

sealed class AppResult<T> {
  const AppResult();

  const factory AppResult.success(T value) = AppSuccess<T>;

  const factory AppResult.failure(AppError error) = AppFailure<T>;

  bool get isSuccess => this is AppSuccess<T>;

  bool get isFailure => this is AppFailure<T>;

  T? get valueOrNull {
    final self = this;
    return self is AppSuccess<T> ? self.value : null;
  }

  AppError? get errorOrNull {
    final self = this;
    return self is AppFailure<T> ? self.error : null;
  }

  AppResult<R> mapValue<R>(R Function(T value) mapper) {
    final self = this;
    return switch (self) {
      AppSuccess<T>() => AppResult<R>.success(mapper(self.value)),
      AppFailure<T>() => AppResult<R>.failure(self.error),
    };
  }
}

class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.value);

  final T value;
}

class AppFailure<T> extends AppResult<T> {
  const AppFailure(this.error);

  final AppError error;
}
