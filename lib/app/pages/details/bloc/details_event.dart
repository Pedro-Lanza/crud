import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';

abstract class DetailsEvent {}

class FetchDetails extends DetailsEvent {
  User user;

  FetchDetails(this.user);
}

class FetchPosts extends DetailsEvent {
  User user;
  FetchPosts(this.user);
}

class AddPost extends DetailsEvent {
  Post post;
  User user;
  AddPost(this.post, this.user);
}
