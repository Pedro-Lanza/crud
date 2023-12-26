import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/users_list/widgets/user_card.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:micro_core_result/micro_core_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    users = Provider.of(context, listen: true);

    var rqst = users.users;
    setState(() {
      request = rqst;
    });
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
        child: request(
          (l) => displayError(l),
          (r) => Column(
            children: r.map<Widget>((e) => UserCard(user: e)).toList(),
          ),
        ),
        // child: Column(
        //   children: users.users.map<Widget>((e) => UserCard(user: e)).toList(),
        // ),
      ),
      // body: ListView.builder(
      //   itemCount: users.count,
      //   itemBuilder: (ctx, i) => UserCard(user: users.userlist.elementAt(i)),
      // ),
    );
  }

  Widget displayError(Exception error) {
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
            var rqst = users.users;
            setState(() {
              request = rqst;
            });
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
