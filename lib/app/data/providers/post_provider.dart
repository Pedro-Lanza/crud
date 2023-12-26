import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/repository/post_repository.dart';
import 'package:micro_core_result/micro_core_result.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  PostProvider({required this.repository});
  PostRepository repository; // = PostRepository();

  Result<Exception, List<Post>> get posts {
    var request = repository.fetchPosts();
    return request((l) => Left(l), (r) => Right(r));
  }

  Result<Exception, int> get count {
    var request = repository.fetchPosts();
    return request((l) => Left(l), (r) => Right(r.length));
  }

  Result<Exception, Post> addPost(Post post) {
    var request = repository.addPost(post);
    Result<Exception, Post> response = request((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Result<Exception, Post> updatePost(int index, Post post) {
    var request = repository.updatePost(index, post);
    Result<Exception, Post> response = request((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Result<Exception, int> deletePost(int index) {
    var request = repository.deletePost(index);
    Result<Exception, int> response = request((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Result<Exception, List<Post>> getByUser(int id) {
    var request = repository.fetchPostsByUser(id);
    Result<Exception, List<Post>> response = request((l) => Left(l), (r) => Right(r));
    // notifyListeners();
    return response;
  }

  Result<Exception, List<Post>> deleteByUser(int id) {
    var fetchPosts = getByUser(id);
    var posts = fetchPosts((l) => l, (r) => r);
    if (posts is Exception) return Left(posts);

    for (Post p in posts as List<Post>) {
      var request = repository.deletePost(p.id!);
      var confirmRequest = request((l) => l, (r) => true);
      if (confirmRequest != true) return Left(confirmRequest as Exception);
    }
    return Right(posts);
  }
}
