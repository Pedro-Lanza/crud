import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/details/bloc/details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileErrorWidget extends StatelessWidget {
  final Exception error;

  const ProfileErrorWidget(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}

class PostsErrorWidget extends StatelessWidget {
  final User user;
  final Exception error;
  const PostsErrorWidget(this.error, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<PostsBloc>().add(FetchPosts(user));
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
