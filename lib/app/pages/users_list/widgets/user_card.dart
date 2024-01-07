import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_bloc.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_event.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  // late UserProvider users;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // users = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.details,
                  arguments: widget.user,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // (user!.image == null || user!.image.isEmpty)
                  (widget.user.image.isEmpty)
                      ? const CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(widget.user.image),
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text("${widget.user.name} ${widget.user.surName}"),
                      const SizedBox(height: 60, child: Text('')),
                    ],
                  ),
                  Text("${widget.user.id}"),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(
                          AppRoutes.form,
                          arguments: widget.user,
                        )
                        .then(
                          (value) => context.read<ListBloc>().add(FetchUsers()),
                        );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('excluir usuário'),
                        content: const Text('certeza?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('não'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('sim'),
                          ),
                        ],
                      );
                    },
                  ).then(
                    (value) {
                      if (value) {
                        context.read<ListBloc>().add(DeleteUser(context, widget.user.id!));
                        // var request = users.deleteUser(widget.user.id!);
                        // request((l) async => await _showErrorDialog(context, l.toString()), (r) => null);
                      }
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
