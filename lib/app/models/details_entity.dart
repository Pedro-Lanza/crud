import 'package:crud/app/models/posts_entity.dart';
import 'package:hive/hive.dart';

part 'details_entity.g.dart';

@HiveType(typeId: 1)
class Details extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int user;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime birth;
  @HiveField(4)
  final bool private;
  @HiveField(5)
  int followers = 0;
  @HiveField(6)
  int following = 0;
  @HiveField(7)
  List<int> posts = [];

  Details({
    this.id,
    required this.user,
    required this.description,
    required this.birth,
    required this.private,
  });
}
