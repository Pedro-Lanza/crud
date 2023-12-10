import 'package:hive/hive.dart';

class PostsDatabase {
  Box<Map<dynamic, dynamic>> getPostBox() => Hive.box('posts');

  void addPost(Map<String, dynamic> post) {
    getPostBox().put(post['id'], post);
  }

  void updatePost(int id, Map<String, dynamic> post) {
    getPostBox().putAt(id, post);
  }

  void deletePost(int id) {
    getPostBox().delete(id);
  }

  Map<dynamic, dynamic>? getPost(int id) {
    return getPostBox().get(id);
  }

  List<Map<dynamic, dynamic>> getPosts() => getPostBox().values.toList();

  List<Map<dynamic, dynamic>> getPostsByUser(int? id) => getPostBox().values.where((e) => e['detail'] == id).toList();
}
