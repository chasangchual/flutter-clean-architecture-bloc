import 'dart:convert';

import 'package:clean_archi_chat/src/authentication/data/models/user_model.dart';
import 'package:clean_archi_chat/src/common/exception/exception.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({required String name, required String email});

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDataSourceImplementation implements AuthenticationRemoteDataSource {
  static const String baseUrl = 'https://658c1252859b3491d3f56c86.mockapi.io/api/v1/users';

  late final http.Client _client;

  AuthenticationRemoteDataSourceImplementation(this._client);

  @override
  Future<void> createUser({required String name, required String email}) async {
    // check to make sure that it returns the right data when the response code is 200 or the proper reseponse code

    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final Uri uri = Uri.parse(baseUrl);
    final response = await http.get(uri);
    List<UserModel> userModels = [];

    if (response.statusCode == 200) {
      for (var userJson in jsonDecode(response.body)) {
        userModels.add(UserModel.fromMap(userJson));
      }
      return userModels;
    } else {
      throw APIException(statusCode: response.statusCode, message: response.body);
    }
  }
}
