import 'package:crud/app/pages/users_list/widgets/user_card.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late UserProvider users;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    users = Provider.of(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.form);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: users.users.map<Widget>((e) => UserCard(user: e)).toList(),
        ),
      ),
      // body: ListView.builder(
      //   itemCount: users.count,
      //   itemBuilder: (ctx, i) => UserCard(user: users.userlist.elementAt(i)),
      // ),
    );
  }
}
