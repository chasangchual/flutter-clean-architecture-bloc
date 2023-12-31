import 'dart:convert';

import 'package:clean_archi_chat/src/authentication/data/datasources/authentication_remote_datesource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('retrieve [List<User>]', () async {
    AuthenticationRemoteDataSourceImplementation dataSourceImplementation =
        AuthenticationRemoteDataSourceImplementation(http.Client());
    final users = await dataSourceImplementation.getUsers();
    print(users.toString());
    print(jsonEncode(users));
  });
}
