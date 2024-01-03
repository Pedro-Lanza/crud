import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/details/widgets/error_widget.dart';
import 'package:crud/app/pages/details/widgets/posts_widget.dart';
import 'package:crud/app/pages/details/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

abstract class DetailsState {
  Widget render();
}

class LoadingDetails extends DetailsState {
  @override
  Widget render() {
    return const CircularProgressIndicator();
  }
}

class ErrorDetails extends DetailsState {
  Exception error;
  ErrorDetails(this.error);

  @override
  Widget render() {
    return ProfileErrorWidget(error);
  }
}

class LoadedDetails extends DetailsState {
  User user;
  Details details;
  LoadedDetails(this.user, this.details);

  @override
  Widget render() {
    return ProfileWidget(user: user, detail: details);
  }
}

class LoadingPosts extends DetailsState {
  @override
  Widget render() {
    return const Column(
      children: [
        Align(child: Text('Posts', style: TextStyle(fontSize: 40))),
        SizedBox(
          height: 50,
        ),
        CircularProgressIndicator(),
      ],
    );
  }
}

class LoadedPosts extends DetailsState {
  User user;
  List<Post> posts;
  LoadedPosts(this.posts, this.user);

  @override
  Widget render() {
    return PostsWidget(posts, user);
  }
}

class ErrorPosts extends DetailsState {
  User user;
  Exception error;
  ErrorPosts(this.user, this.error);

  @override
  Widget render() {
    return PostsErrorWidget(error, user);
  }
}
