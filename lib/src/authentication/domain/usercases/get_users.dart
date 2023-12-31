import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';
import 'package:clean_archi_chat/src/common/typedef/usecase.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;

  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
