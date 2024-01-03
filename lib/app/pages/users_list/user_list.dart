import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_bloc.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_event.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_state.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_core_result/micro_core_result.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late UserProvider users;
  late Result<Exception, List<User>> request;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ListBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("User Management"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.form).then(
                        (value) => context.read<ListBloc>().add(FetchUsers()),
                      );
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: state.render(),
        );
      },
    );
  }
}
