import 'package:crud/app/pages/users_list/bloc/userslist_bloc.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_event.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class ListErrorWidget extends StatelessWidget {
  const ListErrorWidget({super.key, required this.error});
  final Exception error;

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
            getIt<ListBloc>().add(FetchUsers());
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
