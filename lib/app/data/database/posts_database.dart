import 'package:crud/app/data/models/posts_entity.dart';
import 'package:hive/hive.dart';

class PostsDatabase {
  Box<Post> getPostBox() => Hive.box('posts');

  void addPost(Post post) {
    getPostBox().put(post.id, post);
  }

  void updatePost(int id, Post post) {
    getPostBox().putAt(id, post);
  }

  void deletePost(int id) {
    getPostBox().delete(id);
  }

  List<Post> getPosts() => getPostBox().values.toList();

  List<Post> getPostsByUser(int? id) => getPostBox().values.where((e) => e.detail == id).toList();
}
