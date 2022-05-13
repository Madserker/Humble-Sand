import 'package:humble_sand/core/base/exceptions/no_conectivity_exception.dart';
import 'package:humble_sand/core/base/model/base_exception.dart';

abstract class Result<T> {
  R whenWithResult<R>(
    R Function(Success<T>) success,
    R Function(Error) error,
  ) {
    if (this is Success<T>) {
      return success(this as Success<T>);
    } else if (this is Error) {
      return error(this as Error);
    } else {
      throw NoConnectivityException(
        message: 'Default ConnectivityException',
      );
    }
  }
}

class Success<T> extends Result<T> {
  final T value;
  Success(this.value);
}

class Error<T> extends Result<T> {
  final BaseException exception;

  Error(this.exception);
}
