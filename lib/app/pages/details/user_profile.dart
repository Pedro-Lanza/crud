import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/details/bloc/details_event.dart';
import 'package:crud/app/pages/details/bloc/details_state.dart';
import 'package:crud/app/pages/details/widgets/error_widget.dart';
import 'package:crud/app/pages/details/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.detailsBloc, required this.postsBloc});
  final DetailsBloc detailsBloc;
  final PostsBloc postsBloc;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late User user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments as User;
    widget.detailsBloc.add(FetchDetails(user));
    widget.postsBloc.add(FetchPosts(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          return switch (state) {
            LoadingDetails() => const CircularProgressIndicator(),
            LoadedDetails() => ProfileWidget(user: state.user, detail: state.details),
            ErrorDetails() => ProfileErrorWidget(error: state.error),
          };
        },
      ),
    );
  }

  // Widget displayError() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Align(
  //         alignment: Alignment.center,
  //         child: Text(
  //           error.toString(),
  //           style: const TextStyle(color: Colors.red, fontSize: 16),
  //         ),
  //       ),
  //       ElevatedButton(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //         child: const Text('Retry'),
  //       ),
  //     ],
  //   );
  // }
}
