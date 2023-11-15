import 'package:crud/app/pages/users_list/widgets/user_card.dart';
import 'package:crud/app/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider users = Provider.of(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.form, arguments: null);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => UserForm()),
              // );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserCard(user: users.getById(i)),
      ),
    );
  }
}
