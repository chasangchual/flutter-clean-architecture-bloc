import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<void> createUser({required String email, required String name});
  ResultFuture<List<User>> getUsers();
}
