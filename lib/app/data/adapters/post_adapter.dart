import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/utils/app_mapper.dart';

class PostAdapter {
  PostAdapter();

  static Post fromMap(Map<dynamic, dynamic> map) {
    return Post(
      id: AppMapper.parse('id', () => map['id']),
      detail: AppMapper.parse('detail', () => map['detail']),
      content: AppMapper.parse('content', () => map['content']),
    );
  }

  static Map<String, dynamic> toMap(Post post) {
    return {
      'id': AppMapper.parse('id', () => post.id),
      'detail': AppMapper.parse('detail', () => post.detail),
      'content': AppMapper.parse('content', () => post.content),
    };
  }
}
