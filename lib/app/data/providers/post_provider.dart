import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/repository/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  PostProvider({required this.repository});
  PostRepository repository; // = PostRepository();

  Either<Exception, List<Post>> get posts {
    var request = repository.fetchPosts();
    return request.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Exception, int> get count {
    var request = repository.fetchPosts();
    return request.fold((l) => Left(l), (r) => Right(r.length));
  }

  Either<Exception, Post> addPost(Post post) {
    var request = repository.addPost(post);
    Either<Exception, Post> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, Post> updatePost(int index, Post post) {
    var request = repository.updatePost(index, post);
    Either<Exception, Post> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, int> deletePost(int index) {
    var request = repository.deletePost(index);
    Either<Exception, int> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, List<Post>> getByUser(int id) {
    var request = repository.fetchPostsByUser(id);
    Either<Exception, List<Post>> response = request.fold((l) => Left(l), (r) => Right(r));
    // notifyListeners();
    return response;
  }

  Either<Exception, List<Post>> deleteByUser(int id) {
    var fetchPosts = getByUser(id);
    var posts = fetchPosts.fold((l) => l, (r) => r);
    if (posts is Exception) return Left(posts);

    for (Post p in posts as List<Post>) {
      var request = repository.deletePost(p.id!);
      var confirmRequest = request.fold((l) => l, (r) => true);
      if (confirmRequest != true) return Left(confirmRequest as Exception);
    }
    return Right(posts);
  }
}
