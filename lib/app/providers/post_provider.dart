import 'package:crud/app/database/posts_database.dart';
import 'package:crud/app/models/posts_entity.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  PostsDatabase db = PostsDatabase();

  List<Post> get posts => db.getPosts();

  int get count => db.getPosts().length;

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

  List<Post> getByUser(int? id) {
    return db.getPostsByUser(id);
  }

  void deleteByUser(int? id) {
    for (Post p in getByUser(id)) {
      db.deletePost(p.id!);
    }
  }
}
