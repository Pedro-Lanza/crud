import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/details/bloc/details_event.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class PostsWidget extends StatelessWidget {
  final User user;
  final List<Post> postList;
  const PostsWidget({super.key, required this.user, required this.postList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Posts', style: TextStyle(fontSize: 40)),
            IconButton(
              onPressed: () {
                getIt<PostsBloc>().add(
                  AddPost(
                    Post(
                      id: postList.length,
                      detail: user.id!,
                      content: 'new post',
                    ),
                    user,
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        // const Align(child: Text('Posts', style: TextStyle(fontSize: 40))),
        ..._postsWidgets(postList),
      ],
    );
  }

  List<Widget> _postsWidgets(List<Post> posts) {
    return posts.map<Widget>(
      (e) {
        return Container(
          constraints: const BoxConstraints(
            minHeight: 100,
            minWidth: double.infinity,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                e.content,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    ).toList();
  }
}
