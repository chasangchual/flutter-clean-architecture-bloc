import 'dart:convert';

import 'package:clean_archi_chat/src/authentication/domain/entities/user.dart';
import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.publicId,
      required super.email,
      required super.name,
      required super.createdAt});

  factory UserModel.fromJson(String json) => UserModel.fromMap(jsonDecode(json));

  UserModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'] is int ? map['id'] : int.parse(map['id']),
          publicId: map['publicId'],
          email: map['email'],
          name: map['name'],
          createdAt: map['createdAt'] is DateTime ? map['createdAt'] : DateTime.parse(map['createdAt']),
        );

  DataMap toMap() {
    return {
      'id': id,
      'publicId': publicId,
      'email': email,
      'name': name,
      'createdAt': createdAt,
    };
  }

  User mapToUser() {
    return User(id: this.id, publicId: this.publicId, email: this.email, name: this.email, createdAt: this.createdAt);
  }

  UserModel copyWith({int? id, String? publicId, String? email, String? name, DateTime? createdAt}) {
    return UserModel(
        id: id ?? this.id,
        publicId: publicId ?? this.publicId,
        email: email ?? this.email,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt);
  }

  String toJsonString() => jsonEncode(toMap());
  DataMap toJson() => toMap();
}
