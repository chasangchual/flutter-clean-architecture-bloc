import 'package:clean_archi_chat/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_archi_chat/src/authentication/domain/usercases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// What does the class depend on?
// How can we create a fake version of dependency?
// How do we control what our dependency in?
// using Mocktail

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = CreateUser(repository);

    when(() {
      return repository.createUser(email: any(named: 'email'), name: any(named: 'name'));
    }).thenAnswer((_) async => const Right(null)); // Right/Left from Either of dartx. we put 'null' in returning void
  });

  test('should call [Repository.createUser]', () async {
    // given (arranges)
    CreateUserParams params = const CreateUserParams(email: 'sangchual.cha@gmail.com', name: 'Sangchual CHA');

    // when(act)
    final result = await usecase(params);

    // then(assert)
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(() => repository.createUser(email: 'sangchual.cha@gmail.com', name: 'Sangchual CHA')).called(1);
    verifyNoMoreInteractions(repository);
  });
}
