import 'package:crud/app/fakes/fake_data.dart';
import 'package:crud/app/pages/form/user_form.dart';
import 'package:crud/app/pages/users_list/widgets/user_card.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = {...FAKE_USERS};

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserForm()),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i) => UserCard(user: users.values.elementAt(i)),
      ),
    );
  }
}
