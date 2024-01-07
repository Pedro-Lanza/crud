import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/users_list/widgets/user_card.dart';
import 'package:flutter/material.dart';

class UsersWidget extends StatelessWidget {
  final List<User> users;

  const UsersWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: users.map<Widget>((e) => UserCard(user: e)).toList(),
      ),
    );
  }
}
