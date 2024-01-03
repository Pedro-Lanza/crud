import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/details/bloc/details_event.dart';
import 'package:crud/app/pages/details/bloc/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
    user = ModalRoute.of(context)!.settings.arguments as User;
    context.read<DetailsBloc>().add(FetchDetails(user));
    context.read<PostsBloc>().add(FetchPosts(user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: state.render(),
      ),
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
}
