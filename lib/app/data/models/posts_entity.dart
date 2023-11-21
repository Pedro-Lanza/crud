import 'package:hive/hive.dart';

part 'posts_entity.g.dart';

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  int detail;
  @HiveField(2)
  final String content;

  Post({
    this.id,
    required this.detail,
    required this.content,
  });
}
