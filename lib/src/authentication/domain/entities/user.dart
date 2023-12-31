import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String publicId;
  final String email;
  final String name;
  final DateTime createdAt;

  const User(
      {required this.id, required this.publicId, required this.email, required this.name, required this.createdAt});

  @override
  List<Object?> get props => [id, publicId];
}
