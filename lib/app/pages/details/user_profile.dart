import 'package:crud/app/models/posts_entity.dart';
import 'package:crud/app/models/user_entity.dart';
import 'package:crud/app/providers/details_provider.dart';
import 'package:crud/app/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailsProvider details = Provider.of(context);
    final PostProvider posts = Provider.of(context, listen: true);
    final user = ModalRoute.of(context)!.settings.arguments as User?;
    final detail = details.getByUser(user!.id!);
    // List<Post> ps

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              posts.addPost(
                Post(id: posts.count, detail: detail!.id!, content: 'new post'),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person, size: 200),
                  ),
                  const SizedBox(height: 40),
                  Text('${user.name} ${user.surName}', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text(
                    '${detail?.description}',
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Birth: ${detail?.birth}'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [const Text('Private: '), Checkbox(value: detail!.private, onChanged: (val) {})],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("followers: ${detail?.followers}"),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("following: ${detail?.following}"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Align(child: Text('Posts', style: TextStyle(fontSize: 40))),
          Column(
            children: posts.getByUser(detail.id).map<Widget>(
              (e) {
                return Container(
                  constraints: const BoxConstraints(minHeight: 100, minWidth: double.infinity),
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
            ).toList(),
          ),
        ],
      ),
    );
  }
}