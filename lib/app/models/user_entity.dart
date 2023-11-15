import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String surName;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final int details;
  // final String description;
  // final DateTime birth;
  // final bool private;
  // final List<String> posts;
  // final Integer followers;
  // final Integer following;

  User({
    this.id,
    required this.name,
    required this.surName,
    required this.image,
    required this.details,
    // required this.description,
    // required this.birth,
    // required this.private,
    // required this.posts,
  });
}
