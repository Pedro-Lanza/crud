import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/details/bloc/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final Details detail;

  const ProfileWidget({super.key, required this.user, required this.detail});

  @override
  Widget build(BuildContext context) {
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
                  detail.description,
                  textAlign: TextAlign.justify,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Birth: ${DateFormat("d/M/y").format(detail.birth)}'),
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
        BlocBuilder<PostsBloc, DetailsState>(
          builder: (context, state) => state.render(),
        ),
      ],
    );
  }
}
