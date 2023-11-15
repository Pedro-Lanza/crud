import 'package:crud/app/models/posts_entity.dart';
import 'package:hive/hive.dart';

class PostsDatabase {
  Box<Post> getPostBox() => Hive.box('posts');

  void addPost(Post post) {
    getPostBox().add(post);
  }

  void updatePost(int index, Post post) {
    getPostBox().putAt(index, post);
  }

  void deletePost(int index) {
    getPostBox().deleteAt(index);
  }

  List<Post> getPosts() => getPostBox().values.toList();

  List<Post> getPostsByUser(int? id) => getPostBox().values.where((e) => e.detail == id).toList();
}
