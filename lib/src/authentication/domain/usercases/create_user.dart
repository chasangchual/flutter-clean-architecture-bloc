import 'package:clean_archi_chat/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';
import 'package:clean_archi_chat/src/common/typedef/usecase.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;
  const CreateUser(this._repository);

  @override
  ResultFuture call(CreateUserParams params) async => _repository.createUser(email: params.email, name: params.name);
}

class CreateUserParams extends Equatable {
  final String email;
  final String name;

  @override
  List<Object?> get props => [email, name];

  const CreateUserParams({required this.email, required this.name});
}
