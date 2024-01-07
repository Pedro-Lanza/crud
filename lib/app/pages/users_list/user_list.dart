import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_bloc.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_event.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_state.dart';
import 'package:crud/app/pages/users_list/widgets/error_widget.dart';
import 'package:crud/app/pages/users_list/widgets/users_widget.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_core_result/micro_core_result.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key, required this.bloc});
  final ListBloc bloc;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late UserProvider users;
  late Result<Exception, List<User>> request;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.bloc.add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.form).then(
                    (value) => widget.bloc.add(FetchUsers()),
                  );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocListener<ListBloc, ListState>(
        listener: (context, state) async {
          if (state is SuccessList) {
            widget.bloc.add(FetchUsers());
          }
          if (state is DialogList) {
            await _showErrorDialog(context, state.error.toString());
          }
        },
        bloc: widget.bloc,
        child: BlocBuilder<ListBloc, ListState>(builder: (context, state) {
          return switch (state) {
            LoadingList() || SuccessList() || DialogList() => const CircularProgressIndicator(),
            LoadedList() => UsersWidget(users: state.users),
            ErrorList() => ListErrorWidget(error: state.error),
          };
        }),
      ),
    );
  }

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tentar Novamente'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
