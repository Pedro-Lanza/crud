import 'package:crud/app/data/adapters/post_adapter.dart';
import 'package:crud/app/data/database/posts_database.dart';
import 'package:crud/app/data/models/posts_entity.dart';
import 'package:dartz/dartz.dart';

class PostRepository {
  final PostsDatabase db = PostsDatabase();

  Either<Exception, Post> fetchPost(int id) {
    try {
      var postMap = db.getPost(id);
      Post postEntity = PostAdapter.fromMap(postMap!);
      return Right(postEntity);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, List<Post>> fetchPostsByUser(int id) {
    try {
      var postMap = db.getPostsByUser(id);
      List<Post> postEntity = postMap.map((e) => PostAdapter.fromMap(e)).toList();
      return Right(postEntity);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, List<Post>> fetchPosts() {
    try {
      var postsMap = db.getPosts();
      List<Post> postsEntity = postsMap.map((e) => PostAdapter.fromMap(e)).toList();
      return Right(postsEntity);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, Post> addPost(Post post) {
    try {
      var postMap = PostAdapter.toMap(post);
      db.addPost(postMap);
      return Right(post);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, Post> updatePost(int id, Post post) {
    try {
      var postMap = PostAdapter.toMap(post);
      db.updatePost(id, postMap);
      return Right(post);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, int> deletePost(int id) {
    try {
      db.deletePost(id);
      return Right(id);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, int> deleteByUser(int id) {
    try {
      var fetchPosts = fetchPostsByUser(id);
      var posts = fetchPosts.fold((l) => null, (r) => r);
      if (posts == null) throw Exception();

      for (Post p in posts) {
        db.deletePost(p.id!);
      }
      return Right(id);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }
}
