import 'package:smart_menu_flutter/src/domain/errors/exception_type.dart';

class GlobalException implements Exception {
  final ExceptionType type;
  final String message;

  GlobalException(this.type, this.message);

  @override
  String toString() => '[${type.name}] $message';
}
