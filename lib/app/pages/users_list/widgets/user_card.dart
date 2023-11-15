import 'package:crud/app/models/user_entity.dart';
import 'package:crud/app/pages/details/user_profile.dart';
import 'package:crud/app/pages/form/user_form.dart';
import 'package:crud/app/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final User? user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final UserProvider users = Provider.of(context, listen: false);

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.details, arguments: user);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => UserProfile()),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (user!.image == null || user!.image.isEmpty)
                      ? const CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(user!.image),
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [const SizedBox(height: 20), Text("${user!.name} ${user!.surName}"), const SizedBox(height: 60, child: Text(''))],
                  ),
                  Text("${user!.id}"),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.form, arguments: user);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => UserForm()),
                    // );
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
                            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('não')),
                            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('sim')),
                          ],
                        );
                      },
                    ).then((value) {
                      if (value) users.deleteUser(user!.id!);
                    });
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
