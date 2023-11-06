import 'package:crud/app/models/user.dart';
import 'package:crud/app/pages/details/user_profile.dart';
import 'package:crud/app/pages/form/user_form.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => UserProfile()),
          //     );
          //   },
          //   child: (user.image == null || user.image.isEmpty)
          //       ? const CircleAvatar(
          //           child: Icon(Icons.person),
          //         )
          //       : CircleAvatar(
          //           backgroundImage: NetworkImage(user.image),
          //         ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => UserProfile()),
          //     );
          //   },
          //   child: Expanded(
          //     child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [const SizedBox(height: 20), Text("${user.name} ${user.surName}"), SizedBox(height: 60, child: Text(user.description))]),
          //   ),
          // ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (user.image == null || user.image.isEmpty)
                      ? const CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [const SizedBox(height: 20), Text("${user.name} ${user.surName}"), SizedBox(height: 60, child: Text(user.description))],
                  ),
                  Text("10"),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserForm()),
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
