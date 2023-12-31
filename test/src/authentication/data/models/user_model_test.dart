import 'dart:convert';

import 'package:clean_archi_chat/src/authentication/data/models/user_model.dart';
import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  var usersJson = '''[
  {
    "createdAt": "2023-12-26T23:59:03.999Z",
    "name": "Sabrina Kemmer",
    "email": "Heloise.Schmitt@hotmail.com",
    "publicId": "f10379dc-6877-4dd2-bde5-82c743b1106f",
    "id": "1"
  },
  {
    "createdAt": "2023-12-27T00:30:19.451Z",
    "name": "Mary Hilpert",
    "email": "Wyatt39@hotmail.com",
    "publicId": "0577704c-7421-42c9-978f-cbac60af378d",
    "id": "2"
  },
  {
    "createdAt": "2023-12-27T06:51:08.621Z",
    "name": "Mr. Tricia Bartoletti",
    "email": "Richie_Parker@yahoo.com",
    "publicId": "8029e09f-ea9c-4876-bafe-ff030eaab134",
    "id": "3"
  },
  {
    "createdAt": "2023-12-26T20:07:33.638Z",
    "name": "Cecelia Johns",
    "email": "Arnoldo_OHara78@gmail.com",
    "publicId": "e9835807-1370-4dc4-aa40-081434ccd3e6",
    "id": "4"
  }
]''';

  final String userJson = fixture('user.json');
  final DataMap userMap = jsonDecode(userJson) as DataMap;

  setUp(() {});

  test('should be a subclass of [User] entity', () {
    var modelFromJson = UserModel.fromJson(userJson);
    var modelFromMap = UserModel.fromMap(modelFromJson.toMap());

    expect(modelFromJson, isA<User>());
    expect(modelFromJson, equals(modelFromMap));
  });
}
