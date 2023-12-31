part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String email;
  final String name;

  CreateUserEvent({required this.email, required this.name});

  @override
  List<Object> get props => [email];
}

class GetUserEvent extends AuthenticationEvent {}
