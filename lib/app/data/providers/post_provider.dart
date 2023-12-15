import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/repository/post_repository.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  PostProvider({required this.repository});
  PostRepository repository; // = PostRepository();

  List<Post> get posts => repository.fetchPosts();

  int get count => repository.fetchPosts().length;

  void addPost(Post post) {
    repository.addPost(post);
    notifyListeners();
  }

  void updatePost(int index, Post post) {
    repository.updatePost(index, post);
    notifyListeners();
  }

  void deletePost(int index) {
    repository.deletePost(index);
    notifyListeners();
  }

  List<Post> getByUser(int id) {
    return repository.fetchPostsByUser(id);
  }

  void deleteByUser(int id) {
    for (Post p in getByUser(id)) {
      repository.deletePost(p.id!);
    }
  }
}
