import 'package:crud/app/data/adapters/post_adapter.dart';
import 'package:crud/app/data/database/posts_database.dart';
import 'package:crud/app/data/models/posts_entity.dart';

class PostRepository {
  final PostsDatabase db = PostsDatabase();

  Post fetchPost(int id) {
    var postMap = db.getPost(id);
    Post postEntity = PostAdapter.fromMap(postMap!);
    return postEntity;
  }

  List<Post> fetchPostsByUser(int id) {
    var postMap = db.getPostsByUser(id);
    List<Post> postEntity = postMap.map((e) => PostAdapter.fromMap(e)).toList();
    return postEntity;
  }

  List<Post> fetchPosts() {
    var postsMap = db.getPosts();
    List<Post> postsEntity = postsMap.map((e) => PostAdapter.fromMap(e)).toList();
    return postsEntity;
  }

  void addPost(Post post) {
    var postMap = PostAdapter.toMap(post);
    db.addPost(postMap);
  }

  void updatePost(int id, Post post) {
    var postMap = PostAdapter.toMap(post);
    db.updatePost(id, postMap);
  }

  void deletePost(int id) {
    db.deletePost(id);
  }

  void deleteByUser(int id) {
    for (Post p in fetchPostsByUser(id)) {
      db.deletePost(p.id!);
    }
  }
}
