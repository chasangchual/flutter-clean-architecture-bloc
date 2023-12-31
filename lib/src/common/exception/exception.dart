import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});
  String get errorMessage => 'status: $statusCode, meessage: $message';
  @override
  List<Object> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.statusCode, required super.message});

  factory ApiFailure.fromException(APIException exception) {
    return ApiFailure(statusCode: exception.statusCode, message: exception.message);
  }
}

class APIException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const APIException({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}
