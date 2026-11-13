import 'package:gutsynced/helpers/services/logger.dart';

class AppError extends Error {
  final String message;
  final String? code;
  final Object? originalError;

  AppError(this.message, {this.code, this.originalError});

  @override
  String toString() => 'AppError($code): $message';
}

class ErrorHandler {
  static void handle(Object error, StackTrace? stackTrace) {
    Logger().error('Unhandled: $error', error, stackTrace);
  }

  static String userFriendlyMessage(Object error) {
    if (error is AppError) return error.message;
    return 'Something went wrong. Please try again.';
  }
}
