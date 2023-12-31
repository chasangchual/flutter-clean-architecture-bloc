import 'package:bloc/bloc.dart';
import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/authentication/domain/usercases/create_user.dart';
import 'package:clean_archi_chat/src/authentication/domain/usercases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser _createUser; // CreateUser usecase
  final GetUsers _getUsers; // GetUsers usecase

  AuthenticationBloc({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUsersHandler);
  }

  Future<void> _createUserHandler(CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(email: event.email, name: event.name));
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (_) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUser());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (r) => emit(UserLoaded(users: r)));
  }
}
