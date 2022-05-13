import 'package:humble_sand/core/base/model/base_exception.dart';

class NoConnectivityException extends BaseException {
  @override
  final String errorCode;

  @override
  final String message;

  NoConnectivityException({
    required this.message,
    this.errorCode = "",
  });
}
