import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/repository/post_repository.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  PostRepository db = PostRepository();

  List<Post> get posts => db.fetchPosts();

  int get count => db.fetchPosts().length;

  void addPost(Post post) {
    db.addPost(post);
    notifyListeners();
  }

  void updatePost(int index, Post post) {
    db.updatePost(index, post);
    notifyListeners();
  }

  void deletePost(int index) {
    db.deletePost(index);
    notifyListeners();
  }

  List<Post> getByUser(int id) {
    return db.fetchPostsByUser(id);
  }

  void deleteByUser(int id) {
    for (Post p in getByUser(id)) {
      db.deletePost(p.id!);
    }
  }
}
