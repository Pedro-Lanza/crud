class User {
  final String? id;
  final String name;
  final String surName;
  final String image;
  final String description;
  final DateTime birth;
  final bool private;
  final List<String> posts;
  // final Integer followers;
  // final Integer following;

  User(
      {this.id,
      required this.name,
      required this.surName,
      required this.image,
      required this.description,
      required this.birth,
      required this.private,
      required this.posts});
}
