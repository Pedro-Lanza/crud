import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';

sealed class DetailsState {}

sealed class PostsState {}

final class LoadingDetails extends DetailsState {}

final class ErrorDetails extends DetailsState {
  Exception error;
  ErrorDetails(this.error);
}

final class LoadedDetails extends DetailsState {
  User user;
  Details details;
  LoadedDetails(this.user, this.details);
}

final class LoadingPosts extends PostsState {}

final class LoadedPosts extends PostsState {
  User user;
  List<Post> posts;
  LoadedPosts(this.posts, this.user);
}

final class ErrorPosts extends PostsState {
  User user;
  Exception error;
  ErrorPosts(this.user, this.error);
}

final class SuccessPost extends PostsState {}
