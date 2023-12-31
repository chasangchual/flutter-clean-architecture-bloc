import 'package:clean_archi_chat/src/authentication/data/datasources/authentication_remote_datesource.dart';
import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_archi_chat/src/common/exception/exception.dart';
import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _dataSource;

  const AuthenticationRepositoryImplementation(this._dataSource);

  @override
  ResultFuture<void> createUser({required String email, required String name}) async {
    // test driven development
    // call the remote data source
    // check if the method return proper data
    // make sure that it returns the proper data if there is no exception.
    // check if when the remoteDataSource throws an exception, we returns a failure and if it doesn't throw and exception,
    // we return the actual expected data
    try {
      await _dataSource.createUser(name: name, email: email);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final results = await _dataSource.getUsers();
      List<User> users = [];
      for (var result in results) {
        users.add(result.mapToUser());
      }
      return Right(users);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
