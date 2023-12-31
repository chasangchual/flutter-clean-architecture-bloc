import 'dart:convert';

import 'package:clean_archi_chat/src/authentication/data/datasources/authentication_remote_datesource.dart';
import 'package:clean_archi_chat/src/authentication/data/models/user_model.dart';
import 'package:clean_archi_chat/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/common/exception/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockAuthenticationRemoteDataSource extends Mock implements AuthenticationRemoteDataSource {}

void main() {
  late MockAuthenticationRemoteDataSource dataSource;
  late AuthenticationRepositoryImplementation authenticationRepositoryImplementation;

  setUp(() {
    dataSource = MockAuthenticationRemoteDataSource();
    authenticationRepositoryImplementation = AuthenticationRepositoryImplementation(dataSource);
  });

  group('createUser', () {
    test(
        'should call the [RemoteDataSource.createUser] and '
        'complete successfully when the call to the remote source is successful', () async {
      // given
      when(() => dataSource.createUser(name: any(named: 'name'), email: any(named: 'email')))
          .thenAnswer((_) async => Future.value());

      // when
      final result = await authenticationRepositoryImplementation.createUser(email: "test@test.com", name: "test");
      // then
      expect(result, equals(const Right(null)));

      verify(() => dataSource.createUser(name: 'test', email: 'test@test.com')).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should return [ServerFailure] when a call to the remote source is unsuccessful', () async {
      // given
      when(() => dataSource.createUser(name: any(named: 'name'), email: any(named: 'email')))
          .thenThrow(const APIException(statusCode: 500, message: 'Internal Server Error'));

      // when
      final result = await authenticationRepositoryImplementation.createUser(email: "test@test.com", name: "test");

      // then
      expect(result, equals(const Left(ApiFailure(statusCode: 500, message: 'Internal Server Error'))));
      verify(() => dataSource.createUser(name: 'test', email: 'test@test.com')).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should call the [DataSource.getUsers] and return [List<User>] when call to the remote source is successful',
        () async {
      List<UserModel> userModels = [];
      List<User> users = [];

      for (var userJson in jsonDecode(fixture('users.json'))) {
        UserModel userModel = UserModel.fromMap(userJson);

        userModels.add(userModel);
        users.add(userModel.mapToUser());
      }

      // given
      when(() => dataSource.getUsers()).thenAnswer((_) async => userModels);

      // when
      final result = await authenticationRepositoryImplementation.getUsers();

      // then
      expect(result, isA<Right<Failure, List<User>>>());
      expect(result.getOrElse(() => []), equals(users));
      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should return [ServerFailure] when a [getUser] call to the remote datasource is unsuccessful', () async {
      // given
      when(() => dataSource.getUsers())
          .thenThrow(const APIException(statusCode: 500, message: 'Internal Server Error'));

      // when
      final result = await authenticationRepositoryImplementation.getUsers();

      // then
      expect(result, equals(const Left(ApiFailure(statusCode: 500, message: 'Internal Server Error'))));
      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
