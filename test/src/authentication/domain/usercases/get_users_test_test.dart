import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_archi_chat/src/authentication/domain/usercases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;
  List<User> responses = [
    User(
        id: 1,
        publicId: const Uuid().v4(),
        email: 'sangchual.cha@gmail.com',
        name: 'Sangchual Cha',
        createdAt: DateTime.now())
  ];

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);

    when(() => repository.getUsers()).thenAnswer((_) async => Right(responses));
  });

  test('should call [AuthenticationRepository.getUser] and return [List<User>]', () async {
    final result = await usecase();
    expect(result, equals(Right<dynamic, List<User>>(responses)));

    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
