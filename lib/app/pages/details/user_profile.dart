import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/posts_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late DetailsProvider details;
  late PostProvider posts;
  late User user;
  late Details detail;
  late List<Widget> postList;
  Exception? error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    details = Provider.of(context);
    posts = Provider.of(context, listen: true);
    user = ModalRoute.of(context)!.settings.arguments as User;
    var requestDetails = details.getByUser(user.id!);
    requestDetails((l) {
      setState(() {
        error = l;
      });
    }, (r) {
      setState(() {
        detail = r;
      });
    });
    if (error != null) return;

    var requestPosts = posts.getByUser(detail.id!);
    requestPosts((l) => error = l, (r) {
      setState(() {
        postList = r.map<Widget>(
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: error != null
            ? []
            : [
                IconButton(
                  onPressed: () {
                    posts.addPost(
                      Post(
                        id: postList.length,
                        detail: detail.id!,
                        content: 'new post',
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
      ),
      body: error != null ? displayError() : buildProfile(),
    );
  }

  Widget displayError() {
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

  Widget buildProfile() {
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: (user.image == null)
                      ? const CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 200,
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.image),
                          ),
                        ),
                ),
                const SizedBox(height: 40),
                Text(
                  '${user.name} ${user.surName}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  '${detail?.description}',
                  textAlign: TextAlign.justify,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Birth: ${DateFormat("d/M/y").format(detail!.birth)}'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('Private: '),
                          Checkbox(
                            value: detail.private,
                            onChanged: (val) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(alignment: Alignment.centerLeft, child: Text('Gender: ${detail.gender}')),
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
                child: Text("followers: ${detail.followers}"),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("following: ${detail.following}"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        const Align(child: Text('Posts', style: TextStyle(fontSize: 40))),
        Column(
          children: postList,
        ),
      ],
    );
  }
}
