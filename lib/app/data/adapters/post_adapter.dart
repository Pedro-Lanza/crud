import 'package:crud/app/data/models/posts_entity.dart';

class PostAdapter {
  PostAdapter();

  static Post fromMap(Map<dynamic, dynamic> map) {
    return Post(
      id: map['id'],
      detail: map['detail'],
      content: map['content'],
    );
  }

  static Map<String, dynamic> toMap(Post post) {
    return {
      'id': post.id,
      'detail': post.detail,
      'content': post.content,
    };
  }
}
